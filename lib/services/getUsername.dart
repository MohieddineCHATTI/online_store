import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class GetUser extends StatefulWidget {
  @override
  _GetUserState createState() => _GetUserState();
}

class _GetUserState extends State<GetUser> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return new StreamBuilder(
        stream: Firestore.instance.collection('users').document(
            user.uid.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new Text(userDocument["name"]);
        }
    );
  }
}
