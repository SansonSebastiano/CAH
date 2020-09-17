import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//--------------------------------------------------------
//                     Database Path
//--------------------------------------------------------
  //root
  DatabaseReference dbRoot = FirebaseDatabase.instance.reference();
  //cards' child
  const String path_cards = 'cards';
  const String path_answers = 'answers';
  const String path_questions = 'questions'; 
  //matches' child
  const String path_matches = 'matches';
    //players
    const String path_players = 'players';
    const String path_answers_per_player = 'answersPerPlayer';
    const String path_player_name = 'playerName';
    const String path_score = 'score';
    const String path_master = 'master';
  //booleans
  bool playerAdded = false;
  //lists
  List<String> listAnswers = List<String>();
  List<String> listPlayers = List<String>();
  //counters
  int lastPlayerIndex;
  int masterIndex;

  class Server{
    Server(){
      Firebase.initializeApp();
    }

    Future<bool> isConnected() async{
      DataSnapshot dataSnapshot = await dbRoot.child('.info/connected').once();
      bool amIOnline = dataSnapshot.value;
      if (amIOnline == true) {
          return amIOnline;
      } else {
        return amIOnline;
      }
    }

    Future<List<String>> loadAnswers() async{
      DataSnapshot snapshot = await dbRoot.child(path_cards).child(path_answers).once();

      var value = snapshot.value;
      var list = List<String>();
      
      for (var answer in value) {
        list.add(answer.toString());
      }
      return list;
    }

    Future<List<String>> onMatchIdAdded(Event event, List<String> idList) async{
      String x = event.snapshot.key;
      idList.add(x);
      return idList;
    }

    Future<List<String>> loadMatchID() async{
      Completer completer = new Completer<List<String>>();
      List<String> list = new List<String>();
      Stream<Event> stream = dbRoot.child(path_matches).onChildAdded;

      stream.listen((event) {
        onMatchIdAdded(event, list).then((List<String> idList) {
          return new Future.delayed(new Duration(seconds: 0), ()=> idList);
        }).then((_) {
          if (!completer.isCompleted) {
            completer.complete(list);
          }
        });
      });
      return completer.future;
    }

    Future<bool> checkMatchID(String input)async{
      List<String> result = await loadMatchID();
      //print('id list: $result');
      return result.contains(input);
    }

    Future<List<String>> onPlayerAdded(Event event, List<String> playerList) async{
      String x = event.snapshot.key;
      playerList.add(x);
      return playerList;
    }

      Future<List<String>> loadPlayer(String matchId) async{
        Completer completer = new Completer<List<String>>();
        List<String> list = new List<String>();
        Stream<Event> stream = dbRoot.child(path_matches).child(matchId).child(path_players).onChildAdded;

        stream.listen((event) {
          onPlayerAdded(event, list).then((List<String> playerList) {
            return new Future.delayed(new Duration(seconds: 0), ()=> playerList);
          }).then((_) {
            if (!completer.isCompleted) {
              completer.complete(list);
            }
          });
        }); 
        return completer.future;
      }

      Future<List<String>> printPlayersCount(String matchID) async{
        List<String> result = await loadPlayer(matchID);
        return result;
      }

      Future<void> addPlayer(String matchID, String playerName, bool isMaster) async{
        listPlayers = await printPlayersCount(matchID);
        lastPlayerIndex = listPlayers.length;
        print(lastPlayerIndex.toString());

        DatabaseReference thisMatchRef = dbRoot.child(path_matches).child(matchID).reference(); 
        DatabaseReference thisPlayerRef = dbRoot.child(path_matches).child(matchID).child(path_players).child(lastPlayerIndex.toString()).reference();

        if (isMaster == true) {
          masterIndex = lastPlayerIndex;
          thisMatchRef.child(path_master).set(masterIndex);
        }

        thisPlayerRef.child(path_player_name).set(playerName);
        thisPlayerRef.child(path_score).set(0);

        //initAnswer DIO SCLERO

        playerAdded = true;
      }

      // ignore: missing_return
      Future<void> setNewMatch (String masterName, String matchID){
        addPlayer(matchID, masterName, true);
      }
  }