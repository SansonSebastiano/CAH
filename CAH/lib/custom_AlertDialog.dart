import 'package:CAH/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WindowDialog extends StatelessWidget {
  final String text;

  WindowDialog({@required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Icon(
              Icons.warning,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class YNAlertWindow extends StatelessWidget {
  final String text;
  final Function onYesPressed;
  final Function onNoPressed;

  YNAlertWindow({@required this.text, @required this.onYesPressed, @required this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Icon(
              Icons.warning,
              color: Colors.white,
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Row(
          children: <Widget>[
            ADButton(
              text: 'Yes',
              textColor: Colors.white,
              borderColor: Colors.white,
              onTapColor: Colors.white54,
              onPressed: onYesPressed(),
            ),

            SizedBox(width: MediaQuery.of(context).size.width*.025,),

             ADButton(
              text: 'No',
              textColor: Colors.white,
              borderColor: Colors.white,
              onTapColor: Colors.white54,
              onPressed: onNoPressed(),
            ),
          ],
        ),       
      ],
    );
  }
}
