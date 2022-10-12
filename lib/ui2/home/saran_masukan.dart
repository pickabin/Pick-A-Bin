import 'package:flutter/material.dart';

class SaranMasukan extends StatefulWidget {
  const SaranMasukan({Key? key}) : super(key: key);

  @override
  State<SaranMasukan> createState() => _SaranMasukanState();
}

class _SaranMasukanState extends State<SaranMasukan> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: EdgeInsets.all(10),
      title: Text('Saran & Masukan'),
      content: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 13),
                    child: Text(
                      "Saran dan masukan dari anda akan sangat membantu kami dalam mengembangkan aplikasi kedepannya",
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
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama harus Diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffe6e6e6),
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        hintText: 'Your name',
                        hintStyle: TextStyle(
                            color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
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
                    height: MediaQuery.of(context).size.height * 0.0001,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                    color: Colors.green[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {},
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
                ])),
      ),
    );
  }
}