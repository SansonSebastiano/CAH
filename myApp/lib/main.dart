import 'package:flutter/material.dart';

import './lst_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        //backgroundColor: Colors.yellow,
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.yellow,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: LstManager(firstItem: 'Item : 0'),
        ),
      ),
    );
  }
}

//mainAxisAlignment: MainAxisAlignment.center
//CrossAxisAlignment: CrossAxisAlignment.center
//SizedBox(height: pixel_value [or width: pixel_value])

/*
  Divider(
    properties
  )
*/

/*Icon(
    Icons.any_icon
    color:
    size:
)*/

/*RaisedButton.icon(
  onPressed: () {}
  icon: Icon(
    Icons.any_icon
  ),
  label: Text('any text'),
  color: Color.any_color,
)*/