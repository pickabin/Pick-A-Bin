// import 'dart:io';
// import 'package:boilerplate/ui/image/image_preview.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';
// import 'package:boilerplate/constants/colors.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomeKoordinatorPage extends StatefulWidget {
//   const HomeKoordinatorPage({Key? key}) : super(key: key);

//   @override
//   State<HomeKoordinatorPage> createState() => _HomeKoordinatorPageState();
// }

// class _HomeKoordinatorPageState extends State<HomeKoordinatorPage> {
//   File? _image;
//   String? fileName;
  
  
//   int _activeIndex = 0;
//   final imageAsset = [
//     'assets/images/slide1.jpg',
//     'assets/images/slide2.jpg',
//     'assets/images/slide3.jpg',
//     'assets/images/slide4.jpg'
//   ];

//   Future _getImageCamera() async{
//     XFile? selectImage = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//       maxHeight: 512,
//       maxWidth: 512,
//       imageQuality: 90,
//     );

//      if (selectImage != null) {
//       setState(() {
//         _image = File(selectImage.path);
//         fileName = basename(_image!.path);

//         //redirect image preview
//         Navigator.pushReplacement(
//           this.context,
//           MaterialPageRoute(
//             builder: (context) => ImagePreview(image: _image, fileName: fileName),
//           ),
//         );
//       });
//     }

//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Column(children: [
//             //Bagian paling atas form,logo dan notifikasi
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(top: 10, left: 10),
//                   child: Image.asset(
//                     "assets/images/grup_logo.png",
//                     width: 100,
//                     height: 100,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 10),
//                   width: 225,
//                   height: 45,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       border: Border.all(color: Colors.green, width: 1.5)),
//                   child: DropdownButtonFormField(
//                     icon: Icon(Icons.arrow_drop_down),
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.only(left: 10, bottom: 10),
//                       hintText: "Pilih Tempat",
//                     ),
//                     items: [
//                       DropdownMenuItem(
//                         child: Text("Lantai 1 D4"),
//                         value: "Lantai 1 D4",
//                       ),
//                       DropdownMenuItem(
//                         child: Text("Lantai 2 D4"),
//                         value: "Lantai 2 D4",
//                       ),
//                       DropdownMenuItem(
//                         child: Text("Lantai 3 D4"),
//                         value: "Lantai 3 D4",
//                       ),
//                     ],
//                     onChanged: (value) {
//                       print(value);
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 10, left: 10),
//                   child: Icon(
//                     Icons.notifications,
//                     color: Colors.black45,
//                     size: 35,
//                   ),
//                 )
//               ],
//             ),

//             //Bagian 2, nama petugas
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: 15),
//                   child: Image.asset(
//                     "assets/images/grup_logo2.png",
//                     width: 100,
//                     height: 100,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       child: Text(
//                         "Hudzaifah Al labib",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       child: Row(
//                         //space between cleaning service dan petugas
//                         children: [
//                           Text(
//                             "Cleaning Service",
//                             style: TextStyle(
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 80,
//                           ),
//                           Text(
//                             "Petugas",
//                             style: TextStyle(
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 5, left: 9),
//                       width: 230,
//                       height: 30,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black38, width: 1.5),
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Text("4 / 16 Petugas"),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 5, right: 5),
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height,
//                 margin: EdgeInsets.only(top: 20),
//                 decoration: BoxDecoration(
//                   color: AppColors.secondColor,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       offset: const Offset(
//                         3.0,
//                         3.0,
//                       ),
//                       blurRadius: 6.0,
//                       spreadRadius: 1.5,
//                     ), //BoxShadow
//                     BoxShadow(
//                       color: Colors.white,
//                       offset: const Offset(0.0, 0.0),
//                       blurRadius: 0.0,
//                       spreadRadius: 0.0,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10)),
//                 ),
//                 child: Column(
//                   children: [
//                     //Box Content
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(left: 15),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                     color: AppColors.aspirasiColor,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(5))),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(7.0),
//                                   child: Icon(Icons.mail, color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),

//                           //Tulis Aspirasi Kamu
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: AppColors.aspirasiColor,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5))),
//                               height:
//                                   MediaQuery.of(context).size.height * 0.055,
//                               width: 250,
//                               child: Form(
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                     hintText: "Tulis Aspirasi Kamu",
//                                     border: InputBorder.none,
//                                     contentPadding: EdgeInsets.only(left: 10),
//                                     suffixIcon: IconButton(
//                                       color: Colors.white,
//                                       icon: Icon(Icons.send),
//                                       onPressed: () {},
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                         padding: EdgeInsets.only(top: 20, bottom: 20),
//                         height: MediaQuery.of(context).size.height * 0.87,
//                         decoration: BoxDecoration(
//                           color: AppColors.aspirasiColor,
//                         ),
//                         child: Column(
//                           children: [
//                             CarouselSlider.builder(
//                               itemCount: imageAsset.length,
//                               options: CarouselOptions(
//                                 height: 145.0,
//                                 autoPlay: true,
//                                 viewportFraction: 0.9,
//                                 reverse: true,
//                                 autoPlayInterval: Duration(seconds: 25),
//                                 onPageChanged: (index, reason) {
//                                   setState(() {
//                                     _activeIndex = index;
//                                   });
//                                 },
//                               ),
//                               itemBuilder: (context, index, realIndex) {
//                                 return _buildImage(imageAsset, index);
//                               },
//                             ),
//                             const SizedBox(height: 20),
//                             _buildIndicator(),
//                             const SizedBox(height: 20),
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: Text(
//                                   "Tugas Terkini",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(2)),
//                               ),
//                               child: ListTile(
//                                 leading: Icon(Icons.assignment),
//                                 title: Text("Ruang BAAK"),
//                                 subtitle: Text("20/10/2020"),
//                                 trailing: GestureDetector(
//                                   child: Icon(Icons.camera_alt),
//                                   onTap: (){
//                                     _getImageCamera();
//                                   }
//                                 ),
//                               ),
//                             )
//                           ],
//                         )),
//                   ],
//                 ),
//               ),
//             )
//           ])
//         ]),
//       ),
//     );
//   }

//   Widget _buildImage(List<String> imageAsset, int index) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           image: DecorationImage(
//               image: AssetImage(
//                 imageAsset[index],
//               ),
//               fit: BoxFit.cover)),
//     );
//   }

//   Widget _buildIndicator() {
//     return AnimatedSmoothIndicator(
//       activeIndex: _activeIndex,
//       count: imageAsset.length,
//       effect: ExpandingDotsEffect(
//         dotHeight: 10,
//         dotWidth: 10,
//         activeDotColor: Colors.green,
//         dotColor: Colors.grey,
//       ),
//     );
//   }
// }
