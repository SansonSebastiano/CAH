import 'package:flutter/material.dart';

import './lst.dart';
import './lst_control.dart';

class LstManager extends StatefulWidget{
  final String firstItem;
  
  LstManager({this.firstItem});     //with curly braces this argument is called 'Named Argument' [{this.firstItem = 'Item : 0'}], like [brightness: Brightness.dark] 

  @override
  State<StatefulWidget> createState() {
    return _LstManagerState();
  }
}

class _LstManagerState extends State<LstManager>{
  int _counter = 0;
  List<String> _list =  [];

  @override
  void initState() {
    _list.add(widget.firstItem);
    super.initState();
  }

  //LIFTING THE STATE UP 
  void _addItem(String item) {
    setState(() {
      _counter++;
      _list.add(item + _counter.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        //padding: EdgeInsets.all(20.0),
        child: LstControl(_addItem),
      ),
      Lst(_list),
     ],); 
  }
}