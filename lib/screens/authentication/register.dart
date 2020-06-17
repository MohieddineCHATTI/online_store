import 'package:flutter/material.dart';
import 'package:dzstore/services/auth.dart';
import 'package:dzstore/screens/loading.dart';
import 'package:dzstore/services/database.dart';


class Register extends StatefulWidget {

  final Function toggleAuthenticateScreen;

  Register({this.toggleAuthenticateScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final DatabaseService databaseService = DatabaseService();
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  String name;
  String error = " ";
  bool loading = false;
  String uid = "uid test";

  @override
  Widget build(BuildContext context) {
    return loading == true ? Loading() : MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign up"),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person,),
              label: Text("Sign in"),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Your username please...",
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        validator: (val) => val.length <4 ? "username must be at least 4 characters long" : null,
                      ),
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
                        validator: (val) => val.length < 8 ? "please enter at least eight characters long password ": null,
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
                            if (result == null){
                              setState(() {
                                error = "Either email or password is incorrect, try again please";
                              });
                            }else{
                              setState(() {
                                uid = result.uid;
                              });
                            print("successfully signed up");
                            databaseService.updateUsersCollection(name, uid);
                            print(uid);
                            return result;
                          }}

                        },
                        child: Text("Sign up"),
                      ),
                      Text(error),
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

