import 'package:flutter/cupertino.dart';
import 'package:serializable/serializable.dart';

class Player implements Serializable{
  // Attributes required
  int index;                                    //unique index player
  String name;                                  //his name
  List<String> answersList = List<String>();    //his answers
  int score;                                    //his score

  Player({@required this.index, @required this.name, @required this.score, @required this.answersList});
}





