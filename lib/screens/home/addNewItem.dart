import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dzstore/services/database.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  String _prodName;
  double  _price;
  String _description;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    String _name = user.uid ;


    return Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(5),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Name"
                ),
                onChanged: (val) {
                  setState(() {
                    _name = val;
                  });
                },
              ),
              TextFormField(
                initialValue: "no name",
                decoration: InputDecoration(
                    hintText: "Product Name"
                ),
                onChanged: (val) {
                  setState(() {
                    _prodName = val;
                  });
                },
              ),
              TextFormField(
                initialValue: "0" ,
                  keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Price"
                ),
                onChanged: (val) {
                  setState(() {
                    _price = double.parse(val);
                  });
                },
              ),
              TextFormField(
                initialValue: "no desc",
                decoration: InputDecoration(
                    hintText: "Description"
                ),
                onChanged: (val) {
                  setState(() {
                    _description = val;
                  });
                },
              ),

              FlatButton.icon(onPressed: () async {
//                print(_name +_prodName + _description);
//                print(_price);
              print(_name);
              await DatabaseService().updateUserCollection(_name, _prodName ?? "no name", _description ?? "no description here", _price ?? 0 );
              }, icon: Icon(Icons.add), label: Text(""),)

            ],
          ),
        ),
      );
  }
}
