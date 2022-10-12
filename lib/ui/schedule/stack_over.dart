import 'dart:io';

import 'package:boilerplate/ui/schedule/jadwal_camera_page.dart';
import 'package:boilerplate/ui/schedule/list_done_page.dart';
import 'package:boilerplate/ui2/image/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class StackOver extends StatefulWidget {
  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StackOver>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Jadwal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Colors.green,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Laporan Petugas',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Jadwal',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ListDonePage()),
                  // second tab bar view widget
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: JadwalCameraPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
