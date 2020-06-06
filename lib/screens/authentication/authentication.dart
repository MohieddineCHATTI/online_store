import 'package:flutter/material.dart';
import 'package:dzstore/screens/authentication/signIn.dart';
import 'package:dzstore/screens/authentication/register.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleAuthenticateScreen() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleAuthenticateScreen: toggleAuthenticateScreen);
    } else {
      return Register(toggleAuthenticateScreen: toggleAuthenticateScreen);
    }
  }
}