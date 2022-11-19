import 'package:boilerplate/ui/schedule/feedback_dialog.dart';
import 'package:flutter/material.dart';

class ImagePreviewActivity extends StatefulWidget {
  final String? image;
  ImagePreviewActivity({Key? key, required this.image}) : super(key: key);

  @override
  State<ImagePreviewActivity> createState() => _ImagePreviewActivityState();
}

class _ImagePreviewActivityState extends State<ImagePreviewActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Hero(tag: "profile", child: Image.network(widget.image!)),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xffEF7D31)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.feedback_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "  Feedback  ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return FeedbackDialog();
                              });
                        }),
                    SizedBox(
                      width: 15,
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "  Konfirmasi  ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () => Navigator.of(context).pop()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
