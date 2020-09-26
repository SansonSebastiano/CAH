import 'package:CAH/player.dart';
import 'package:CAH/server.dart';
import 'package:CAH/slavePlayer.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class Join extends StatefulWidget{
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join>{

  Server server = Server();

  final _nameInput = TextEditingController();
  final _idInput = TextEditingController();

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
                      topRight: Radius.circular(40.0)
                    ),
                  ),
                  height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.1,
                      ),
                      _TextBox(
                        label: 'Match ID',
                        wid: TextField(
                          controller: _idInput,
                          cursorColor: Colors.black,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter an ID',
                            focusColor: Colors.black,
                            hoverColor: Colors.black,
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          textAlign: TextAlign.center,
                        )
                      ),  
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.08,
                      ),
                      _TextBox(
                        label: 'Name',
                        wid: TextField(
                          controller: _nameInput,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            focusColor: Colors.black,
                            hoverColor: Colors.black,
                            border: InputBorder.none,
                            //errorText: _validate ? '\u26A0 Name missing!' : null
                          ),
                          textAlign: TextAlign.center,
                        )
                      ),  
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.08,
                      ),
                      _Button(
                        onPressed: () async{
                          if (_idInput.text.toString().isNotEmpty && _nameInput.text.toString().isNotEmpty) {
                            var flag = await server.checkMatchID(_idInput.text.toString());
                            if (flag == true  &&  _idInput.text.toString() != '0') {
                              Player player = await server.addPlayer(_idInput.text.toString(), _nameInput.text.toString(), false);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SlavePlayer(player: player,)));
                            } else {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return _AlertDialog(label: 'This ID does not exitst!');
                                },
                              );
                            }
                          } else {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return _AlertDialog(label: 'Fill the fields!');
                              },
                            );
                          }
                        }, 
                        label: 'Join', 
                        icon: Icons.subdirectory_arrow_right
                      ),
                    ]
                  ),
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
                      'Join',
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
          borderRadius: BorderRadius.circular(20.0),
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
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(12)
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
                child: wid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget{
  final Function onPressed;
  final String label;
  final IconData icon;

  _Button({@required this.onPressed, @required this.label, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30
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

class _AlertDialog extends StatelessWidget{
  final String label;

  _AlertDialog({@required this.label});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Icon(
              Icons.warning,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ) ,
    );
  }
}