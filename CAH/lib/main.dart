import 'package:CAH/allAnswers.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child:Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Container(
                  height: MediaQuery.of(context).size.height*.8,
                  width: MediaQuery.of(context).size.width,
                  child:Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.025,
                        ),
                        _ButtonHome(
                          icona: Icons.person,
                          nome: 'Join',
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllAnswers()));
                          },
                        ),
                        _ButtonHome(
                          icona: Icons.add,
                          nome: 'new match',
                          onPressed: (){

                          },
                        ),
                        _ButtonHome(
                          icona: Icons.format_align_center,
                          nome: 'rules',
                          onPressed: (){

                          },
                        ),
                      ],
                    )
                  ),
                )
              )
            )
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.1),
                child:Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0
                    ),
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0)
                    )
                  ),
                  height: MediaQuery.of(context).size.height*.22,
                  width: MediaQuery.of(context).size.width*.6,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 5,
                      top: 5 
                    ),
                    child: Text(
                      'Cards Against Humanity',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    )
                  )
                ),
              )
            )
          )
        ],
      ),
    );
  }
}

class _ButtonHome extends StatelessWidget {

  final Function onPressed;
  final String nome;
  final IconData icona;

  _ButtonHome({@required this.onPressed, @required this.nome, @required this.icona});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.white,
            width: 0.0
          ),
          color: Colors.black
        ),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 6.0,
            right: 4.0,
            top: 0.0
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(6),
            ),
            border: Border.all(
              color: Colors.white
            )
          ),
          child: ListTile(
            dense: true,
            leading: Icon(
              icona,
              color: Colors.black,
            ),
            trailing: Icon(
              icona,
              color: Colors.transparent,
            ),
            title: Text(
              nome.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () => onPressed(),
          ),  
          
        )
      )
    );
  }
}
