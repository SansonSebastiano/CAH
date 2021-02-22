import 'dart:math';
import 'package:CAH/custom_AlertDialog.dart';
import 'package:CAH/masterPlayer.dart';
import 'package:CAH/player.dart';
import 'package:flutter/material.dart';

import 'package:CAH/server.dart';
import 'Button.dart';
import 'package:CAH/textBox.dart';

//INTRODURRE ALERT DIALOG CON MATCH ID DA COMUNICARE AGL'ALTRI GIOCATORI

class NewMatch extends StatefulWidget{
  @override
  _NewMatchState createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch>{
  int newID;
  Server server = Server();

  @override
  void initState(){
    Future.delayed(Duration(milliseconds: 500), (){
      getNewID();
    });
    super.initState();
  }

  void getNewID() async{
    newID = await checkNewID();
    setState(() {});
  }

  Future<int> checkNewID() async{
    var rndNum = 10000 + new Random().nextInt(99999 - 10000);
    var flag = await server.checkMatchID(rndNum.toString());

    if (flag == true) {
      return checkNewID();
    } else {
      return rndNum;
    }
  }

  final _nameInput = TextEditingController();

  //Important: Call dispose of the TextEditingController when you’ve finished using it. 
  //This ensures that you discard any resources used by the object.

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameInput.dispose();
    super.dispose();
  
  }  

  @override
  Widget build(BuildContext context) {
    if(newID == null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*.15,
            width: MediaQuery.of(context).size.width*.31,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              backgroundColor: Colors.white,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*.1,
          ),
          Text(
            "Generating new ID...",
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 20,
              color: Colors.white,
            )
          )
        ],
      );
    }else{  
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
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              height: MediaQuery.of(context).size.height*.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextBox(
                      label: 'Match ID',
                      wid: ListTile(
                        title: Text(
                        newID.toString(),
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
                        //errorText: _validate ? '\u26A0 Name missing!' : null
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),  
                  
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.05,
                  ),

                  //DISABLE BUTTON WHEN THE FIELDS ARE EMPTY
                  Button(
                    text: 'Start', 
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    onTapColor: Colors.black54,
                    onPressed: () async{
                      if (_nameInput.text.toString().isNotEmpty) {
                        Player player = await server.addPlayer(newID.toString(), _nameInput.text.toString(), true);
                        await server.initWinnerState(newID.toString());

                        Future.delayed(Duration(milliseconds: 300), (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPlayer(matchID: newID.toString(), isFirst: true, player: player, )));
                        });
                      }
                      else {
                        //SOSTITURE CON WINDOWDIALOG
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return WindowDialog(text: 'Name missing!',);
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
}