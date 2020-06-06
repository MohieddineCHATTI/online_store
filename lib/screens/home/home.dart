import 'package:flutter/material.dart';
import 'package:dzstore/services/auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text("home page .."),
              RaisedButton(
                onPressed: () {
                  _auth.logOut();
                },
                child: Text("logout "),
              )
            ],
          ),
        ),
      ),
    );
  }
}
