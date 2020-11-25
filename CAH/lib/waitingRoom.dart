
import 'package:CAH/server.dart';
import 'package:flutter/material.dart';

class WaitingRoom extends StatefulWidget {
  final String matchID;

  const WaitingRoom({Key key, @required this.matchID}) : super(key: key);

  @override
  _WaitingRoomState createState() => _WaitingRoomState(matchID: matchID);
}

class _WaitingRoomState extends State<WaitingRoom> {
  final String matchID;

  _WaitingRoomState({@required this.matchID});

  Server server = Server();
  int masterID;
  List<String> playersList = List<String>();
  bool masterState;
  String isWinSetted;

  @override
  void initState() {
    getMasterID();
    getPlayers();
    getMasterSetted();
    super.initState();
  }

  void getMasterID() async {
    masterID = await server.getMasterID(matchID);
    setState(() {});
  }

  void getPlayers() async {
    playersList = await server.getPlayersCounter(matchID);
    setState(() {});
  }

  void getMasterState() async{
    masterState = await server.checkWhoIsMaster(masterID, playersList);
    setState(() { });
  }

  void getMasterSetted() async{
    isWinSetted = await server.isWinnerSetted(matchID);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    while (isWinSetted == 'false') {
      getMasterSetted();
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
                      decoration: TextDecoration.none),
                )
              ],
            ),
          ),
        )
      );
    } 
    print('object1 : $masterState');
    getMasterState();
    print('object2 : $masterState');
    if (masterState == true) {
      return Container(
        child: Text(
          'master : $masterState',
        ),
      );
      //vai a MasterPlayer
      //Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingRoom(matchID: matchID,)));
    } else {
      
      //Navigator.of(context).pop();
      //Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingRoom(matchID: matchID,)));
      return Container(
        child: Text(
          'master : $masterState',
        ),
      );
    }
  }
}
