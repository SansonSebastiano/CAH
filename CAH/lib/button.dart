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

  /*final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      side: BorderSide(
        color: Colors.black,
        width: 2,
      ),
    ),
    minimumSize: Size(MediaQuery.of(context).size.width * .8, MediaQuery.of(context).size.height * .065)
  );*/

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width * .8, MediaQuery.of(context).size.height * .065),
        onSurface: onTapColor,
      ),
    );
  }
  /*
    FlatButton(
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
   */
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
    return TextButton(
      onPressed: () => onPressed(),
      child: Icon(
        icons,
        color: iconColor,
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
        onSurface: onTapColor,
        padding: EdgeInsets.all(0.05),
      ),
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
    return TextButton(
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
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      minimumSize: Size(MediaQuery.of(context).size.width * .15, MediaQuery.of(context).size.height * .04),
      ),
    );
  }
}
