import 'dart:ui';

import 'package:flutter/material.dart';

class WaitingRoom extends StatefulWidget {
  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*.15,
                width: MediaQuery.of(context).size.width*.3,
                child: CircularProgressIndicator(
                  value: null,
                  backgroundColor: Colors.black,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.1,
              ),
              Text(
                'Waiting...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.none
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
