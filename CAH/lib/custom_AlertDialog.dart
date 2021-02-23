import 'package:CAH/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// custom Alert Dialog 
class WindowDialog extends StatelessWidget {
  // Parameters required
  final String text;    //text displayed on Alert Dialog

  WindowDialog({@required this.text});

  // Build Custom AD layout
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

// Custom alert dialog with Y/N options
class YNAlertWindow extends StatelessWidget {
  // Parameters required
  final String text;            //text displayed on Alert Dialog
  final Function onYesPressed;  //function launched on yes button pressed
  final Function onNoPressed;   //function launched on no button pressed

  YNAlertWindow({@required this.text, @required this.onYesPressed, @required this.onNoPressed});

  //build custom AD with Y/N options layout
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
            // YES Alert Dialog Button
            ADButton(
              text: 'Yes',
              textColor: Colors.white,
              borderColor: Colors.white,
              onTapColor: Colors.white54,
              onPressed: () => onYesPressed(),
            ),

            SizedBox(width: MediaQuery.of(context).size.width*.025,),
            
            // NO Alert Dialog Button
            ADButton(
              text: 'No',
              textColor: Colors.white,
              borderColor: Colors.white,
              onTapColor: Colors.white54,
              onPressed:() => onNoPressed(),
            ),
          ],
        ),       
      ],  
    );
  }
}
