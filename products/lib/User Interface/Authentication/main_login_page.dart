import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPageMain extends StatefulWidget {
  const LoginPageMain({Key? key}) : super(key: key);

  @override
  _LoginPageMainState createState() => _LoginPageMainState();
}

class _LoginPageMainState extends State<LoginPageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Padding(
          padding: EdgeInsets.all(0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Center(
                  // child: Lottie.asset('assets/lottiefiles/38435-register.json',
                  //     repeat: false),
                  ),
            ),
          ]),
        ),
      ),
    );
  }
}
