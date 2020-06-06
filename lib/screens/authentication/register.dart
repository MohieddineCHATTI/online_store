import 'package:flutter/material.dart';
import 'package:dzstore/services/auth.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Your Email ...",
                        ),
                        onChanged: (val) {
                         setState(() {
                           email = val;
                         });
                        },
                        validator: (val) => val.isEmpty ? "Enter Your Email Please" : null,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Set Your Password ...",
                        ),
                        validator: (val) => val.length < 8 ? "please enter at least six characters long password ": null,
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });

                        },
                      ),
                      SizedBox(height: 20,),
                      RaisedButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()){
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            print("successfully signed up");
                            print(result.uid);
                            return result;
                          }

                        },
                        child: Text("Sign up"),
                      )
                    ],

                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

