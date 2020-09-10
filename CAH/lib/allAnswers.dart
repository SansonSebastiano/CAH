import 'package:CAH/server.dart';
import 'package:flutter/material.dart';

class AllAnswers extends StatefulWidget{
  @override
  _AllAnswersState createState() => _AllAnswersState();
}

class _AllAnswersState extends State<AllAnswers>{

  Server srv = Server();
  List<String> answersList;

  @override
  void initState(){
    getAnswersList();
    super.initState();
  }

  void getAnswersList() async{
    answersList = await srv.getAllAnswers();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    if (answersList == null) {
      return Scaffold(
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
      );     
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        body: ListView.builder(
          itemCount: answersList.length,
          itemBuilder: (context, index){
            return Container(
                height: MediaQuery.of(context).size.height*.4,
                child: Card(
                elevation: 5.0,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.1,
                  right: MediaQuery.of(context).size.width*0.1,
                  top: MediaQuery.of(context).size.height*0.025
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        answersList[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      );
    }
  }
}








































/*class AllAnswers extends StatefulWidget {
  @override
  _AllAnswersState createState() => _AllAnswersState();
}

class _AllAnswersState extends State<AllAnswers> {

  List<String> answers;
  Server svr = Server();

  @override
  void initState() {
    getAn();
    super.initState();
  }

  void getAn() async {
    answers = await svr.getAllAnswers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(answers == null){
      return Scaffold(
        body: Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: CircularProgressIndicator(
              value: null,
            ),
          ),
        ),
      );
    }else{  
      return Scaffold(
        body: ListView.builder(
          itemCount: answers.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(answers[index]),
            );
          },
        ),
      );
    }
  }
}*/