import 'package:flutter/material.dart';

class AreaId extends StatefulWidget {
  const AreaId({Key? key}) : super(key: key);

  @override
  _AreaIdState createState() => _AreaIdState();
}

class _AreaIdState extends State<AreaId> {
  final TextEditingController kodeGedungController =
      new TextEditingController();
  final TextEditingController kodeLantaiController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Container(
            height: 5,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 122, 122, 122),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Kode gedung",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "kode gedung digunakan untuk bla..bla.......",
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                  child: Form(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Masukkan kode gedung",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      TextFormField(
                          controller: kodeGedungController,
                          decoration: InputDecoration(
                              labelText: 'ex: D4Mul',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ))),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Masukkan kode lantai",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      TextFormField(
                          controller: kodeLantaiController,
                          decoration: InputDecoration(
                              labelText: 'ex: Lt2D4Mul',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ))),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
