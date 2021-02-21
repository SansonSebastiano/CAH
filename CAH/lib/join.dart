import 'package:CAH/player.dart';
import 'package:CAH/server.dart';
import 'package:CAH/slavePlayer.dart';
import 'package:CAH/textBox.dart';
import 'package:CAH/custom_AlertDialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Button.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  Server server = Server();

  final _nameInput = TextEditingController();
  final _idInput = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameInput.dispose();
    _idInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*Text(
          'Cards \nAgainst \nHumanity',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),*/

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width*.04,
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white54,
                  offset: Offset(7.0, 5.0),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30),),
            ),
            height: MediaQuery.of(context).size.height*.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  TextBox(
                    label: 'Match ID',
                    wid: TextField(
                      controller: _idInput,
                      cursorColor: Colors.black,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter an ID',
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*.05,
                  ),

                  TextBox(
                    label: 'Name',
                    wid: TextField(
                      controller: _nameInput,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height*.05,
                  ),

                  //DISABLE BUTTON WHEN THE FIELDS ARE EMPTY
                  Button(
                    text: 'join',
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    onTapColor: Colors.black54,
                    onPressed: () async {
                      
                      if (_idInput.text.toString().isNotEmpty && _nameInput.text.toString().isNotEmpty) {
                        var flag = await server.checkMatchID(_idInput.text.toString());
                        if (flag == true &&_idInput.text.toString() != '0') {
                          Player player = await server.addPlayer(_idInput.text.toString(), _nameInput.text.toString(), false);

                          Future.delayed(Duration(milliseconds: 300), (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SlavePlayer(player: player, matchID:_idInput.text.toString())));
                          });
                        } else {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return WindowDialog(text: 'This ID does not exitst!');
                            },
                          );
                        }
                      } else {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return WindowDialog(text: 'Fill the fields!');
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
