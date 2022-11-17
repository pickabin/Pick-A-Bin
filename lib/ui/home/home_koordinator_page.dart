import 'package:boilerplate/controllers/count_petugas_controller.dart';
import 'package:boilerplate/controllers/jadwal_controller.dart';
import 'package:boilerplate/controllers/koor_gedung_controller.dart';
import 'package:boilerplate/ui/help/help_koordinator.dart';
import 'package:boilerplate/ui/home/area_id.dart';
import 'package:boilerplate/ui/home/saran_masukan.dart';
import 'package:boilerplate/ui/notifikasi/notifikasi.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeKoordinatorPage extends StatefulWidget {
  const HomeKoordinatorPage({Key? key}) : super(key: key);

  @override
  State<HomeKoordinatorPage> createState() => _HomeKoordinatorPageState();
}

class _HomeKoordinatorPageState extends State<HomeKoordinatorPage> {
  //lebar dan tinggi layar
  String? code;
  int? countPetugas;
  int? listDone;
  double? hasil;
  // final ref = FirebaseDatabase.instance
  //     .ref()
  //     .child('jadwal')
  //     .orderByChild('date')
  //     .equalTo(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString())
  //     .limitToLast(4);
  // File? _image;
  // String? fileName;

  int _activeIndex = 0;
  final imageAsset = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png'
  ];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      //return data from user code
      KoorGedungController().getKoorGedungCode().then((value) {
        setState(() {
          //input
          print("Ini value" + value.toString());
          code = value;
        });
      }).then((value) {
        if (code == null) {
          //show dialog
          showDialog(
            context: this.context,
            builder: (context) {
              return AlertDialog(
                content: AreaId(
                  code: code,
                ),
              );
            },
          );
        }
      });
    });

    KoorGedungController().getKoorByUid().then((value) {
      //looping nilai value
      for (var i = 0; i < value.length; i++) {
        //input
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt('user_id', value[i].user.id);
        });
        print("Ini value userid pref" + value[i].user.id.toString());
      }
    }).then((value) {
      CountPetugasController().getStatusPetugas().then((value) {
        setState(() {
          countPetugas = value!.petugas;
          listDone = value.listDone;
          hasil = listDone! / countPetugas!;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //prefs count petugas
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //lebar dan tinggi layar
    // double width = MediaQuery.of(context).size.width * 0.9;
    // double height = MediaQuery.of(context).size.height*0.2;
    // print(width);
    // print("tinggi" + height.toString());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          //Bagian paling atas form,logo dan notifikasi
          FutureBuilder(
            future: KoorGedungController().getKoorByUid(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      SharedPreferences.getInstance().then((prefs) {
                        // prefs.setInt('user_id', snapshot.data[index].user.id);
                        prefs.setInt("koor_id", snapshot.data[index].id);
                        prefs.setString('code', snapshot.data[index].code);
                      });
                      code = snapshot.data[index].code;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Image.asset(
                                  "assets/images/group_logo.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.200,
                                  height: 100,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    backgroundColor: Colors.white,
                                    context: context,
                                    builder: (_) {
                                      return FractionallySizedBox(
                                        heightFactor: 0.9,
                                        child: AreaId(
                                          code: snapshot.data[index].code,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 2),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    width: MediaQuery.of(context).size.width *
                                        0.600,
                                    height: 45,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 50.0),
                                          child: Center(
                                              //get data
                                              child: snapshot
                                                          .data[index].code !=
                                                      null
                                                  ? Text(
                                                      snapshot.data[index].code)
                                                  : Text("Masukkan Code")),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        SizedBox(width: 15)
                                      ],
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Stack(children: [
                                  //Notification
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Notifikasi()));
                                    },
                                    icon: Icon(
                                      Icons.notifications,
                                      color: Colors.black45,
                                      size: 32,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                      child: Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          ),
                          //Bagian 2, nama petugas
                          Container(
                            margin:
                                EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  child: snapshot.data[index].user.photo != null
                                      ? CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              snapshot.data[index].user.photo),
                                        )
                                      : Image.asset(
                                          "assets/images/grup_logo2.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.17,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                        ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          snapshot.data[index].user.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          //space between cleaning service dan petugas
                                          children: [
                                            Text(
                                              "Cleaning Service",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                            ),
                                            Text(
                                              "Koordinator",
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.68,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black38,
                                                width: 1.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GFProgressBar(
                                            percentage:
                                                hasil == null ? 0 : hasil!,
                                            lineHeight: 20,
                                            backgroundColor: Colors.grey,
                                            progressBarColor: Colors.green,
                                            child: Center(
                                                child: listDone != null
                                                    ? Text(
                                                        listDone.toString() +
                                                            "/" +
                                                            countPetugas
                                                                .toString() +
                                                            " Petugas",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12))
                                                    : listDone == 0
                                                        ? Text("0 / " +
                                                            "0" +
                                                            " Petugas")
                                                        : Text("Loading...")),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: Stack(
                              children: [
                                //image full screen
                                // Container(
                                //   //image
                                //   height: MediaQuery.of(context).size.height * 0.180,
                                //   width: MediaQuery.of(context).size.width * 0.9,
                                //   //image with radius
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     image: DecorationImage(
                                //       image: AssetImage(
                                //         'assets/images/slide3.jpg',
                                //       ),
                                //       fit: BoxFit.cover,
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 5),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.lightGreen,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SaranMasukan();
                                            });
                                      },
                                      child: Text("Lihat Detail"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                          "assets/images/aspiration.png",
                                          width: 115,
                                          height: 115)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 90, bottom: 50),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 200,
                                        child: Text(
                                          "Sampaikan aspirasi Anda !\nAnda dapat menyampaikan saran dan masukan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          maxLines: 3,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                return Column(
                  children: [
                    ListTileShimmer(),
                    ListTileShimmer(),
                    ListTileShimmer(),
                  ],
                );
              }
            },
          ),

          Container(
            child: CarouselSlider.builder(
              itemCount: imageAsset.length,
              options: CarouselOptions(
                height: 120.0,
                viewportFraction: 0.9,
                aspectRatio: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 8),
                onPageChanged: (index, reason) {
                  setState(() {
                    _activeIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return _buildImage(imageAsset, index);
              },
            ),
          ),
          HelpKoordinator(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18, right: 18),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 1.4, color: Color(0xFF66E8A9)),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Tugas Terkini",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FutureBuilder(
                      future: JadwalController().getJadwal(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        snapshot.data[index].cleanArea +
                                            "-" +
                                            "PENS",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: snapshot.data[index].status ==
                                              "0"
                                          ? Text("Belum dibersihkan")
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  "Sudah dibersihkan",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                      leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                        "assets/images/building_icon.png",
                                      )),
                                      trailing: Text(DateFormat('dd MMMM yyyy')
                                          .format(DateTime.parse(snapshot
                                              .data[index].updatedAt
                                              .toString()))),
                                    )
                                  ],
                                );
                              });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                      // child: Text(
                      //   "Jadwal Harian",
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 16.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1)
        ]),
      ),
    );
  }

  Widget _buildImage(List<String> imageAsset, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage(
                imageAsset[index],
              ),
              fit: BoxFit.cover)),
    );
  }
}
