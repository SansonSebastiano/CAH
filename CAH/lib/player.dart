class Player{
  int index;
  String name;
  List<String> answersList = List<String>();
  int score;

  /*Player.fromMap(Map<String, dynamic> map){
    this.name = map['name'].toString();
    this.score = int.parse(map['score'].toString());
    this.answersList = map['answerPerPlayer'] as List<String>;
    //this.index = int.parse(map[index])
  }*/
}



/*
  Piatto.fromMap(Map<String,dynamic> map){
    this.nome = map['Nome'];
    this.prezzo = (map['Prezzo'] as num).toDouble();
    options = Opzioni();
    for(Map<String, dynamic> opzione in map["Options"]){
      Opzione opz = Opzione(opzione['Nome'], (opzione['Prezzo'] as num).toDouble());
      opz.selected = true;
      options.aggiunte.add(opz);
    }
  }

  Map<String, dynamic> toMap(){
    List<Map<String, dynamic>> opzioni = List<Map<String, dynamic>>();
    for(Opzione opzione in options.toListOpzione()){
      if(opzione.selected){
        opzioni.add(opzione.toMap());
      }
    }
    return {
      "Nome": nome,
      "Prezzo": prezzo,
      "Options" : opzioni
    };
  }
*/