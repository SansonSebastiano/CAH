import 'package:flutter/material.dart';

import 'cardFlip.dart';
import 'custom_AlertDialog.dart';
import 'player.dart';
import 'sentAnswers.dart';
import 'server.dart';
import 'slavePlayer.dart';

//DA COMMENTARE
class ReadAnswers extends StatefulWidget {
  final String matchID;
  final Player player;
  final String question;

  const ReadAnswers({Key key, @required this.matchID, @required this.player, @required this.question})
      : super(key: key);
  @override
  _ReadAnswersState createState() =>
      _ReadAnswersState(matchID: matchID, player: player, question: question);
}

class _ReadAnswersState extends State<ReadAnswers> {
  final String matchID;
  final Player player;
  final String question;

  _ReadAnswersState(
      {@required this.matchID, @required this.player, @required this.question});

  Server server = Server();
  List<SentAnswers> lstAnswersSent;
  int playerCounter;
  int tappedAnswer = 0;

  @override
  void initState() {
    getAnsSent();
    countPlayer();
    super.initState();
  }

  void getAnsSent() async {
    lstAnswersSent = await server.loadAnswerSent(matchID);
    setState(() {});
  }

  void countPlayer() async {
    var tmp = await server.getPlayersCounter(matchID);
    playerCounter = tmp.length;
    print('counter : $playerCounter');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    while (lstAnswersSent.length < playerCounter - 1) {
      getAnsSent();
      return WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .15,
                  width: MediaQuery.of(context).size.width * .3,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Text(
                  "Wait for each player to have answer...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } //while
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * .02,
                  top: MediaQuery.of(context).size.height * .02,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).padding.top),
                  child: Text(
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

              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lstAnswersSent.length,
                  itemBuilder: (context, index) {
                    return CardFlip(
                      text: lstAnswersSent[index].answer,
                      onTap: (){
                        if (tappedAnswer < 1) {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return YNAlertWindow(
                                text: 'Is the winning answer?',
                                onYesPressed: () async{
                                  await server.setWinner(matchID, index, lstAnswersSent);
                                  tappedAnswer++;

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SlavePlayer(matchID: matchID, player: player,)));
                                },
                                onNoPressed: () => Navigator.of(context).pop(),
                              );
                            }
                          );
                        }
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.1),      
            ],
          ),
        ),
      ),
    );
  }
}