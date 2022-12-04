import 'package:boilerplate/ui/home/area_id_petugas.dart';
import 'package:boilerplate/ui/notifikasi/notifikasi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import variabel global
import 'package:boilerplate/data/service/global.dart' as global;

class ProfileHome extends StatefulWidget {
  const ProfileHome({Key? key}) : super(key: key);

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Bagian paling atas form,logo dan notifikasi
      Padding(
        padding: EdgeInsets.only(left: 15, right: 5, top: MediaQuery.of(context).size.height * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Image.asset(
                "assets/images/group_logo.png",
                width: MediaQuery.of(context).size.width * 0.200,
                height: MediaQuery.of(context).size.height * 0.07,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text("PENS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 10,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(right: 13),
              alignment: Alignment.centerRight,
              child: Stack(children: [
                //Notification
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Notifikasi()));
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black45,
                    size: 32,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Center(
                      child: Text(
                        "!",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),

      //Bagian 2, nama petugas
      Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 88,
        decoration: BoxDecoration(
            color: Color(0xFF004C58),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 6),
              child: global.photo != null
                  ? CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          global.photo.toString()),
                      radius: 27,
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/grup_logo2.png')),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          global.nama.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Petugas",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            // fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.37,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.02,
                          left: MediaQuery.of(context).size.width * 0.01),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black45,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Penempatan Kerja",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.030,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    global.code != null
                                        ? Text(
                                            global.code.toString(),
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.032,
                                                fontWeight: FontWeight.w500),
                                          )
                                        : Text("Belum ada",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.032)),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: () {
                                          // show dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: AreaIdPetugas(
                                                  code: global.code
                                                      .toString(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.create_rounded,
                                          color: Colors.black45,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ]);
  }
}
