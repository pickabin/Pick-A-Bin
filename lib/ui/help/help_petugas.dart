import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/ui/help/petugas_acara_tutorial.dart';
import 'package:boilerplate/ui/help/petugas_schedule_tutorial.dart';
import 'package:flutter/material.dart';

class HelpPetugas extends StatelessWidget {
  const HelpPetugas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 1.4, color: Color(0xFF66E8A9)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Bingung ?",
                  style: TextStyle(
                    fontFamily: 'Roboto' ,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Yuk pelajari fitur kami!",
                  style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    color: Colors.black,
                    // fontWeight: FontWeight.,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PetugasAcaraTutorial()));
                },
                child: Container(
                  width: double.infinity,
                  height: 53,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/tutorial1.png"),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 128, 132, 136),
                          offset: const Offset(0.0, 0.4),
                          blurRadius: 1.0,
                          spreadRadius: 1.0 
                          )
                    ],
                  ),
                  child: Row(children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15, top: 2),
                              child: Row(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Laporan Acara",
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Bold',
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                          ),
                                    ),
                                    Text(
                                      "Periksa jadwal acara terdekat",
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.12,
                                      top: 12),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 25,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ))
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PetugasScheduleTutorial()));
                },
                child: Container(
                  width: double.infinity,
                  height: 53,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/tutorial2.png"),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 128, 132, 136),
                          offset: const Offset(0.0, 0.4),
                          blurRadius: 1.0,
                          spreadRadius: 1.0 // changes position of shadow
                          )
                    ],
                  ),
                  child: Row(children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15, top: 2),
                              child: Row(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jadwal",
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Bold',
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                          ),
                                    ),
                                    Text(
                                      "Periksa jadwal penugasan kamu",
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.09,
                                      top: 12),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 25,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ))
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
