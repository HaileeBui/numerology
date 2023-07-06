import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numerology/widget/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double backgroundHeight = MediaQuery.of(context).size.height;

    return Container(
      height: backgroundHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.purple],
        ),
      ),
      child: Image.asset('assets/icon.png'),
    );
  }
}
