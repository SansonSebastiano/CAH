import 'package:flutter/cupertino.dart';
import 'package:serializable/serializable.dart';

class Player implements Serializable{
  int index;
  String name;
  List<String> answersList = List<String>();
  int score;

  Player({@required this.index, @required this.name, @required this.score, @required this.answersList});
}





