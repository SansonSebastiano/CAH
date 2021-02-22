import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFlip extends StatelessWidget {
  final String text;
  final Function onTap;

  CardFlip({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Cards(text: text, onTap: onTap);
  }
}

class Cards extends StatefulWidget {
  Cards({Key key, @required this.text, @required this.onTap}) : super(key: key);

  final String text;
  final Function onTap;

  @override
  _CardState createState() => _CardState(text: text, onTap: onTap);
}

class _CardState extends State<Cards> {
  final String text;
  final Function onTap;

  _CardState({@required this.text, @required this.onTap});

  bool _showFrontSide;
  bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    return _buildFlipAnimation(text, onTap);
  }

  //FOR CHANGE AXIS ROTATION
  /*void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }*/

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation(String text, Function onTap) {

    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
        child: _showFrontSide ? _buildRear() : _buildFront(text, onTap),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );

  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);

    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront(String text, Function onTap) {
    return __buildLayout(
      key: ValueKey(true), 
      text: text, 
      fontSize: 20.0, 
      onTap: onTap
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: ValueKey(false),
      text: 'Cards \nAgainst \nHumanity',
      fontSize: 40.0,
    );
  }

  Widget __buildLayout(
      {Key key,
      @required String text,
      @required double fontSize,
      Function onTap}) {
    return CustomCard(
      text: text,
      fontSize: fontSize,
      onTap: onTap,
    );
  }
}

class CustomCard extends StatelessWidget{
  final String text;
  final Function onTap;
  final double fontSize;

  CustomCard({@required this.text, @required this.onTap, @required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * .55,
        width: MediaQuery.of(context).size.width * .9,
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.black54,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * .04,
                left: MediaQuery.of(context).size.height * .02,
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*Center(
      key: key,
      child: Container(
        height: MediaQuery.of(context).size.height * .55,
        width: MediaQuery.of(context).size.width * .9,
        child: Card(
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.black54,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * .04,
                left: MediaQuery.of(context).size.height * .02,
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ); */