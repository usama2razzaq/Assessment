import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:products/User%20Interface/Authentication/forgot_password.dart';

import '../../reuseable_widgets/textStyle.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  @override
  final b1 = TextEditingController();
  final b2 = TextEditingController();
  final b3 = TextEditingController();
  final b4 = TextEditingController();

  late FocusNode f1, f2, f3, f4;
  final _formKey = GlobalKey<FormState>();
  void initState() {
    startTimer();

    f1 = FocusNode();
    f2 = FocusNode();
    f3 = FocusNode();
    f4 = FocusNode();

    f1.requestFocus();

    super.initState();
  }

  Timer? _timer;
  int _start = 120;
  bool timerCheck = false;
  void main() {
    final duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      // Stop the timer when it matches a condition
      if (timer.tick >= 10) {
        timer.cancel();
      }

      print('Tick: ${timer.tick}');
    });
  }

  void startTimer() {
    _timer = new Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            setState(() {
              timerCheck = false;
              timer.cancel();
            });

            print("finish timer");
          } else {
            print("start timer");

            setState(() {
              timerCheck = true;
              _start = _start - 1;
            });
          }
          print('Tick: ${timer.tick}');
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    final myWidth = MediaQuery.of(context).size.width;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          'Mobiler Verification',
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // height: double.maxFinite,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Please enter the OTP send",
                                  ),
                                  seperator(thickenss: 5),
                                  Text(
                                    "on your registered Phone Number",
                                  ),
                                  seperator(thickenss: 50),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.center,
                                          controller: b1,
                                          maxLength: 1,
                                          focusNode: f1,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            counterStyle:
                                                TextStyle(fontSize: 0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            // hintStyle:
                                            //     myTextStyle(18, text_grey, m),
                                            hintText: "",
                                            fillColor: theme_color,
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "adadad";
                                            }
                                            return null;
                                          },
                                          onEditingComplete: () {
                                            focus.nextFocus();
                                          },
                                          onChanged: (a) {
                                            if (a.isNotEmpty) f2.nextFocus();
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: myWidth * 0.2,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.center,
                                          controller: b2,
                                          focusNode: f2,
                                          maxLength: 1,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            counterStyle:
                                                TextStyle(fontSize: 0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            hintText: "",
                                            fillColor: Colors.grey,
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "";
                                            }
                                            return null;
                                          },
                                          onEditingComplete: () {
                                            focus.nextFocus();
                                          },
                                          onChanged: (a) {
                                            if (a.isNotEmpty) f3.nextFocus();
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: myWidth * 0.2,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.center,
                                          controller: b3,
                                          focusNode: f3,
                                          maxLength: 1,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            counterStyle:
                                                TextStyle(fontSize: 0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            // hintStyle:
                                            //     myTextStyle(18, text_grey, m),
                                            hintText: "",
                                            fillColor: theme_color,
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "asDD";
                                            }
                                            return null;
                                          },
                                          onEditingComplete: () {
                                            focus.nextFocus();
                                          },
                                          onChanged: (a) {
                                            if (a.isNotEmpty) f4.nextFocus();
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: myWidth * 0.2,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.center,
                                          controller: b4,
                                          focusNode: f4,
                                          maxLength: 1,
                                          decoration: InputDecoration(
                                            counterText: '',
                                            counterStyle:
                                                TextStyle(fontSize: 0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            hintText: "",
                                            fillColor: Colors.grey,
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "";
                                            }
                                            return null;
                                          },
                                          onEditingComplete: () {
                                            focus.nextFocus();
                                          },
                                          onChanged: (a) {
                                            if (a.isNotEmpty) f4.nextFocus();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              seperator(thickenss: 80),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print(timerCheck);
                            if (timerCheck == false) {
                              startTimer();

                              timerCheck = true;
                              _start = 120;
                            } else {}
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: timerCheck == false
                                  ? theme_color
                                  : theme_color.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Center(
                              child: Text(
                                !timerCheck
                                    ? 'Resend OTP'
                                    : 'Resend OTP | $_start',
                              ),
                            ),
                          ),
                        ),
                      ),
                      seperator(thickenss: 80),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
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
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Text(
                              'Confirm'.toUpperCase(),
                              style: getTextTyle("sb", 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget seperator({double thickenss = 0}) {
    return SizedBox(
      height: thickenss,
    );
  }
}
