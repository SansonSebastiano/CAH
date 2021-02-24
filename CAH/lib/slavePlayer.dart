import 'package:CAH/cardFlip.dart';
import 'package:CAH/custom_AlertDialog.dart';
import 'package:CAH/main.dart';
import 'package:CAH/waitingRoom.dart';
import 'package:flutter/material.dart';

import 'package:CAH/server.dart';
import 'package:CAH/player.dart';

class SlavePlayer extends StatefulWidget {
  final Player player;
  final String matchID;

  const SlavePlayer({Key key, @required this.player, @required this.matchID})
      : super(key: key);

  @override
  _SlavePlayerState createState() =>
      _SlavePlayerState(matchID: matchID, player: player);
}

class _SlavePlayerState extends State<SlavePlayer> {
  final String matchID;
  final Player player;

  _SlavePlayerState({@required this.matchID, @required this.player});

  List<String> answersList;
  Server server = Server();
  int countSentAns = 0;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool lg;

  @override
  void initState() {
    getAllAnswersList();
    getLGState();
    super.initState();
  }

  void getAllAnswersList() {
    answersList = player.answersList;
    setState(() {});
  }

  Future<bool> getLGState() async {
    lg = await server.getLeaveGameState(matchID);
    if (lg) {
      print('LG : $lg');
      return lg;
    } else {
      print('LG : $lg');
      getLGState();
    }
    return lg;
  }

  void exit() async {
    await server.leaveGame(matchID, player.index);
  }

  @override
  Widget build(BuildContext context) {
    if (answersList == null) {
      return WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * .3,
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          ),
        )
      );
    } else {
      return FutureBuilder(         //NON FUNZIONA
        future: getLGState(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData && lg) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
          } else {
            return WillPopScope(
              onWillPop: () {
                return new Future(() => false);
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                floatingActionButton: fab(),
                appBar: appBar(),
                body: SafeArea(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: answersList.length,
                    itemBuilder: (context, index, animation) {
                      return _buildList(context, answersList[index], animation, index);
                    },
                  ),
                ),
              )
            );
          }
        },
      );
    } //else
  }

  /*
    return WillPopScope(
          onWillPop: () {
            return new Future(() => false);
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            floatingActionButton: fab(),
            appBar: appBar(),
            body: SafeArea(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: answersList.length,
                itemBuilder: (context, index, animation) {
                  return _buildList(
                      context, answersList[index], animation, index);
                },
              ),
            ),
          )
        );
   */

  Widget fab() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.red[400],
      label: Text(
        'Leave game',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      icon: Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
      onPressed: () {
        return showDialog(
            context: context,
            builder: (context) {
              return YNAlertWindow(
                text: 'Are you sure to leave the game?',
                onNoPressed: () => Navigator.of(context).pop(),
                onYesPressed: () {
                  exit();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              );
            });
      },
    );
  }

  Widget appBar() {
    return AppBar(
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
    );
  }

  Widget _buildList(BuildContext context, String item,
      Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: CustomCard(
        text: item,
        fontSize: 20.0,
        onTap: () {
          //N.B. esistono domande che richiedono due o piu risposte
          if (countSentAns < 1) {
            return showDialog(
                context: context,
                builder: (context) {
                  return YNAlertWindow(
                    text: 'Are you sure to send this answer?',
                    onYesPressed: () async {
                      await server.sendAnswer(index, matchID, player);
                      _removeItemAt(index);

                      _addItemAt(await server.refillAnswer(player, matchID),
                          answersList.length);

                      countSentAns++;

                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WaitingRoom(
                                    matchID: matchID,
                                    player: player,
                                  )));
                    },
                    onNoPressed: () => Navigator.of(context).pop(),
                  );
                });
          } else {
            return showDialog(
                context: context,
                builder: (context) {
                  return WindowDialog(
                    text: 'You can send only one answer!',
                  );
                });
          }
        },
      ),
    );
  }

  void _removeItemAt(int index) {
    String removedItem = answersList.removeAt(index);
    AnimatedListRemovedItemBuilder removedItemBuilder = (context, animation) {
      return _buildList(context, removedItem, animation, index);
    };
    _listKey.currentState.removeItem(index, removedItemBuilder);
  }

  void _addItemAt(String element, int index) {
    answersList.insert(index, element);
    _listKey.currentState.insertItem(index);
  }
}
