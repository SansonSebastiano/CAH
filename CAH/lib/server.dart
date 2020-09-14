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

class Server {
  Server(){
    Firebase.initializeApp();
  }

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  Future<bool> isConnected() async{
    DataSnapshot dataSnapshot = await databaseReference.child('.info/connected').once();
    bool amIOnline = dataSnapshot.value;
    if (amIOnline == true) {
        return amIOnline;
    } else {
      return amIOnline;
    }
  }

  Future<List<String>> loadAnswers() async{
    DataSnapshot dataSnapshot = await databaseReference.child(cards_path).child(answers_path).once();

    var dataSnapshotList = dataSnapshot.value;
    var list = List<String>();

    for(var answer in dataSnapshotList){
      list.add(answer.toString());
    }
    return list;
  }

  Future<void> initAnswers() async {
    
  }

  Future<List<String>> loadMatchID() async{
    Completer c = new Completer<List<String>>();
    List<String> list = new List<String>();
    Stream<Event> stream = databaseReference.child(matches_path).onChildAdded;
    
    stream.listen((event) {
      onMatchIdAdded(event, list).then((List<String> idList) {
        return new Future.delayed(new Duration(seconds: 0), ()=> idList);
      }).then((_) {
        if (!c.isCompleted){
          c.complete(list);
        }
      });
    });

    return c.future;
  }

  Future <List<String>> onMatchIdAdded(Event event, List<String> idList) async{
    String x = event.snapshot.key;
    idList.add(x);
    return idList;
  }
}
