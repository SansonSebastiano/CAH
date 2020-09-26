import 'package:flutter/material.dart';

import 'package:CAH/server.dart';
import 'package:CAH/player.dart';

class SlavePlayer extends StatefulWidget{
  final Player player;
  const SlavePlayer({Key key, @required this.player}) : super(key: key);

  @override
  _SlavePlayerState createState() => _SlavePlayerState();
}

class _SlavePlayerState extends State<SlavePlayer>{
  List<String> answersList;
  Server svr = Server();

  @override
  void initState() {
    getAllAnswersList();
    super.initState();
  }

  void getAllAnswersList() async {
    answersList = player.answersList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(answersList == null){
      return Scaffold(
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
      );
    }else{  
      return Scaffold(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        answersList[index],
                        //'[slave screen] \nindex : ${player.index} - \nname : ${player.name} - \nscore : ${player.score} - \nanswers : ${player.answersList}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      )
                    )
                  ]
                ),
              ),
            );
          },
        ),
      );
    }
  }
}