import 'package:flutter/material.dart';
import 'package:dzstore/services/auth.dart';
import 'package:dzstore/screens/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleAuthenticateScreen;

  SignIn({this.toggleAuthenticateScreen});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading == true? Loading() : MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Sign in"),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person,),
                label: Text("Register"),
                onPressed: () {
                  widget.toggleAuthenticateScreen();
                },
              )
            ],
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async{
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInAnon();
                    print (result.uid);
                  },
                  child: Text("sign in anonymously"),
                ),
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
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              print("successfully signed In");
                              print(result.uid);
                              return result;
                            }

                          },
                          child: Text("Sign in"),
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