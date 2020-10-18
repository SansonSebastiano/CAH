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
  List<String> answersSent;
  int playerCounter;

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
          ));
    }
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView.builder(
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
                    onTap: () async {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            answersSent[index],
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
