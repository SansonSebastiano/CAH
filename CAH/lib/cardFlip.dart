import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFlip extends StatelessWidget {
  // Parameters required
  final String text;      //text displayed in front side of card
  final Function onTap;   //function launched on pressed

  CardFlip({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Cards(text: text, onTap: onTap);
  }
}

class Cards extends StatefulWidget {
  Cards({Key key, @required this.text, @required this.onTap}) : super(key: key);
  // Parameters required
  final String text;      //text displayed in front side of card
  final Function onTap;   //function launched on pressed

  @override
  _CardState createState() => _CardState(text: text, onTap: onTap);
}

class _CardState extends State<Cards> {
  // Parameters required
  final String text;      //text displayed in front side of card
  final Function onTap;   //function launched on pressed

  _CardState({@required this.text, @required this.onTap});

  bool _showFrontSide;    // true for display front side of a card
  bool _flipXAxis;        // for determine the axis rotation, true for Y axis rotation

  //init value
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

  // for swicth card side
  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  // build animation
  Widget _buildFlipAnimation(String text, Function onTap) {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        // Animation duration
        duration: Duration(seconds: 1),
        // call flip transition
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
        child: _showFrontSide ? _buildRear() : _buildFront(text, onTap),
        // The animation curve to use when transitioning in a new [child].
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );

  }

  //build flip transition
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

  // Front side card layout
  Widget _buildFront(String text, Function onTap) {
    return __buildLayout(
      key: ValueKey(true), 
      text: text, 
      fontSize: 20.0, 
      onTap: onTap
    );
  }

  // Rear side card layout
  Widget _buildRear() {
    return __buildLayout(
      key: ValueKey(false),
      text: 'Cards \nAgainst \nHumanity',
      fontSize: 40.0,
    );
  }

  // general custom card layout
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

// Custom Card layout
class CustomCard extends StatelessWidget{
  // Parameters required
  final String text;      //text displayed in front side of card
  final Function onTap;   //function launched on pressed
  final double fontSize;  //size of text

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