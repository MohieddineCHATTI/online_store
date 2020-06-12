import 'package:flutter/material.dart';
import 'screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:dzstore/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(value: AuthService().user,child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper()));
  }
}
