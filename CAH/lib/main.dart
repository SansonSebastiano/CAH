import 'package:CAH/custom_AlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

import 'package:CAH/join.dart';
import 'package:CAH/newMatch.dart';
import 'package:CAH/server.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreen> {
  Server server = Server();
  bool connState = false;

  @override
  void initState() {
    getConnState();
    super.initState();
  }

  void getConnState() async {
    connState = await server.isConnected();
    print("connection state : $connState");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!connState) {
      getConnState();
      
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * .5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
              width: MediaQuery.of(context).size.width * .08,
              child: CircularProgressIndicator(
                value: null,
                backgroundColor: Colors.black,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            Text(
              'Waiting Internet Connection...',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      );
    }else{
      return MaterialApp(home: Home());
    } 
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationHome(),
    );
  }
}

class NavigationHome extends StatefulWidget {
  NavigationHome({Key key}) : super(key: key);

  @override
  _NavigationHomeState createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Join(),

    NewMatch(),

    YNAlertWindow(text: 'test', onYesPressed: (){}, onNoPressed: (){},),
    //CardFlip(text: 'Test', onTap: (){},),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: FloatingNavbar(

        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedBackgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        borderRadius: 20,
        itemBorderRadius: 15,
        /*iconSize: 30,
        fontSize: 15,*/

        items: <FloatingNavbarItem>[
          FloatingNavbarItem(
            icon: Icons.login,
            title: 'Join',
          ),

          FloatingNavbarItem(
            icon: Icons.add,
            title: 'New Match',
          ),

          FloatingNavbarItem(
            icon: Icons.format_align_center,
            title: 'TEST',
          ),
        ],
      ),
    );
  }
}