import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:security_camera/Views/HomeScreen.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});

  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (mounted) { 
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            duration: Duration(milliseconds: 500),
            child: null, 
            childCurrent: widget, 
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/loading.gif"),
          Text("Loading")
        ],
      ),
    );
  }
}