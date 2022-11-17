import 'package:boilerplate/controllers/jadwal_controller.dart';
import 'package:boilerplate/controllers/petugas_controller.dart';
import 'package:boilerplate/ui/home/area_id.dart';
import 'package:boilerplate/ui/help/help_petugas.dart';
import 'package:boilerplate/ui/home/saran_masukan.dart';
import 'package:boilerplate/ui/notifikasi/notifikasi.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomePetugasPage extends StatefulWidget {
  const HomePetugasPage({Key? key}) : super(key: key);

  @override
  State<HomePetugasPage> createState() => _HomePetugasPageState();
}

class _HomePetugasPageState extends State<HomePetugasPage> {
  String? code;
  int? countPetugas;
  int? listDone;
  double? hasil;
  //lebar dan tinggi layar
  // final ref = FirebaseDatabase.instance
  //     .ref()
  //     .child('jadwal')
  //     .orderByChild('date')
  //     .equalTo(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString())
  //     .limitToLast(4);
  // File? _image;
  String? fileName;

  int _activeIndex = 0;
  final imageAsset = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png'
  ];

  // Future _getImageCamera() async {
  //   XFile? selectImage = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     maxHeight: 512,
  //     maxWidth: 512,
  //     imageQuality: 90,
  //   );

  //   if (selectImage != null) {
  //     setState(() {
  //       _image = File(selectImage.path);
  //       fileName = basename(_image!.path);

  //       //redirect image preview
  //       Navigator.pushReplacement(
  //         this.context,
  //         MaterialPageRoute(
  //           builder: (context) =>
  //               ImagePreview(image: _image, fileName: fileName),
  //         ),
  //       );
  //     });
  //   }
  // }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      //return data from user code
      PetugasController().getPetugasCode().then((value) {
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

    // CountPetugasController().getStatusPetugas().then((value) {
    //   setState(() {
    //     //input
    //     countPetugas = value!.petugas;
    //     listDone = value.listDone;
    //     hasil = listDone! / countPetugas!;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //lebar dan tinggi layar
    // double width = MediaQuery.of(context).size.width * 0.9;
    // double height = MediaQuery.of(context).size.height*0.2;
    // print(width);
    // print("tinggi" + height.toString());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          FutureBuilder(
              future: PetugasController().getPetugasByUid(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        //shared preference simpan id user
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setInt('user_id', snapshot.data[index].user.id);
                          prefs.setInt("petugas_id", snapshot.data[index].id);
                          prefs.setString('code', snapshot.data[index].code);
                        });
                        // print("ini petugas id" +
                        //     snapshot.data[index].id.toString());
                        code = snapshot.data[index].code;
                        return Column(children: [
                          //Bagian paling atas form,logo dan notifikasi
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
                                            code: snapshot.data[index].code),
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
                                        Icon(
                                          Icons.edit,
                                          color: Colors.black45,
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
                            margin: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  child: snapshot.data[index].user.photo != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data[index].user.photo),
                                          radius: 30,
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
                                                  0.250,
                                            ),
                                            Text(
                                              "Petugas",
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(top: 5),
                                      //   width:
                                      //       MediaQuery.of(context).size.width *
                                      //           0.680,
                                      //   height: 30,
                                      //   decoration: BoxDecoration(
                                      //       border: Border.all(
                                      //           color: Colors.black38,
                                      //           width: 1.5),
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(10))),
                                      //   // child: Padding(
                                      //   //   padding: const EdgeInsets.all(4.0),
                                      //   //   child: GFProgressBar(
                                      //   //     percentage:  hasil == null ? 0 : hasil!,
                                      //   //     lineHeight: 20,
                                      //   //     backgroundColor: Colors.grey,
                                      //   //     progressBarColor: Colors.green,
                                      //       child: Center(
                                      //         child: Text(listDone.toString() + "/" + countPetugas.toString() + " Petugas",
                                      //             style: TextStyle(
                                      //                 color: Colors.black,
                                      //                 fontSize: 12)),
                                      //       ),
                                      //   //   ),
                                      //   // ),
                                      // )
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
                              color: Color(0xFF66E8A9),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 128, 132, 136),
                                    offset: const Offset(0.0, 0.8),
                                    blurRadius: 2.0,
                                    spreadRadius: 1.2)
                              ],
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
                                  padding: const EdgeInsets.only(
                                      left: 0, bottom: 10),
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
                        ]);
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
              }),
          Container(
            // decoration: BoxDecoration(
            //   boxShadow: [
            //     BoxShadow(
            //         color: Color.fromARGB(255, 128, 132, 136),
            //         offset: const Offset(0.0, 0.8),
            //         blurRadius: 2.0,
            //         spreadRadius: 1.2)
            //   ],
            // ),
            child: CarouselSlider.builder(
              itemCount: imageAsset.length,
              options: CarouselOptions(
                height: 120.0,
                viewportFraction: 0.9,
                aspectRatio: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 6),
                autoPlayAnimationDuration: Duration(milliseconds: 900),
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
          HelpPetugas(),
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
                          fontSize: 24.0,
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
                                                  color: Color(0xFF66E8A9),
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
