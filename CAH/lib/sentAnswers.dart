import 'package:flutter/cupertino.dart';
import 'package:serializable/serializable.dart';

class SentAnswers implements Serializable {
  String answer;
  int plrIndex;

  SentAnswers({@required this.answer, @required this.plrIndex});
}
