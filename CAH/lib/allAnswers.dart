import 'package:CAH/server.dart';
import 'package:flutter/material.dart';

class AllAnswers extends StatefulWidget {
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
}