import 'package:CAH/readAnswers.dart';
import 'package:flutter/material.dart';

import 'package:CAH/server.dart';

class MasterPlayer extends StatefulWidget {
  final String matchID;
  final bool isFirst;
  const MasterPlayer({Key key, @required this.matchID, @required this.isFirst})
      : super(key: key);

  @override
  _MasterPlayerState createState() =>
      _MasterPlayerState(matchID: matchID, isFirst: isFirst);
}

class _MasterPlayerState extends State<MasterPlayer> {
  final String matchID;
  final bool isFirst;

  _MasterPlayerState({@required this.matchID, @required this.isFirst});

  String question;
  Server server = Server();
  int plrCounter;

  @override
  void initState() {
    getQuestion();
    getNumPlayers();

    super.initState();
  }

  void getQuestion() async {
    question = await server.initQuestions(matchID, isFirst);
    setState(() {});
  }

  void getNumPlayers() async {
    var tmp = await server.getPlayersCounter(matchID);
    plrCounter = tmp.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return new Future(() => false);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.45,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 5.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 5.0,
                                  spreadRadius: 0.5,
                                )
                              ]),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *.20,
                                width: MediaQuery.of(context).size.width * 1,
                              ),
                              Text(
                                question,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        //FARE UN SHOWDIALOG CON CIRCULAR PROGRESS CHE RIMANE IN ATTESA FINO A QUANDO TUTTI I GIOCATORI HANNO RISPOSTO
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _ButtonHome(
                              onPressed: () {
                                //WARNING: se non ci sono altri giocatori da errore
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ReadAnswers(matchID: matchID)));
                              },
                              label: 'Read the answers',
                              icon: Icons.trending_flat),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .1),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          height: MediaQuery.of(context).size.height * .22,
                          width: MediaQuery.of(context).size.width * .7,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                            ),
                            child: Text(
                              'Read the question',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))),
              )
            ],
          ),
        ));
  }
}

class _ButtonHome extends StatelessWidget {
  final Function onPressed;
  final String label;
  final IconData icon;

  _ButtonHome(
      {@required this.onPressed, @required this.label, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.008,
          right: MediaQuery.of(context).size.width * 0.01,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20)),
            border: Border.all(color: Colors.white)),
        child: InkWell(
          onTap: () => onPressed(),
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.black,
            ),
            trailing: Icon(
              icon,
              color: Colors.transparent,
            ),
            title: Text(
              label.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

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

/*child: ListView.builder(
                      itemCount: sentAns.length,
                      itemBuilder: (context, index){                
                        return Container(
                          height: MediaQuery.of(context).size.height*.4,
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
                                    sentAns[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  )
                                ),
                              ]
                            ),
                          ),
                        );
                      },
                    ),*/
