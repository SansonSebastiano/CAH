import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

import 'join.dart';
import 'newMatch.dart';
import 'server.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Lock orientation in portrait mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // Splash Screen layout
    return MaterialApp(home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreen> {
  Server server = Server();         //init server
  bool connState = false;           //for verify connection to FireBase

  //first thing before [build]
  @override
  void initState() {
    getConnState();
    super.initState();
  }

  //get connection state of a client device
  void getConnState() async {
    connState = await server.isConnected();
    print("connection state : $connState");
    setState(() {});
  }

  //build Splash Screen layout
  @override
  Widget build(BuildContext context) {
    //if there is no internet connection display this
    if (!connState) {
      getConnState();     //get connection state of a client device
      
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
              //Circular Progress Indicator
              child: CircularProgressIndicator(
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
    //else display this
    }else{
      //Home layout
      return MaterialApp(home: Home());
    } 
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // display Home page layout with Custom NavBar at bottom
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
  int _selectedIndex = 1;     // select which widget's page display

  // List of Widgets contained inside the NavBar 
  static List<Widget> _widgetOptions = <Widget>[
    // Join's page
    Join(),
    // New Match's page
    NewMatch(),
    // Rules' page, NOW TESTING
    Container(),
  ];

  //set selected widget on -index- position
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //build Home page layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Cards Against Humanity',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),*/
      body: SafeArea(
        child: Center(
          // Widget selection to display
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      //build custom navbar
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

        //NavBar items
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