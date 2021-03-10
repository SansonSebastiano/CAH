import 'package:flutter/material.dart';

import 'masterPlayer.dart';
import 'player.dart';
import 'server.dart';
import 'slavePlayer.dart';

class WaitingRoom extends StatefulWidget {
  final String matchID;
  final Player player;

  const WaitingRoom({Key key, @required this.matchID, @required this.player})
      : super(key: key);

  @override
  _WaitingRoomState createState() =>
      _WaitingRoomState(matchID: matchID, player: player);
}

class _WaitingRoomState extends State<WaitingRoom> {
  final String matchID;
  final Player player;

  _WaitingRoomState({@required this.matchID, @required this.player});

  Server server = Server();
  bool winState;
  int masterID;
  List<String> indexPlrList = List<String>();
  bool masterState;

  Future<bool> boh() async {
    winState = await server.isWinnerSetted(matchID);
    if (winState) {
      masterID = await server.getMasterID(matchID);
      indexPlrList = await server.getPlayersCounter(matchID);
      masterState = server.checkWhoIsMaster(masterID, indexPlrList);
    } else {
      return boh();
    }
    return winState;
  }

  Future<void> initSentAnswers() async {
    await server.initSentAnswers(matchID);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          body: FutureBuilder(
            future: boh(),
            builder: (context, snapshot) {
              if (snapshot.hasData && winState) {
                if (masterState) {      //è qui il problema
                  initSentAnswers();
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MasterPlayer(
                                isFirst: false,
                                matchID: matchID,
                                player: player)));
                  });

                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                            width: MediaQuery.of(context).size.width * .3,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Text(
                            'Drawing a new question for you...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SlavePlayer(
                                  matchID: this.matchID,
                                  player: this.player,
                                )));
                  });

                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
                            width: MediaQuery.of(context).size.width * .3,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Text(
                            'Waiting for new round...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return Scaffold(
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
                          'Waiting...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ));
  }
}
