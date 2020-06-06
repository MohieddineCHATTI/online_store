import 'package:flutter/material.dart';
import 'package:dzstore/screens/home/home.dart';
//import 'package:dzstore/screens/authentication/register.dart';
//import 'package:dzstore/screens/authentication/signIn.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dzstore/screens/authentication/authentication.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print(user);
    if (user == null){
      return Authenticate();
    }else{
      return HomePage();
    }
  }
}