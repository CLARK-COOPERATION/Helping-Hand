import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//for using lottie animations we are using lottie package
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //after four seconds check if the user is a new user or old
  //if new user then navigate to onBoarding
  //else navigate to home

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushNamed(context, '/onBoarding');
      } else {
        Navigator.pushNamed(context, '/outline');
      }
    });
  }

  //run the splash screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/heart.json'),
      ),
    );
  }
}
