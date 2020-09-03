import 'package:flutter/material.dart';

import './lst.dart';

class LstManager extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LstManagerState();
  }
}

class _LstManagerState extends State<LstManager>{
  List<String> _list = ['First Item'];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          onPressed: (){
            setState(() {
              _list.add('Second Item');
            });
          },  
          child:  Text('i am a button'),
        ),
      ),
      Lst(_list),
     ],); 
  }
}