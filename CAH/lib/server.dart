import 'dart:async';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:CAH/player.dart';

//--------------------------------------------------------
//                     Database's Paths
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
  bool masterPlayer = false;
  bool answersDelivered = false;
  //lists
  List<String> listAnswers = List<String>();
  List<Player> listPlayers = List<Player>();
  List<String> listAnswersUsed = List<String>();
  List<String> listMatchID = List<String>();
  //counters
  int masterIndex;
  int lastPlayerIndex;
  int lastAnswerUsed;
  //Player
  Player player;
  String playerIndex;
  String playerName;
  String playerScore;
  List<String> playerAnswers;

  class Server{
    Server(){ Firebase.initializeApp(); }

    Future<bool> isConnected() async{
      DataSnapshot dataSnapshot = await dbRoot.child('.info/connected').once();
      bool amIOnline = dataSnapshot.value;
      if (amIOnline == true) {
          return amIOnline;
      } else {
        return amIOnline;
      }
    }

    /*Future<List<String>> loadElements(DatabaseReference elementsPath) async{

    }*/

    Future<List<String>> loadAnswers() async{
      DataSnapshot snapshot = await dbRoot.child(path_cards).child(path_answers).once();

      var value = snapshot.value;
      var list = List<String>();
      
      for (var answer in value) {
        list.add(answer.toString());
      }
      return list;
    }

    Future<List<String>> loadAnswersPerPlayer(DatabaseReference dbRef) async{
      DataSnapshot snapshot = await dbRef.child(path_answers_per_player).once();

      var value = snapshot.value;
      var list = List<String>();

      for (var answer in value) {
        list.add(answer.toString());
      }
      return list;
    }

    Future<List<String>> onElementAdded(Event event, List<String> list) async{
        String key = event.snapshot.key;
        list.add(key);
        return list;
    }

    Future<List<String>> loadMatchID() async{
      Completer completer = new Completer<List<String>>();
      List<String> list = new List<String>();
      Stream<Event> stream = dbRoot.child(path_matches).onChildAdded;

      stream.listen((event) {
        onElementAdded(event, list).then((List<String> idList) {
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
      listMatchID = await loadMatchID();
      return listMatchID.contains(input);
    }

    Future<List<String>> countPlayers(String matchId) async{
      Completer completer = new Completer<List<String>>();
      List<String> list = new List<String>();
      Stream<Event> stream = dbRoot.child(path_matches).child(matchId).child(path_players).onChildAdded;
      
      stream.listen((event) {
        onElementAdded(event, list).then((List<String> playerList) {
          return new Future.delayed(new Duration(seconds: 0), ()=> playerList);
        }).then((_) {
          if (!completer.isCompleted) {
            completer.complete(list);
          } 
        });
      }); 
      return completer.future;
    }

    Future<List<String>> getPlayersCounter(String matchID) async{
      List<String> result = await countPlayers(matchID);
      return result;
    }

    Future<Player> addPlayer(String matchID, String playerName, bool isMaster) async{
      DatabaseReference thisMatchRef = dbRoot.child(path_matches).child(matchID).reference(); 

      if (isMaster == true) {
        lastPlayerIndex = 0;
        masterIndex = lastPlayerIndex;
        thisMatchRef.child(path_master).set(masterIndex);

        masterPlayer = true;
      }
      else {
        List<String> tmp = await getPlayersCounter(matchID);
        lastPlayerIndex = tmp.length;

        masterPlayer = false;
      }

      playerIndex = lastPlayerIndex.toString();

      DatabaseReference thisPlayerRef = dbRoot.child(path_matches).child(matchID).child(path_players).child(lastPlayerIndex.toString()).reference();

      thisPlayerRef.child(path_player_name).set(playerName);
      thisPlayerRef.child(path_score).set(0);

      await initAnswers(thisPlayerRef, matchID, masterPlayer);
      
      Player plr = await getPlayer(lastPlayerIndex.toString(), matchID);
      print('[Server] player answer: ${plr.answersList} - score ${plr.score} - name ${plr.name} - index ${plr.index}');

      playerAdded = true;
      return plr;
    }

    Future<Player> getPlayer(String index, String matchID) async{
      DatabaseReference playerRef = dbRoot.child(path_matches).child(matchID).child(path_players).child(index).reference();
      DataSnapshot name = await playerRef.child(path_player_name).once();
      DataSnapshot score = await playerRef.child(path_score).once();

      playerIndex = index;
      playerName = name.value.toString();
      playerScore = score.value.toString();
      playerAnswers = await loadAnswersPerPlayer(playerRef);

      player = new Player(index: int.parse(playerIndex), name: playerName, score: int.parse(playerScore), answersList: playerAnswers);
      
      return player;
    }

    Future<void> setNewMatch (String masterName, String matchID){
      masterPlayer = true;
      return addPlayer(matchID, masterName, masterPlayer);
    }

    Future<void> initAnswers(DatabaseReference dbRef, String matchID, bool isMaster) async{
      DatabaseReference ansUsedRef = dbRoot.child(path_matches).child(matchID).child(path_answersUsed).reference();
      bool isExisting = false;
      List<String> listAns = await loadAnswers();

      var index = 0;
      while (index < max_answers) {
        var newAnswer = listAns[new Random().nextInt(listAns.length -1)];

        if (isMaster == true) {
          lastAnswerUsed = 0;
          isMaster = false;
        } else {
          List<String> tmp = await loadAnswersUsed(matchID);
          lastAnswerUsed = tmp.length;

          isExisting = await checkAnswer(newAnswer, matchID); 
        }        

        if (isExisting == false) {
          dbRef.child(path_answers_per_player).child(index.toString()).set(newAnswer);
          ansUsedRef.child(lastAnswerUsed.toString()).set(newAnswer);
        }else{
          continue;
        }
        index++;
      }

      answersDelivered = true;
    }

    Future<bool> checkAnswer(String newAnswer, String matchID) async{
      listAnswersUsed = await loadAnswersUsed(matchID);
      return listAnswersUsed.contains(newAnswer);
    }

    Future<List<String>> loadAnswersUsed(String matchID) async{
      DataSnapshot snapshot = await dbRoot.child(path_matches).child(matchID).child(path_answersUsed).once();

      var value = snapshot.value;
      var list = List<String>();
      
      for (var answer in value) {
        list.add(answer.toString());
      }

      return list;
    }
  }