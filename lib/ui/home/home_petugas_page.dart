import 'dart:io';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/controllers/user_controller.dart';
import 'package:boilerplate/ui/home/area_id.dart';
import 'package:boilerplate/ui/image/image_preview.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:path/path.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';

class HomePetugasPage extends StatefulWidget {
  const HomePetugasPage({Key? key}) : super(key: key);

  @override
  State<HomePetugasPage> createState() => _HomePetugasPageState();
}

class _HomePetugasPageState extends State<HomePetugasPage> {
  //lebar dan tinggi layar
  final ref = FirebaseDatabase.instance
      .ref()
      .child('jadwal')
      .orderByChild('date')
      .equalTo(DateFormat('dd/MM/yyyy').format(DateTime.now()).toString())
      .limitToLast(4);
  File? _image;
  String? fileName;

  int _activeIndex = 0;
  final imageAsset = [
    'assets/images/slide1.jpg',
    'assets/images/slide2.jpg',
    'assets/images/slide3.jpg',
    'assets/images/slide4.jpg'
  ];

  Future _getImageCamera() async {
    XFile? selectImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    if (selectImage != null) {
      setState(() {
        _image = File(selectImage.path);
        fileName = basename(_image!.path);

        //redirect image preview
        Navigator.pushReplacement(
          this.context,
          MaterialPageRoute(
            builder: (context) =>
                ImagePreview(image: _image, fileName: fileName),
          ),
        );
      });
    }
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
        child: Column(children: [
          FutureBuilder(
              future: UserController().getUserUid(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          //Bagian paling atas form,logo dan notifikasi
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Image.asset(
                                  "assets/images/grup_logo.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.200,
                                  height: 100,
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(15)),
                                  width: MediaQuery.of(context).size.height *
                                      0.300,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40.0),
                                        child: Center(child: Text("Lt2D4/D4")),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.black45,
                                        onPressed: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20))),
                                            backgroundColor: Colors.white,
                                            context: context,
                                            builder: (_) {
                                              return FractionallySizedBox(
                                                heightFactor: 0.8,
                                                child: AreaId(),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Stack(
                                      children: [
                                        //Notification
                                        IconButton(
                                          onPressed: (){}, 
                                          icon: Icon(Icons.notifications, color: Colors.black45, size: 32,),
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
                                                color: Colors.white,
                                                width: 2
                                              )
                                            ),
                                            child: Center(
                                              child: Text("1", style: TextStyle(color: Colors.white, fontSize: 12),),
                                            ),
                                          ),
                                        )
                                    ]
                                  ),
                                ),
                            ],
                          ),

                          //Bagian 2, nama petugas
                          Container(
                            margin: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 1.0,
                            child: Row(
                              children: [
                                Container(
                                  child: snapshot.data[index].imageUrl != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data[index].imageUrl),
                                          radius: 30,
                                        )
                                      : Image.asset(
                                          "assets/images/grup_logo2.png",
                                          width: 100,
                                          height: 100,
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
                                          snapshot.data[index].name,
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
                                                  0.280,
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
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.660,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black38,
                                                width: 1.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("4 / 16 Petugas"),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 12),
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
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 2,
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0))),
                                                contentPadding:
                                                    EdgeInsets.all(25),
                                                title: Text('Saran & Masukan'),
                                                content: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.28,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.50,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0),
                                                        child: TextFormField(
                                                            maxLines: 2,
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'Nama',
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                8),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ))),
                                                      ),
                                                      TextFormField(
                                                          maxLines: 7,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Isi',
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    borderSide:
                                                                        BorderSide(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    borderSide:
                                                                        BorderSide(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ))),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 18, bottom: 18),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Colors.lightGreen,
                                                      ),
                                                      child: Text('OK'),
                                                      onPressed: () {
                                                        setState(() {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
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
                                        "assets/images/activity_icon.png",
                                        width: 100,
                                        height: 100,
                                      )),
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
            child: CarouselSlider.builder(
              itemCount: imageAsset.length,
              options: CarouselOptions(
                height: 120.0,
                viewportFraction: 1,
                aspectRatio: 1.0,
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
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Bingung ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Yuk pelajari fitur kami!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/tutorial1.png"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            width: 2, color: AppColors.borderTutorial),
                        borderRadius: BorderRadius.circular(12),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color.fromARGB(255, 122, 122, 122),
                        //     spreadRadius: 1,
                        //     blurRadius: 1,
                        //     offset: Offset(0, 1), // changes position of shadow
                        //   )
                        // ],
                      ),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.all(8),
                            // child: Image.asset(
                            //   "assets/images/activity_icon.png",
                            //   width: 50,
                            //   height: 50,
                            // ),
                            child: Container(
                              height: 45,
                              width: 45,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 15, top: 10),
                                  child: Text(
                                    "Laporan Acara",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Deskripsi singka5t tentang fitur",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/tutor2.png"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            width: 2, color: AppColors.borderTutorial),
                        borderRadius: BorderRadius.circular(12),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color.fromARGB(255, 122, 122, 122),
                        //     spreadRadius: 1,
                        //     blurRadius: 1,
                        //     offset: Offset(0, 1), // changes position of shadow
                        //   )
                        // ],
                      ),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.all(8),
                            // child: Image.asset(
                            //   "assets/images/activity_icon.png",
                            //   width: 50,
                            //   height: 50,
                            // ),
                            child: Container(
                              height: 45,
                              width: 45,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 15, top: 10),
                                  child: Text(
                                    "Laporan Acara",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Deskripsi singkat tentang fitur",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18, right: 18),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
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
                    padding: const EdgeInsets.only(bottom: 30),
                    child: FirebaseAnimatedList(
                        shrinkWrap: true,
                        //query status sama dengan
                        query: ref,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          // bool isChecked = snapshot.child('status').value as bool;

                          return Column(
                            children: <Widget>[
                              snapshot.child('status').value.toString() ==
                                      'false'
                                  ? ListTile(
                                      title: Text(
                                        snapshot
                                                .child('instansi')
                                                .value
                                                .toString() +
                                            " - " +
                                            snapshot
                                                .child('penanggungJawab')
                                                .value
                                                .toString(),
                                      ),
                                      subtitle: Text(
                                        snapshot
                                            .child('alamat')
                                            .value
                                            .toString(),
                                      ),
                                      leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                        "assets/images/building_icon.png",
                                      )),
                                      trailing: Text(
                                        snapshot.child('date').value.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 241, 96, 96),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      margin: const EdgeInsets.only(top: 10),
                                      child: ListTile(
                                        title: Text(
                                          snapshot
                                                  .child('instansi')
                                                  .value
                                                  .toString() +
                                              " - " +
                                              snapshot
                                                  .child('penanggungJawab')
                                                  .value
                                                  .toString(),
                                        ),
                                        subtitle: Text("Sampah sudah diambil",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic)),
                                        leading: CircleAvatar(
                                            backgroundImage: AssetImage(
                                          "assets/images/building_icon.png",
                                        )),
                                        trailing: Column(
                                          children: [
                                            Text(
                                              snapshot
                                                  .child('tglSelesai')
                                                  .value
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot
                                                  .child('waktuSelesai')
                                                  .value
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )),
                            ],
                          );
                        }),
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

  Widget _buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _activeIndex,
      count: imageAsset.length,
      effect: ExpandingDotsEffect(
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: Colors.green,
        dotColor: Colors.grey,
      ),
    );
  }
}
