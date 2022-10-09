import 'dart:io';
import 'package:boilerplate/ui/image/image_preview.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeKoordinatorPage extends StatefulWidget {
  const HomeKoordinatorPage({Key? key}) : super(key: key);

  @override
  State<HomeKoordinatorPage> createState() => _HomeKoordinatorPageState();
}

class _HomeKoordinatorPageState extends State<HomeKoordinatorPage> {
  //lebar dan tinggi layar
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
          Column(children: [
            //Bagian paling atas form,logo dan notifikasi
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Image.asset(
                    "assets/images/grup_logo.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.green, width: 1.5)),
                  child: DropdownButtonFormField(
                    icon: Icon(Icons.arrow_drop_down),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                      hintText: "Pilih Tempat",
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text("Lantai 1 D4"),
                        value: "Lantai 1 D4",
                      ),
                      DropdownMenuItem(
                        child: Text("Lantai 2 D4"),
                        value: "Lantai 2 D4",
                      ),
                      DropdownMenuItem(
                        child: Text("Lantai 3 D4"),
                        value: "Lantai 3 D4",
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black45,
                    size: 35,
                  ),
                )
              ],
            ),

            //Bagian 2, nama petugas
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/images/grup_logo2.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Hudzaifah Al labib",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
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
                            width: 80,
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
                      margin: EdgeInsets.only(top: 5, left: 9),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("4 / 16 Petugas"),
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  //image full screen
                  Container(
                    //image
                    height: MediaQuery.of(context).size.height * 0.180,
                    width: MediaQuery.of(context).size.width * 0.9,
                    //image with radius
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/slide3.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 15),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff4BB051),
                        ),
                        onPressed: () {},
                        child: Text("Lihat Detail"),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
            )
          ])
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
