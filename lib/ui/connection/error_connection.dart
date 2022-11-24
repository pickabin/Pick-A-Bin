import 'package:flutter/material.dart';

class ErrorConnection extends StatelessWidget {
  const ErrorConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          context: context,
          builder: (BuildContext context) {
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
                    height: 30,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/images/error_connection.jpg',
                                width: 200,
                                height: 200,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Koneksi Anda Terputus :(",
                              style: TextStyle(
                                  fontSize: 16.25, color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 7),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Periksa koneksi internet atau Wi-Fi Anda dan coba lagi",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // Respond to button press
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                      child: Text('Settings'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Respond to button press
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      )),
                                      child: Text('Coba Lagi'),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    });
    return Scaffold(
      body: Container(
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
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/error_connection.jpg',
                          width: 200,
                          height: 200,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Koneksi Anda Terputus :(",
                        style: TextStyle(fontSize: 16.25, color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 7),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Periksa koneksi internet atau Wi-Fi Anda dan coba lagi",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
