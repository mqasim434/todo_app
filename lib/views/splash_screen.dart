import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/views/home.dart';
import 'package:todo_app/views/signin_screen.dart';
import 'package:todo_app/views/home_screen.dart';
import 'package:todo_app/repository/shared_preferences_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      _checkSession();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _checkSession() async {
    bool hasToken = await SharedPreferencesServices.hasToken();
    if (hasToken) {
      SharedPreferencesServices.getUserLocally();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      // User is not logged in, navigate to SignInScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TypewriterAnimation(
          text: 'SplashScreen',
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class TypewriterAnimation extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;

  TypewriterAnimation({
    required this.text,
    this.textStyle = const TextStyle(fontSize: 24),
    this.duration = const Duration(milliseconds: 150),
  });

  @override
  _TypewriterAnimationState createState() => _TypewriterAnimationState();
}

class _TypewriterAnimationState extends State<TypewriterAnimation> {
  late String _animatedText;
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _animatedText = '';
    _startTypingAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTypingAnimation() {
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _animatedText += widget.text[_currentIndex];
          _currentIndex++;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _animatedText,
      style: widget.textStyle,
    );
  }
}
