import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Custom Button layout
class Button extends StatelessWidget {
  //parameters required
  final String text; //button's label
  final Function onPressed; //function launched on pressed
  final Color textColor; //color of text
  final Color borderColor; //color of border button
  final Color onTapColor; //button color on tap

  Button(
      {@required this.text,
      @required this.onPressed,
      @required this.textColor,
      @required this.borderColor,
      @required this.onTapColor});

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

class CustomIconButton extends StatelessWidget {
  final Function onPressed; //function launched on pressed
  final Color onTapColor; //button color on tap
  final Color iconColor;
  final IconData icons;

  CustomIconButton(
      {@required this.onPressed,
      @required this.onTapColor,
      @required this.icons,
      @required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.05),
      onPressed: () => onPressed(),
      child: Icon(
        icons,
        color: iconColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        
      ),
      
      splashColor: onTapColor,
    );
  }
}

// Custom Button for AlertDialog layout
class ADButton extends StatelessWidget {
  //parameters required
  final String text; //button's label
  final Function onPressed; //function launched on pressed
  final Color textColor; //color of text
  final Color borderColor; //color of border button
  final Color onTapColor; //button color on tap

  ADButton(
      {@required this.text,
      @required this.onPressed,
      @required this.textColor,
      @required this.borderColor,
      @required this.onTapColor});

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
