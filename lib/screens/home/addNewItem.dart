import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dzstore/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  String _prodName;
  double  _price;
  String _description;
  String url1;
  String url2;
  String url3;


  File _image1;
  File _image2;
  File _image3;
  Future getImg1() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image1 = image;
      print(_image1.path);
    });
  }
  Future getImg2() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image2 = image;
    });
  }
  Future getImg3() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image3 = image;
    });
  }

  Future uploader (String image1 , File imageFile1,String image2 , File imageFile2,String image3 , File imageFile3,  ) async {
//
    StorageReference firebaseStorageRef1 = FirebaseStorage.instance.ref().child(image1);
    StorageUploadTask uploadTask1 =  firebaseStorageRef1.putFile(imageFile1);
    dynamic _url1 = await firebaseStorageRef1.getDownloadURL();
      setState(() {
       url1 = _url1;
       print(url1);
      });
    StorageReference firebaseStorageRef2 = FirebaseStorage.instance.ref().child(image2);
    StorageUploadTask uploadTask2 =  firebaseStorageRef1.putFile(imageFile2);
    dynamic _url2 = await firebaseStorageRef2.getDownloadURL();
    setState(() {
      url2 = _url2;
      print(url2);
    });
    StorageReference firebaseStorageRef3 = FirebaseStorage.instance.ref().child(image3);
    StorageUploadTask uploadTask3 =  firebaseStorageRef1.putFile(imageFile3);
    dynamic _url3 = await firebaseStorageRef3.getDownloadURL();
    setState(() {
      url3 = _url3;
      print(url3);
    });
    StorageTaskSnapshot storageTaskSnapshot1 = await uploadTask1.onComplete;
    StorageTaskSnapshot storageTaskSnapshot2 = await uploadTask2.onComplete;
    StorageTaskSnapshot storageTaskSnapshot3 = await uploadTask3.onComplete;
  }
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
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//
                  _image1 == null ? CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.pink,
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: getImg1
                      )): Container(
                      width: MediaQuery.of(context).size.width/4,
                    height: MediaQuery.of(context).size.height/4,
                    child: Image.file(_image1,)),
                  _image2 == null ? CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.pink,
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: getImg2
                      )): Container(
                      width: MediaQuery.of(context).size.width/4,
                      height: MediaQuery.of(context).size.height/4,
                      child: Image.file(_image2,)),
                  _image3 == null ? CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.pink,
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: getImg3
                      )): Container(
                      width: MediaQuery.of(context).size.width/4,
                      height: MediaQuery.of(context).size.height/4,
                      child: Image.file(_image3,))
                ],
              ),

              FlatButton.icon(onPressed: () async {
//                print(_name +_prodName + _description);
//                print(_price);
                await uploader("image1", _image1, "image2", _image2, "image3", _image3);

                print(url1);
                print(url2);
                print(url3);
              await DatabaseService().updateUserCollection(_name, _prodName ?? "no name", _description ?? "no description here", _price ?? 0 , url1 ?? "no url", url2 ?? "no url", url3 ?? "no url");
              }, icon: Icon(Icons.add), label: Text(""),)


            ],
          ),
        ),
      );
  }
}
