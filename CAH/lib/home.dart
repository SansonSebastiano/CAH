import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => SecondScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,
    child: FlutterLogo(
      size:MediaQuery.of(context).size.height)
    );
  }
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("GeeksForGeeks")),
      body: Center(
        child:Text("Home page",textScaleFactor: 2,)
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:CAH/newMatch.dart';
import 'package:CAH/join.dart';

//fare SPLASH SCREEN

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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Join()));
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => AnimatedListSample()));
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
        left: MediaQuery.of(context).size.width*0.05,
        right: MediaQuery.of(context).size.width*0.05,
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
            bottom: MediaQuery.of(context).size.height*0.008,
            right: MediaQuery.of(context).size.width*0.01,
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
                  fontSize: 15
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
*/