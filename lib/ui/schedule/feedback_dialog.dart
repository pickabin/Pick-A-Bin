import 'package:boilerplate/controllers/aspirasi_controller.dart';
import 'package:flutter/material.dart';

class FeedbackDialog extends StatefulWidget {
  FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _namaController = new TextEditingController();
  final TextEditingController _messageController = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: EdgeInsets.all(10),
      title: Text('Feedback'),
      content: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.zero,
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 13),
                      child: Text(
                        "Masukkan feedback untuk Petugas",
                        style: TextStyle(
                          fontSize: 17.5,
                          height: 1.3,
                          fontFamily: 'RobotoSlab',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _messageController,
                        textAlign: TextAlign.start,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Saran atau masukan harus Diisi';
                          }
                          return null;
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          fillColor: Color(0xffe6e6e6),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          hintText: 'Your message',
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'RobotoSlab',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(17),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(17),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(17),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Card(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_namaController.text.isNotEmpty &&
                                _messageController.text.isNotEmpty) {
                              AspirasiController.addAspirasi(
                                _namaController.text,
                                _messageController.text,
                              ).then((value) {
                                if (value.statusCode == 200) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Terima kasih atas saran dan masukan anda'),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.green,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Gagal mengirim saran dan masukan'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              });
                            }
                          }
                        },
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Center(
                                  child: Text(
                                "Send",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoSlab'),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                  ]),
            )),
      ),
    );
  }
}
