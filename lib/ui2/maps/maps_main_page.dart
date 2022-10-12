import 'package:boilerplate/ui/maps/maps_distribution_page.dart';
import 'package:boilerplate/ui/maps/maps_user_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class MapsMainPage extends StatefulWidget {
  @override
  State<MapsMainPage> createState() => MapsMainPageState();
}

class MapsMainPageState extends State<MapsMainPage> {
  int currentIndex = 1;
  

  @override
  Widget build(BuildContext context) {
    List<Widget> pageOptions = [
      MapsUserPage(),
      MapsDistributionPage(),
    ];

    return new Scaffold(
      body: pageOptions[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        activeColor: Colors.green,
        color: Colors.black45,
        backgroundColor: Colors.white,
        items: [
          TabItem(icon: Icons.people, title: 'Users'),
          TabItem(icon: Icons.near_me_sharp, title: 'Maps'),
        ],
        initialActiveIndex: 1,
        onTap: (int i) {
          setState(() {
            currentIndex = i;
          });
        },
      ),
     
    );
  }

 
}
