import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:CAH/allAnswers.dart';
import 'package:CAH/newMatch.dart';

//keyboardType: TextInputType.number,

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: Home()
    );
  }
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )
                  ),
                  height: MediaQuery.of(context).size.height*.8,
                  width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.1,
                        ),
                      _ButtonHome(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllAnswers()));
                        }, 
                        label: 'Join', 
                        icon: Icons.person
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height*.05,
                      ),
                      _ButtonHome(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewMatch()));
                        }, 
                        label: 'New Match', 
                        icon: Icons.add
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height*.05,
                      ),
                      _ButtonHome(
                        onPressed: (){
                          
                        }, 
                        label: 'Rules', 
                        icon: Icons.format_align_center
                      ),
                    ],
                    ),
                  //),
                ), 
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        //offset: Offset(2.0, 2.0)
                      )
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0)
                    )
                  ),
                  height: MediaQuery.of(context).size.height*.22,
                  width: MediaQuery.of(context).size.width*.7,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: 5
                    ),
                    child: Text(
                      'Cards Against Humanity',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              )
            ),
          )
        ],
      ),
    );
  }
}

class _ButtonHome extends StatelessWidget{
  final Function onPressed;
  final String label;
  final IconData icon;

  _ButtonHome({@required this.onPressed, @required this.label, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.white,
            width: 0.0
          ),
          color:  Colors.black
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
              bottomLeft: Radius.circular(12)
            ),
            border: Border.all(
              color: Colors.white
            )
          ),
          child: InkWell(
            onTap: () => onPressed(),
            child: ListTile(
              leading: Icon(
                icon,
                color: Colors.black,
              ),
              trailing: Icon(
                icon,
                color: Colors.transparent,
              ),
              title: Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ), 
        ),
      ),
    );
  }
}