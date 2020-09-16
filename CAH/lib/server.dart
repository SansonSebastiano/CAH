import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//--------------------------------------------------------
//                     Database Path
//--------------------------------------------------------
  //cards
  const String cards_path = 'cards';
  const String answers_path = 'answers';
  const String questions_path = 'questions'; 
  //matches
  const String matches_path = 'matches';

  class Server{
    Server(){
      Firebase.initializeApp();
    }

    DatabaseReference dbRef = FirebaseDatabase.instance.reference();

    Future<List<String>> loadAnswers() async{
      DataSnapshot snapshot = await dbRef.child(cards_path).child(answers_path).once();

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
      Stream<Event> stream = dbRef.child(matches_path).onChildAdded;

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
      print('id list: $result');
      return result.contains(input);
    }
  }