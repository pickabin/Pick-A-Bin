import 'package:boilerplate/controllers/aktivitas_petugas_controller.dart';
import 'package:flutter/material.dart';

class ImagePreviewActivity extends StatefulWidget {
  final String? image;
  final int? id;
  final String? status;
  ImagePreviewActivity(
      {Key? key, required this.image, required this.id, required this.status})
      : super(key: key);

  @override
  State<ImagePreviewActivity> createState() => _ImagePreviewActivityState();
}

class _ImagePreviewActivityState extends State<ImagePreviewActivity> {
  final feedbackController = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey();
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
                  onPressed: () => Navigator.of(context).pop()),
              SizedBox(
                height: 10,
              ),
              Hero(tag: "profile", child: Image.network(widget.image!)),
              SizedBox(
                height: 10,
              ),
              widget.status == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            child: Icon(
                              Icons.chat,
                              color: Color(0xff4399A7),
                            ),
                            // onpresses dialog chat
                            onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Feedback"),
                                      // content form feedback
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      feedbackController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Feedback harus diisi';
                                                    }
                                                    return null;
                                                  },
                                                  maxLines: 3,
                                                  decoration: InputDecoration(
                                                    labelText: 'Isi Feedback',
                                                    hintText:
                                                        'Masukkan Feedback',
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .green)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.green,
                                                              width: 2,
                                                            )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextButton(
                                                  child: Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    padding: EdgeInsets.only(
                                                      left: 100,
                                                      right: 100,
                                                      top: 5,
                                                      bottom: 5,
                                                    ),
                                                  ),
                                                  onPressed: () async{
                                                    final String feedback =
                                                        feedbackController.text;
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      if (feedback.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Semua Field Harus Diisi'),
                                                          ),
                                                        );
                                                      } else {
                                                        AktivitasPetugasController.updateFeedbackAktivitasPetugas(widget.id!, feedback).then((value){
                                                          // jika berhasil
                                                            Navigator.of(context).pop();
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text('Feedback Berhasil Dikirim'),
                                                                backgroundColor: Colors.green,
                                                              ),
                                                            );
                                                        });
                                                      }
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                        SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                            child: Icon(
                              Icons.check,
                              color: Color(0xff1DDB7F),
                            ),
                            onPressed: () {
                              AktivitasPetugasController()
                                  .updateStatusAktivitasPetugas(widget.id!)
                                  .then((value) {
                                // jika berhasil update status show snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Berhasil Update Status")));
                              });
                            }),
                      ],
                    )
                  : Container()
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
