import 'package:CAH/cardFlip.dart';
import 'package:CAH/custom_AlertDialog.dart';
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
  _SlavePlayerState createState() => _SlavePlayerState(matchID: matchID, player: player);
}

class _SlavePlayerState extends State<SlavePlayer> {
  final String matchID;
  final Player player;

  _SlavePlayerState({@required this.matchID, @required this.player});

  List<String> answersList;
  Server server = Server();
  int countSentAns = 0;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    getAllAnswersList();
    super.initState();
  }

  void getAllAnswersList() {
    answersList = player.answersList;
    setState(() {});
  }

  showSnackBar(context, answer, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text('$answer sent'),
    ));
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
          ));
    } else {
      return WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
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
          body: SafeArea(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: answersList.length,
              itemBuilder: (context, index, animation){
                return _buildList(context, answersList[index], animation, index);
              },
            ),
          ),
        )
      );
    }
  }

  Widget _buildList(BuildContext context, String item, Animation<double> animation, int index){
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: CustomCard(
        text: item,
        fontSize: 20.0,
        onTap: (){
          //N.B. esistono domande che richiedono due o piu risposte
          if (countSentAns < 1) {
            return showDialog(
              context: context,
              builder: (context){
                return YNAlertWindow(
                  text: 'Are you sure to send this answer?',
                  onYesPressed: () async{
                    await server.sendAnswer(index, matchID, player);
                    _removeItemAt(index);

                    _addItemAt(
                      await server.refillAnswer(player, matchID),
                      answersList.length
                    );

                    countSentAns++;

                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingRoom(matchID: matchID, player: player,)));
                  },
                  onNoPressed: () => Navigator.of(context).pop(),
                );
              }
            );
          } else {
            return showDialog(
              context: context,
              builder: (context){
                return WindowDialog(text: 'You can send only one answer!',);
              }
            );
          }
        },
      ),
    );
  }

  void _removeItemAt(int index){
    String removedItem = answersList.removeAt(index);
    AnimatedListRemovedItemBuilder removedItemBuilder = (context, animation){
      return _buildList(context, removedItem, animation, index);
    };
    _listKey.currentState.removeItem(index, removedItemBuilder);
  }

  void _addItemAt(String element, int index){
    answersList.insert(index, element);
    _listKey.currentState.insertItem(index);
  }
}

/*
  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: answersList.length,
                itemBuilder: (context, index){
                  return CustomCard(
                    text: answersList[index].toString(),
                    fontSize: 20.0,
                    onTap: (){},                    
                  );
                },
              ),
 */

/* body: AnimatedList(
            key: _listKey,
            initialItemCount: answersList.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(
                  context, answersList[index], animation, index);
            }
          )

  Widget _buildItem(BuildContext context, String item, Animation<double> animation, int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizeTransition(
        //ci sono altre animazioni
        sizeFactor: animation,
        axis: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: Card(
              shape: RounddRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: InkWell(
                  splashColor: Colors.black,
                  child: Center(
                    child: Text(
                      item,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  onTap: () {
                    //N.B. esistono domande che richiedono due risposte
                    if (countSentAns < 1) {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return _YNAlertDialog(
                            label: 'Are you sure to send this answer?',
                            onYesPressed: () async {
                              await server.sendAnswer(index, matchID, player);
                              _removeItemAt(index);

                              _addItemAt(
                                  await server.refillAnswer(player, matchID),
                                  answersList.length);

                              countSentAns++;

                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingRoom(matchID: matchID, player: this.player,)));
                            },
                            onNoPressed: () => Navigator.of(context).pop(),
                          );
                        },
                      );
                    } else {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return _AlertDialog(label: 'You can send only one question!');
                        },
                      );
                    }
                  })),
        ),
      ),
    );
  }

  void _removeItemAt(int index) {
    String removedItem = answersList.removeAt(index);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(context, removedItem, animation, index);
    };
    _listKey.currentState.removeItem(index, builder);
  }

  void _addItemAt(String element, int index) {
    answersList.insert(index, element);
    _listKey.currentState.insertItem(index);
  }
}

class _AlertDialog extends StatelessWidget {
  final String label;

  _AlertDialog({@required this.label});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _YNAlertDialog extends StatelessWidget {
  final String label;
  final Function onYesPressed;
  final Function onNoPressed;

  _YNAlertDialog(
      {@required this.label,
      @required this.onYesPressed,
      @required this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        RaisedButton(
          onPressed: () => onYesPressed(),
          color: Colors.white,
          child: const Text(
            'Yes',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        RaisedButton(
          onPressed: () => onNoPressed(),
          color: Colors.white,
          child: const Text(
            'No',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
/*_AlertDialog(
      label: label,
      yesButton: RaisedButton(
        onPressed: () => onYesPressed,
        color: Colors.white,
        child: const Text(
          'Yes',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ),
      noButton: RaisedButton(
        onPressed: () => onNoPressed,
        color: Colors.white,
        child: const Text(
          'No',
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold, 
            fontSize: 15
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }*/

/*class TestAD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.red,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text('Are you sure to send this answer?',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: 20
          ),
          textAlign: TextAlign.center
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              print('yes pressed');
            },
            elevation: 5,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              //side: BorderSide(color: Colors.red)
            ),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            elevation: 5,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              //side: BorderSide(color: Colors.red)
            ),
            child: const Text(
              'No',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ]);
  }
}*/

/*print('card tapped n°: $index');
  await server.sendAnswer(index, matchID, player);
  showSnackBar( context, player.answersList[index], index );
  countSentAns++; */

/*ListView.builder(
              //key: Key(answersList.length.toString()),
              itemCount: answersList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height * .4,
                  child: Card(
                      elevation: 10.0,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.height * 0.025),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          if (countSentAns < 1) {
                            return showDialog(
                              context: context,
                              builder:  (context){
                                return _YNAlertDialog(
                                  label: 'Are you sure to send this answer?', 
                                  onYesPressed: () async    {
                                    print('card tapped n°: $index');
                                    await server.sendAnswer(index, matchID, player);
                                    //showSnackBar( context, player.answersList[index], index );
                                    //removeCard(index);      NON FUNZIONA
                                    countSentAns++;
                                    Navigator.of(context).pop();
                                  }, 
                                  onNoPressed: (){
                                    Navigator.of(context).pop();
                                  }                            
                                );
                              }
                            );
                          } else {
                            return showDialog(
                              //barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return _AlertDialog(
                                  label:'You can only send only one question!',
                                );
                              },
                            );
                          }
                        },
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                            ListTile(
                              title: Text(
                                answersList[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                );
              },
            ),*/
            
            */
