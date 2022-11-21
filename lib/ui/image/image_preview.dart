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
                height: 10,
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
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     OutlinedButton(
              //         child: Icon(
              //           Icons.chat,
              //           color: Color(0xff4399A7),
              //         ),
              //         // onpresses dialog chat
              //         onPressed: () => showDialog(
              //             context: context,
              //             builder: (context) => AlertDialog(
              //                   title: Text("Feedback"),
              //                   // content form feedback
              //                   content: Column(
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       Form(
              //                         child: Column(
              //                           children: [
              //                             TextField(
              //                               maxLines: 3,
              //                               decoration: InputDecoration(
              //                                 labelText: 'Isi Feedback',
              //                                 hintText: 'Masukkan Feedback',
              //                                 enabledBorder: OutlineInputBorder(
              //                                     borderRadius:
              //                                         BorderRadius.circular(10),
              //                                     borderSide: BorderSide(
              //                                         color: Colors.green)),
              //                                 focusedBorder: OutlineInputBorder(
              //                                     borderRadius:
              //                                         BorderRadius.circular(10),
              //                                     borderSide: BorderSide(
              //                                       color: Colors.green,
              //                                       width: 2,
              //                                     )),
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 10,
              //                             ),
              //                             TextButton(
              //                                 child: Icon(
              //                                   Icons.send,
              //                                   color: Colors.white,
              //                                 ),
              //                                 style: TextButton.styleFrom(
              //                                     backgroundColor:
              //                                         Colors.green,
              //                                     padding: EdgeInsets.only(
              //                                         left: 100,
              //                                         right: 100,
              //                                         top: 5,
              //                                         bottom: 5,
              //                                     ),  
              //                                 ),
              //                                 onPressed: () {},
              //                             )
              //                           ],
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ))),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     OutlinedButton(
              //         child: Icon(
              //           Icons.check,
              //           color: Color(0xff1DDB7F),
              //         ),
              //         onPressed: () {
              //           // AktivitasPetugasController().updateStatusAktivitasPetugas();
              //       }),
              //   ],
              // ),
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
        ),
      ),
    );
  }
}
