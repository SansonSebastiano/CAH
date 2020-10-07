import 'package:flutter/material.dart';

import 'package:CAH/server.dart';
import 'package:CAH/player.dart';

class SlavePlayer extends StatefulWidget{
  final Player player;
  final String matchID;
  const SlavePlayer({Key key, @required this.player, @required this.matchID}) : super(key: key);

  @override
  _SlavePlayerState createState() => _SlavePlayerState(matchID: matchID);
}

class _SlavePlayerState extends State<SlavePlayer>{
  final String matchID;

  _SlavePlayerState({@required this.matchID});

  List<String> answersList;
  Server server = Server();
  int countSentAns = 0;

  @override
  void initState() {
    getAllAnswersList();
    super.initState();
  }

  void getAllAnswersList() {
    answersList = player.answersList;
    setState(() {});
  }

  removeCard(index){
    setState(() {
      player.answersList.remove(index);
    });
  }

  showSnackBar(context, answer, index){
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black, 
      content: Text('$answer sent'),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if(answersList == null){
      return WillPopScope( 
        onWillPop: (){
          return new Future(() => false);
        },
        child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: CircularProgressIndicator(
              value: null,
              backgroundColor: Colors.black,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        ),
      )
    );
    }else{  
      return WillPopScope( 
        onWillPop: (){
          return new Future(() => false);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ListView.builder(
            itemCount: answersList.length,
            itemBuilder: (context, index){
              return Container(
                height: MediaQuery.of(context).size.height*.4,
                child: Card(
                  elevation: 10.0,
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*0.1,
                    right: MediaQuery.of(context).size.width*0.1,
                    top: MediaQuery.of(context).size.height*0.025
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: InkWell(
                    splashColor: Colors.black,
                    onTap: () async{
                      if (countSentAns < 1) {
                        print('card tapped n°: $index');
                        await server.sendAnswer(index, matchID, player);
                        removeCard(index);
                        showSnackBar(context, player.answersList[index], index);
                        countSentAns++;
                      } else {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return _AlertDialog(label: 'You can only send only one question!');
                          },
                        );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            answersList[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          )
                        ),
                      ]
                    ),
                  )
                ),
              );
            },
          ),
        )
      );
    }
  }
}

class _AlertDialog extends StatelessWidget{
  final String label;

  _AlertDialog({@required this.label});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
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
            height: MediaQuery.of(context).size.height*0.02,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ) ,
    );
  }
}