
import 'package:CAH/cardFlip.dart';
import 'package:CAH/custom_AlertDialog.dart';
import 'package:CAH/player.dart';
import 'package:CAH/readAnswers.dart';
import 'package:flutter/material.dart';

import 'package:CAH/server.dart';

class MasterPlayer extends StatefulWidget {
  final String matchID;
  final bool isFirst;
  final Player player;

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
  final String matchID;
  final bool isFirst;
  final Player player;

  _MasterPlayerState({@required this.matchID, @required this.isFirst, @required this.player});

  String question;
  Server server = Server();
  List<String> plrCounter;

  @override
  void initState() {
    initWinnerState();
    getQuestion();
    getNumPlayers();

    super.initState();
  }

  void initWinnerState() async {
    await server.initWinnerState(matchID);
    setState(() {});
  }

  void getQuestion() async {
    question = await server.initQuestions(matchID, isFirst);
    setState(() {});
  }  

  void getNumPlayers() async{
    plrCounter = await server.getPlayersCounter(matchID);
    setState(() {});
  }

  Widget _getFAB() {
    while (plrCounter.length == 1) {
      getNumPlayers();
      return Container();
    } 
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
        YNAlertWindow(
          text: "Are your sure that all players are joined?",
          onYesPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReadAnswers(matchID: matchID, player: player, question: question,)));
          },
          onNoPressed: (){
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
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
        ),
        backgroundColor: Colors.black,
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
