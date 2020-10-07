import 'package:flutter/material.dart';

import 'package:CAH/server.dart';

class MasterPlayer extends StatefulWidget{
  final String matchID;
  final bool isFirst;
  const MasterPlayer({Key key, @required this.matchID, @required this.isFirst}) : super(key: key);

  @override 
  _MasterPlayerState createState() => _MasterPlayerState(matchID: matchID, isFirst: isFirst);
}

class _MasterPlayerState extends State<MasterPlayer>{
  String question;
  Server server = Server();
  final String matchID;
  final bool isFirst;
  
  _MasterPlayerState({@required this.matchID, @required this.isFirst});

  @override
  void initState(){
    getQuestion();
    super.initState();
  }

  void getQuestion() async{
    question = await server.initQuestions(matchID, isFirst);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return new Future(() => false);
      }, 
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.zero,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width*0.5
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0),
                        ),
                        border: Border.all(
                          color:  Colors.white,
                          width: 5.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                          )
                        ]
                      ),
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index){
                          return Container(
                            height: MediaQuery.of(context).size.height*.4,
                            /*child: FlipView(
                              front: Container(
                                width: 300,
                                height: 500,
                                color: Colors.amber,
                                alignment: Alignment.center,
                                child: Text('Front'),
                              ), 
                              back: Container(
                                width: 300,
                                height: 500,
                                color: Colors.blueGrey,
                                alignment: Alignment.center,
                                child: Text('Back'),
                              ),
                              animationController: null
                            ),*/
                            child: Card(
                              elevation: 10.0,
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width*0.1,
                                right: MediaQuery.of(context).size.width*0.1,
                                top: MediaQuery.of(context).size.height*0.05
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(
                                      'ciao',
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
                    ),
                  ),
                ), 
              ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        //offset: Offset(2.0, 2.0)
                      )
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0)
                    )
                  ),
                  height: MediaQuery.of(context).size.height*.22,
                  width: MediaQuery.of(context).size.width*.7,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: MediaQuery.of(context).size.width*.15,
                      bottom: 10
                    ),
                    child: Text(
                      question,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              )
            ),
          )
        ],
      ),
    )
    );
  }
}