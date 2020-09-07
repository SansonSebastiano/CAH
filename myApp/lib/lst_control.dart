import 'dart:ui';

import 'package:flutter/material.dart';

class LstControl extends StatelessWidget{
  final Function addItem;

  LstControl(this.addItem);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.0),
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: (){
                addItem('Item : ');
              },  
              child: Text(
                'Add Item',
                style: TextStyle(
                  color: Colors.yellow
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}