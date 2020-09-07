import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Server {

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

}