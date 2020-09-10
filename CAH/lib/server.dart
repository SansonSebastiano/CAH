import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//--------------------------------------------------------
//                     Database Path
//--------------------------------------------------------
  //cards
  const String cards_Path = 'cards';
  const String answers_Path = 'answers';
  const String questions_Path = 'questions'; 

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

  Future<List<String>> getAllAnswers() async{
    DataSnapshot dataSnapshot = await databaseReference.child(cards_Path).child(answers_Path).once();

    var dataSnapshotList = dataSnapshot.value;
    var tmp = List<String>();

    for(var answer in dataSnapshotList){
      tmp.add(answer.toString());
    }
    return tmp;
  }

  Future<void> initAnswers() async {
    
  }
}







/*class Server {

  Server(){
    Firebase.initializeApp();
  }

  DatabaseReference database = FirebaseDatabase.instance.reference();

  Future<List<String>> getAllAnswers() async {
    DataSnapshot x = await database.child('cards').child('answers').once();
    //for(var y in x.)
    var y = x.value;
    var tmp = List<String>();
    for(var z in y){
      tmp.add(z.toString());
    }
    return tmp;
  }

  Future<void> initAnswers() async {
    
  }

}*/