import 'dart:io';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/ui/home/home_koordinator_page.dart';
import 'package:boilerplate/ui/home/home_koordinator_page_backup.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final File? image;
  final String? fileName;
  ImagePreview({Key? key, required this.image, required this.fileName})
      : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeKoordinatorPage()))),
              Hero(
                  tag: "profile",
                  child: Image.file(
                    widget.image!,
                    height: MediaQuery.of(context).size.height * 0.7,
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //form keterangan
                  Container(
                    width: MediaQuery.of(context).size.width * 0.68,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Keterangan",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  //circle button
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.aspirasiColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey)),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          FirebaseStorage storage = FirebaseStorage.instance;
                          if (widget.fileName != null) {
                            Reference storageRef = storage
                                .ref()
                                .child("imageAktivitas/" + widget.fileName!);
                            await storageRef.putFile(widget.image!);

                            storageRef.getDownloadURL().then((value) {
                              setState(() {
                                url = value;
                              });
                            });
                          }
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeKoordinatorPage();
                          }));
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
