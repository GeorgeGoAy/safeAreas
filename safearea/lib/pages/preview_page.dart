import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:safearea/animation/delayed_animation.dart';
import 'package:safearea/utils/navigator.dart' as navigator;

class PreviewPage extends StatefulWidget {
  PreviewPage({Key key}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.black;
    _scale = 1 - _controller.value;
    return FadeIn(
        //duration: Duration(milliseconds: 500),
          child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(top:40),
                          child: Center(
                child: Column(
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 110,
                      duration: Duration(seconds: 2),
                      glowColor: Colors.blueGrey,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 2),
                      startDelay: Duration(seconds: 1),
                      child: Material(
                            elevation: 8.0,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[50],
                              child: Image.asset("assets/logo.png", height: 110),
                              radius: 70.0,
                            )),
                    ),
                    DelayedAnimation(
                      child: Text(
                          "Hi There",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: color),
                      ),
                      delay: delayedAmount + 1000,
                    ),
                    DelayedAnimation(
                      child: Text(
                          "I'm Safe Areas",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: color),
                      ),
                      delay: delayedAmount + 2000,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    DelayedAnimation(
                      child: Text(
                          "Your sanitation tool",
                          style: TextStyle(fontSize: 20.0, color: color),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    DelayedAnimation(
                      child: Text(
                          "Journaling  companion",
                          style: TextStyle(fontSize: 20.0, color: color),
                      ),
                      delay: delayedAmount + 3000,
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    DelayedAnimation(
                    child: GestureDetector(
                      onTapDown: _onTapDown,
                      onTapUp: _onTapUp,
                      onTap: (){
                        navigator.directLogin(context);
                      },
                      child: Transform.scale(
                          scale: _scale,
                          child: _animatedButtonUI,
                      ),
                    ),
                    delay: delayedAmount + 4000,
                  )
                  ],
                ),
              ),
                        ),
            )
            ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color(0xFFA64884),
        ),
        child: Center(
          child: Text(
            'Get Started',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}