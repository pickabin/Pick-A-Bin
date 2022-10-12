import 'package:flutter/material.dart';

class ProfileDetailImage extends StatefulWidget {
  final String? image;
  ProfileDetailImage({Key? key, required this.image}) : super(key: key);
  @override
  State<ProfileDetailImage> createState() => _ProfileDetailImageState();
}

class _ProfileDetailImageState extends State<ProfileDetailImage> {
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
                tag: "profile",
                child: Image.network(widget.image!)),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
                child: Icon(Icons.close,color: Colors.green,),
                onPressed: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }
}
