import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Button.dart';
import 'custom_AlertDialog.dart';
import 'player.dart';
import 'server.dart';
import 'slavePlayer.dart';
import 'textBox.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  Server server = Server();

  // Controller for text field
  final _nameInput = TextEditingController();   //get name in input
  final _idInput = TextEditingController();     //get ID in input

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameInput.dispose();
    _idInput.dispose();
    super.dispose();
  }

  // Login form layout
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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

                  // Custom text field layout for get a Match ID in input
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

                  // Custom text field layout for get a player name in input
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
                  // To confirm and join in the game
                  Button(
                    text: 'join',
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    onTapColor: Colors.black54,
                    onPressed: () async {
                      // Check if ID and Name text field are empty
                      // if not not empty
                      if (_idInput.text.toString().isNotEmpty && _nameInput.text.toString().isNotEmpty) {
                        // Check if the Match ID in input existing
                        var flag = await server.checkMatchID(_idInput.text.toString());
                        // if not exist and no equal to zero
                        if (flag == true && _idInput.text.toString() != '0') {
                          // Set new player in current Match path on FireBase
                          Player player = await server.addPlayer(_idInput.text.toString(), _nameInput.text.toString(), false);
                          // With delay go to Slave Player Page
                          Future.delayed(Duration(milliseconds: 300), (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SlavePlayer(player: player, matchID:_idInput.text.toString())));
                          });
                          // else, if Match ID in input exist and equal to zero
                        } else {
                          // Display Custom Alert Dialog
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return WindowDialog(text: 'This ID does not exitst!');
                            },
                          );
                        }
                        // else, if one of the text field is empty
                      } else {
                        // Display Custom Alert Dialog
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
