import 'package:flutter/material.dart';

class LstControl extends StatelessWidget{
  final Function addItem;

  LstControl(this.addItem);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: (){
        addItem('Item : ');
      },  
      child:  Text('Add Item'),
    );
  }
}