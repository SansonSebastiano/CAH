
import 'package:CAH/custom_AlertDialog.dart';
import 'package:CAH/main.dart';
import 'package:CAH/player.dart';
import 'package:CAH/readAnswers.dart';
import 'package:flutter/material.dart';

import 'package:CAH/server.dart';

class MasterPlayer extends StatefulWidget {
  // Parameter required
  final String matchID;   //current match ID
  final bool isFirst;     //if this player has created this match game
  final Player player;    //player's attribute

  const MasterPlayer(
      {Key key,
      @required this.matchID,
      @required this.isFirst,
      @required this.player})
      : super(key: key);

  @override
  _MasterPlayerState createState() => _MasterPlayerState(matchID: matchID, isFirst: isFirst, player: player);
}

class _MasterPlayerState extends State<MasterPlayer> {
  // Parameter required
  final String matchID;   //current match ID
  final bool isFirst;     //if this player has created this match game
  final Player player;    //player's attribute

  _MasterPlayerState({@required this.matchID, @required this.isFirst, @required this.player});

  String question;              //  get question from FireBase
  Server server = Server();     // init server istance
  List<String> plrCounter;      // players number list

  @override
  void initState() {
    initWinnerState();
    getQuestion();
    getNumPlayers();

    super.initState();
  }
  // set a bool var in FireBase
  void initWinnerState() async {
    await server.initWinnerState(matchID);
    setState(() {});
  }
  // get question randomly from FireBase
  void getQuestion() async {
    question = await server.initQuestions(matchID, isFirst);
    setState(() {});
  }  
  // get number of players in this match
  void getNumPlayers() async{
    plrCounter = await server.getPlayersCounter(matchID);
    setState(() {});
  }

  Future <void> deleteThisMatch() async{
    await server.deleteMatch(matchID);
  }

  // custom Floating Action BUtton
  Widget _getFAB() {
    // while if there are no other players
    while (plrCounter.length == 1) {
      getNumPlayers();
      // display nothing
      return Container();
    } 
    // else display FAB
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      label: Row(
        children: <Widget>[
          Text(
            'Read Answers',
            style: TextStyle(color: Colors.black,),
          ),
          
          SizedBox(width: MediaQuery.of(context).size.width*.02,),

          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ],
      ),
      icon: Container(),
      splashColor: Colors.black54,
      onPressed: () {
        // display custom Y/N AD
        return showDialog(
          context: context,
          builder: (context){
            return YNAlertWindow(
              text: "Are your sure that all players are joined?",
              onYesPressed: () {
                // on YES pressed go to Read Answers page
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReadAnswers(matchID: matchID, player: player, question: question,)));
              },
              onNoPressed: (){
                // on NO pressed close Y/N AD
                Navigator.of(context).pop();
              },
            );
          }
        );
      },
    );
  }

  // build Master Player page
  @override
  Widget build(BuildContext context) {
    //deny the come back to previous screen
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        // display current match ID on app bar
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Match: $matchID',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          leading: GestureDetector(
            child: Tooltip(
              message: 'Close this match game',
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
            onTap: () {
              return showDialog(
                context: context,
                builder: (context) {
                  return YNAlertWindow(
                    text: 'Are you sure to close this game?',
                    onNoPressed: () => Navigator.of(context).pop(),
                    onYesPressed: () {
                      deleteThisMatch();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  );
                }
              );
            },
          ),
        ),
        floatingActionButton: _getFAB(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).padding.left,
                  top: MediaQuery.of(context).size.height * .02,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).padding.top),
                  child: Text(
                    //IMPLEMENTARE CARD VIEW TINDER?
                    question,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              /*Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <CardFlip>[
                    CardFlip(
                      text: 'Test 1', 
                      onTap: (){},
                    ),
                    CardFlip(
                      text: 'Test 2', 
                      onTap: null,
                    ),
                    CardFlip(
                      text: 'Test 3', 
                      onTap: null,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: MediaQuery.of(context).size.height*.1),*/
            ],
          ),
        ),
      ),
    );
  }
}
