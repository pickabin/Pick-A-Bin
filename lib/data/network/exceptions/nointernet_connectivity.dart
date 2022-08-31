import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Internet'),
          ElevatedButton(
            child: Text('Refresh'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      )
    );
  }
}