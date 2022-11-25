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
    Future.delayed(Duration(seconds: 2)).then((_) {
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
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/images/group_logo.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.200,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
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
                                      backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                      context: context,
                                      builder: (_) {
                                        return FractionallySizedBox(
                                          heightFactor: 0.9,
                                          child: AreaId(
                                            code: code,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text("PENS",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 10,
                                        )),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 13),
                                  alignment: Alignment.centerRight,
                                  child: Stack(children: [
                                    //Notification
                                    IconButton(
                                      onPressed: () {},
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
                          ),
                          //Bagian 2, nama petugas
                          Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 88,
                            decoration: BoxDecoration(
                                color: Color(0xFF004C58),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 5),
                                      blurRadius: 10)
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 6),
                                  child: snapshot.data[index].user.photo != null
                                      ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data[index].user.photo),
                                    radius: 30,
                                  )
                                      : CircleAvatar(
                                      radius: MediaQuery .of(context).size.width * 0.06,
                                      backgroundImage: AssetImage(
                                          'assets/images/grup_logo2.png')),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width *
                                            0.08),
                                        child: Text(
                                          snapshot.data[index].user.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Cleaning Service",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left:
                                        MediaQuery.of(context).size.width *
                                            0.07),
                                    width: MediaQuery.of(context).size.width *
                                        0.37,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      border: Border.all(
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top:
                                              MediaQuery.of(context).size.width *
                                                  0.02,
                                              left: MediaQuery.of(context).size.width *
                                                  0.01
                                          ),
                                          child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.black45,
                                                  size: MediaQuery.of(context).size.width *
                                                      0.05,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Penempatan Kerja", style: TextStyle(fontSize: MediaQuery.of(context).size.width *
                                                        0.032, fontWeight: FontWeight.w500),),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("D4 PENS", style: TextStyle(fontSize: MediaQuery.of(context).size.width *
                                                            0.032, fontWeight: FontWeight.w500),),
                                                        SizedBox(width: MediaQuery.of(context).size.width * 0.09),
                                                        IconButton(
                                                            padding: EdgeInsets.zero,
                                                            constraints: BoxConstraints(),
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons.create_rounded,
                                                              color: Colors.black45,
                                                              size: MediaQuery.of(context).size.width *
                                                                  0.05,
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              ]
                                          ),
                                        ),
                                      ],
                                    )
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
          Center(
            child: Card(
              color: Color(0xff4BB051),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.width * 0.01,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    leading: Icon(Icons.people_alt_sharp,
                      color: Colors.white),
                    title: Text('Jumlah Piket Petugas',
                                style: TextStyle(color: Colors.white)),
                    subtitle: Text('Jumlah Petugas yang sudah piket hari ini',
                                    style: TextStyle(color: Colors.white)),
                  ),
                  Container(
                        margin: EdgeInsets.only(bottom: 5),
                        width:
                        MediaQuery.of(context).size.width *
                            0.68,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white70,
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
                            progressBarColor: Colors.white,
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              "Tugas Terbaru Anda",
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            height: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Color(0xff4BB051),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ]),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                        EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.010,
                            left: 8),
                        child: Text(
                          "Piket Pagi",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 2, left: 8),
                        child: Row(
                          //space between cleaning service dan petugas
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Selesai",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.6,
                                ),
                                Icon(
                                  Icons.done_all,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 8, left: 8),
                        child: Text(
                          "Piket Siang",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 2, left: 8),
                        child: Row(
                          //space between cleaning service dan petugas
                          children: [
                            Row(
                              children: [
                                Text(
                                  "senin, 12/12/2020",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.42,
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              "Manfaat Pick A Bin",
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            child: CarouselSlider.builder(
              itemCount: imageAsset.length,
              options: CarouselOptions(
                height: 120.0,
                viewportFraction: 1,
                aspectRatio: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
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
          Container(
            margin: EdgeInsets.only(bottom: 5, left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              "Sampaikan Aspirasi",
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 12),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff4BB051),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff4BB051),
                    offset: const Offset(0.0, 0.8),
                    blurRadius: 2.0,
                    spreadRadius: 1.2)
              ],
            ),

            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 5),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1DDB7F),
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
                  padding: const EdgeInsets.only(left: 0, bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/images/aspiration.png",
                          width: 115, height: 115)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 90, bottom: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 200,
                      child: Text(
                        "Sampaikan aspirasi Anda !\n\nAnda dapat menyampaikan saran dan masukan",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        maxLines: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
