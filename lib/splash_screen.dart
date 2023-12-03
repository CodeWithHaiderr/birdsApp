import 'dart:async';
import 'package:birdz_app/consts/firebase_consts.dart';
import 'package:birdz_app/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  splashToLogin() {
    Timer(const Duration(seconds: 4), (){

      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (context) =>  const LoginScreen(),
                  ));
        }
        else{
          Navigator.pushReplacement(context,
              MaterialPageRoute(
                builder: (context) =>  const DashBoard( ),
              ));
        }
      });
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(
      //       builder: (context) =>  const LoginScreen(),
      //     ));
    });
  }
  @override
  void initState() {
    super.initState();
    splashToLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/splashOne.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 550,left: 100),
              child: Text('Birds.Pk',style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),),
              
            ),

          ],
        )

    );
  }
}
