import 'package:flutter/material.dart';

class Lst extends StatelessWidget {
  final List<String> list;

  Lst(this.list);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list
        .map((element) => Card(
          color: Colors.yellowAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                //Image.asset('assets/unnamed.png'),
                //Image(image: NetworkImage(image_URL)),
                //image: AssettImage('image_path'),
                Text(element),
              ],
            ),
          ),
        ))
        .toList(),  
  );
  }
}

//padding: EdgeInsets.symmetric(horizontal: value, vertical: value)