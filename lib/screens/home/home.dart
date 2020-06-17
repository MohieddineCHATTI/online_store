import 'package:dzstore/screens/home/itemModal.dart';
import 'package:flutter/material.dart';
import 'package:dzstore/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dzstore/services/database.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addNewItem.dart';
import 'package:dzstore/screens/home/items.dart';
import 'package:dzstore/services/getUsername.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
 String username;
 String  uid;



  @override
  Widget build(BuildContext context) {
    void _showAddNewPanel (){
      //isScroll Controlled for bottom sheet full height ,, must be another way
      showModalBottomSheet(context: context,isScrollControlled: true,  builder: (context)  {
        return Container(
          margin: EdgeInsets.all(30),
          child: AddNewItem()
        );
      });
    }
    void _logout (){
      //isScroll Controlled for bottom sheet full height ,, must be another way
      showModalBottomSheet(context: context,  builder: (context)  {
        return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  FlatButton(onPressed: (){
                    _auth.logOut();
                  Navigator.of(context).pop();},child: Text("logout"),color: Colors.pink,),
                  FlatButton(onPressed: (){Navigator.of(context).pop();},child: Text("Cancel"),color: Colors.yellow,)
                ],
              ),
            )
        );
      });
    }
    return StreamProvider<List<ItemModel>>.value(
      value: DatabaseService().items,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: <Widget>[
              FlatButton.icon(onPressed: () =>_showAddNewPanel(), icon: Icon(Icons.add), label: Text("")),
              FlatButton.icon(onPressed: () {_logout();} , icon: Icon(Icons.account_circle), label: GetUser(),),

            ],
          ),
          body: Items(),
          backgroundColor: Colors.green,
          ),

      ),
    );
  }
}
