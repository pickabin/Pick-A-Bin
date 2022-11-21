import 'package:boilerplate/controllers/aktivitas_petugas_controller.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final String? image;
  ImagePreview({Key? key, required this.image}) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
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
            SizedBox(
              height: 50,
            ),
            Hero(tag: "profile", child: Image.network(widget.image!)),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.of(context).pop()),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     //form keterangan
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.68,
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(50),
            //           border: Border.all(color: Colors.grey)),
            //       child: Padding(
            //         padding: EdgeInsets.only(
            //             left: MediaQuery.of(context).size.width * 0.05),
            //         child: TextFormField(
            //           decoration: InputDecoration(
            //             hintText: "Keterangan",
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //     ),
            //     //circle button
            //     Container(
            //       width: 50,
            //       height: 50,
            //       decoration: BoxDecoration(
            //           color: AppColors.aspirasiColor,
            //           borderRadius: BorderRadius.circular(50),
            //           border: Border.all(color: Colors.grey)),
            //       child: IconButton(
            //           icon: Icon(
            //             Icons.send,
            //             color: Colors.black,
            //           ),
            //           onPressed: () async {}),
            //     ),
            //   ],
            // )
          ],
        ),
      )),
    );
  }
}
