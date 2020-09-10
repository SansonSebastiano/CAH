import 'package:flutter/material.dart';

class NewMatch extends StatelessWidget{
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
                     //textbox
                          _TextBox(
                            label: 'Match ID',
                            wid: ListTile(
                              title: Text(
                              'Random Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            )
                          ),  
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.08,
                        ),
                        _TextBox(
                          label: 'Name',
                          wid: TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                              border: InputBorder.none
                            ),
                            textAlign: TextAlign.center,
                          )
                        ),  
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.08,
                        ),
                        _ButtonHome(
                        onPressed: (){}, 
                        label: 'Start', 
                        icon: Icons.subdirectory_arrow_right
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
                      top: MediaQuery.of(context).size.width*.15,
                      bottom: 10
                    ),
                    child: Text(
                      'New Match',
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

class _TextBox extends StatelessWidget{
  final String label;
  final Widget wid;

  _TextBox({ @required this.label, @required this.wid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.white,
            width: 0.0
          ),
          color:  Colors.grey[300]
        ),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 6.0,
            right: 4.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(6)
            ),
            border: Border.all(
              color: Colors.white
            )
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
                  fontSize: 30.0
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.02,
                  right: MediaQuery.of(context).size.width*0.15,
                  left: MediaQuery.of(context).size.width*0.15,
                  bottom: MediaQuery.of(context).size.height*0.01
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: wid
                /*child: ListTile(
                  title: Text(
                    'Random Number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  )
                ),*/
              ),
            ],
          ),
        ),
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
        right: 30
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
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
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(6)
            ),
            border: Border.all(
              color: Colors.white
            )
          ),
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
            onTap: () => onPressed(),
          ),
        ),
      ),
    );
  }
}