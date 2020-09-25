import 'dart:async';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:CAH/player.dart';

//--------------------------------------------------------
//                     Database Path
//--------------------------------------------------------

const int max_answers = 3;

  //root
  DatabaseReference dbRoot = FirebaseDatabase.instance.reference();
  //cards' child
  const String path_cards = 'cards';
  const String path_answers = 'answers';
  const String path_questions = 'questions'; 
  //matches' child
  const String path_matches = 'matches';
  const String path_answersUsed = 'answersUsed';
  const String path_questionssUsed = 'questionsUsed';
  const String path_answersSent = 'answersSent';
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
  //Player
  Player player;

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
      return result.contains(input);
    }

    Future<List<String>> onPlayerAdded(Event event, List<String> playerList) async{
      String x = event.snapshot.key;
      playerList.add(x);
      print('player added: $playerList');
      return playerList;
    }

      Future<List<String>> loadPlayers(String matchId) async{
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

      Future<List<String>> getPlayersCount(String matchID) async{
        List<String> result = await loadPlayers(matchID);
        print('result: $result');
        return result;
      }

      Future<void> addPlayer(String matchID, String playerName, bool isMaster) async{
        DatabaseReference thisMatchRef = dbRoot.child(path_matches).child(matchID).reference(); 
        
        if (isMaster == true) {
          lastPlayerIndex = 0;
          print('master last player: ${lastPlayerIndex.toString()}');
          masterIndex = lastPlayerIndex;
          thisMatchRef.child(path_master).set(masterIndex);
        }
        else {
          listPlayers = await getPlayersCount(matchID);
          lastPlayerIndex = listPlayers.length;
          print('not master last player: ${lastPlayerIndex.toString()}');
        }

        DatabaseReference thisPlayerRef = dbRoot.child(path_matches).child(matchID).child(path_players).child(lastPlayerIndex.toString()).reference();

        thisPlayerRef.child(path_player_name).set(playerName);
        thisPlayerRef.child(path_score).set(0);

        //initAnswers(thisPlayerRef, matchID);

        playerAdded = true;
      }

      Future<void> setNewMatch (String masterName, String matchID){
        //print('name: $masterName ID: $matchID');
        return addPlayer(matchID, masterName, true);
      }

      Future<void> initAnswers(DatabaseReference dbRef, String matchID) async{
        List<String> listAns = await loadAnswers();
        print('list getted: $listAns');
        var index = 0;
        while (index < max_answers) {
          var newAnswer = listAns[new Random().nextInt(listAns.length -1)];
          print('new Answer: $newAnswer');
        }
      }

      Future<List<String>> onAnswerUsedAdded(Event event, List<String> list) async{
        String x = event.snapshot.key;
        list.add(x);
        return list;
      }

      Future<List<String>> loadAnswersUsed(String matchId) async{
        Completer completer = new Completer<List<String>>();
        List<String> list = new List<String>();
        Stream<Event> stream = dbRoot.child(path_matches).child(matchId).child(path_answersUsed).onChildAdded;
        
        stream.listen((event) {
          onAnswerUsedAdded(event, list).then((List<String> ansUsedList) {
            return new Future.delayed(new Duration(seconds: 0), ()=> ansUsedList);
          }).then((_) {
            if (!completer.isCompleted) {
              completer.complete(list);
            }
          });
        }); 
        return completer.future;
      }

      Future<List<String>> getAnswersUsedCount(String matchID) async{
        List<String> result = await loadAnswersUsed(matchID);
        return result;
      }
  }