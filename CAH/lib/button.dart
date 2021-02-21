import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color textColor;
  final Color borderColor;
  final Color onTapColor;

  Button({@required this.text, @required this.onPressed, @required this.textColor, @required this.borderColor, @required this.onTapColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => onPressed(),
      //icon: Icon(icon),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      minWidth: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .065,
      splashColor: onTapColor,
    );
  }
}

class ADButton extends StatelessWidget{
  final String text;
  final Function onPressed;
  final Color textColor;
  final Color borderColor;
  final Color onTapColor;

  ADButton({@required this.text, @required this.onPressed, @required this.textColor, @required this.borderColor, @required this.onTapColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => onPressed(),
      //icon: Icon(icon),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      minWidth: MediaQuery.of(context).size.width * .15,
      height: MediaQuery.of(context).size.height * .04,
      splashColor: onTapColor,
    );
  }
}
