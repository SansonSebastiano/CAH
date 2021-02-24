import 'dart:math';
import 'package:CAH/custom_AlertDialog.dart';
import 'package:CAH/masterPlayer.dart';
import 'package:CAH/player.dart';
import 'package:flutter/material.dart';

import 'package:CAH/server.dart';
import 'Button.dart';
import 'package:CAH/textBox.dart';

class NewMatch extends StatefulWidget{
  @override
  _NewMatchState createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch>{
  int newID;                  //get ID for create new game istance
  Server server = Server();   // init server istance

  @override
  void initState(){
    // get new ID with delay
    Future.delayed(Duration(milliseconds: 500), (){
      getNewID();
    });
    super.initState();
  }
  // get new ID randomly
  void getNewID() async{
    newID = await checkNewID();
    setState(() {});
  }
  // check if new ID randomly generated exist
  Future<int> checkNewID() async{
    // generate a new random ID
    var rndNum = 10000 + new Random().nextInt(99999 - 10000);
    // check if rndNum exist
    var flag = await server.checkMatchID(rndNum.toString());
    // if exist
    if (flag == true) {
      //re-generated a new ID
      return checkNewID();

      //else, if not exist
    } else {
      //return this ID
      return rndNum;
    }
  }
  // init controller for name input
  final _nameInput = TextEditingController();

  //IMPORTANT: Call dispose of the TextEditingController when you’ve finished using it. 
  //This ensures that you discard any resources used by the object.
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameInput.dispose();
    super.dispose();
  
  }  
  // build New Match page layout
  @override
  Widget build(BuildContext context) {
    //if ID is not generated
    if(newID == null){
      // display this
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
      //else, if is generated
    }else{  
      // display New Match Page
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
                    // display new Match ID generated
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
                  // Name text field
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
                  //to create new game
                  Button(
                    text: 'Start', 
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    onTapColor: Colors.black54,
                    onPressed: () async{
                      // if name text field is not empty
                      if (_nameInput.text.toString().isNotEmpty) {
                        //create new match and add this FIRST player
                        Player player = await server.addPlayer(newID.toString(), _nameInput.text.toString(), true);
                        // set this bool var 'false' on FireBase
                        await server.initMatchGame(newID.toString());
                        // with delay go to Master Player page
                        Future.delayed(Duration(milliseconds: 300), (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MasterPlayer(matchID: newID.toString(), isFirst: true, player: player, )));
                        });
                      }
                      //else, if is empty
                      else {
                        // display custom AD
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