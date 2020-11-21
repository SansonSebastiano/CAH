import 'package:CAH/sentAnswers.dart';
import 'package:CAH/server.dart';
import 'package:flutter/material.dart';

class ReadAnswers extends StatefulWidget {
  final String matchID;
  const ReadAnswers({Key key, @required this.matchID}) : super(key: key);
  @override
  _ReadAnswersState createState() => _ReadAnswersState(matchID: matchID);
}

class _ReadAnswersState extends State<ReadAnswers> {
  final String matchID;
  _ReadAnswersState({@required this.matchID});

  Server server = Server();
  List<SentAnswers> answersSent;
  int playerCounter;
  int tappedAnswer = 0;

  @override
  void initState() {
    getAnsSent();
    countPlayer();
    super.initState();
  }

  void getAnsSent() async {
    answersSent = await server.loadAnswerSent(matchID);
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
    while (answersSent.length < playerCounter - 1) {
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
                      value: null,
                      backgroundColor: Colors.black,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Text("Wait for each player to have answer...",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.none))
                ],
              ),
            ),
          ));
    }
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView.builder(
            //modify with animated list
            itemCount: answersSent.length,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height * .4,
                child: Card(
                  elevation: 10.0,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * .1,
                      top: MediaQuery.of(context).size.height * .025),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      if (tappedAnswer < 1) {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return _YNAlertDialog(
                              label: 'Is the winning answer?', 
                              onYesPressed: () async{
                                
                              }, 
                              onNoPressed: () => Navigator.of(context).pop(),
                            );
                          }, 
                        );
                      } else {}
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            answersSent[index].answer,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
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
