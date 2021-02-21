import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String label;
  final Widget wid;

  TextBox({@required this.label, @required this.wid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width*.05,
        right: MediaQuery.of(context).size.width*.05,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
          color: Colors.grey[300],
        ),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 6.0,
            right: 4.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(12),
            ),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*.02,
                  right: MediaQuery.of(context).size.width*.15,
                  left: MediaQuery.of(context).size.width*.15,
                  bottom: MediaQuery.of(context).size.height*.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: wid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
