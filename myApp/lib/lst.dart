import 'package:flutter/material.dart';

class Lst extends StatelessWidget {
  final List<String> list;

  Lst(this.list);

  @override
  Widget build(BuildContext context) {
    return Column(
              children: list
                .map((element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/unnamed.png'),
                      Text(element),
                    ],
                  ),
                ))
                .toList(),  
          );
  }
}