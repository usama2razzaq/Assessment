import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/User%20Interface/Authentication/mobile_verification.dart';

import 'package:products/User%20Interface/Authentication/signup.dart';
import 'package:products/Utilites/FirebaseHelper.dart';
import 'package:products/main.dart';
import 'package:products/reuseable_widgets/textStyle.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  final formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  void initState() {
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  _createAccount(
    BuildContext context,
    String email,
    String passs,
  ) async {
    final status = await FirebaseAuthHelper().login(email: email, pass: passs);
    status.name;
    if (status == AuthResultStatus.successful) {
      print(status.name);
      print(auth.currentUser!.uid);
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => MyTabs()));
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      showAlertDialog(context, "Error", errorMsg);
      print(errorMsg);
    }
  }

  void inputData() {
    ;
    // here you write the codes to input the data into firestore
  }

  showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme_color,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [theme_color, theme_color],
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: const Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
                    const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32, right: 32),
                        child: AutoSizeText(
                          'Login',
                          style: getTextTyle("sb", 19, color: Colors.white),
                          maxLines: 3,
                          maxFontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 62),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        // height: 45,
                        padding: const EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: const BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: theme_color,
                            ),
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            return "Enter Email";
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 45,
                        margin: const EdgeInsets.only(top: 32),
                        padding: const EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.vpn_key,
                              color: theme_color,
                            ),
                            hintText: 'Password',
                          ),
                          validator: (value) {
                            return "Enter Password";
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 32),
                          child: GestureDetector(
                            child: Text(
                              'Forgot Password ?',
                              style: getTextTyle("sb", 15,
                                  color: theme_color_black.withOpacity(0.5)),
                            ),
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MobileVerification()));
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          if (email.text.isEmpty) {
                            final snackBar = const SnackBar(
                              content: Text('Email cannot be empty'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (password.text.isEmpty) {
                            final snackBar = const SnackBar(
                              content: Text('Password cannot be empty'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => MyTabs()));
                            //  _createAccount(context, email.text, password.text);
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  theme_color,
                                  theme_color,
                                ],
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Text(
                              'Login'.toUpperCase(),
                              style: getTextTyle("sb", 14, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Dnon't have an account ?"),
                    Text(
                      " Sign Up",
                      style: getTextTyle("sb", 15, color: theme_color),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
