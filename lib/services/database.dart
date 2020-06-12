import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzstore/screens/home/itemModal.dart';

class DatabaseService {

  String uid;

  DatabaseService({uid});

  //collection reference
  final CollectionReference users = Firestore.instance.collection("users");

//Future updateUserCollection(String name, String uid) async{
//
//  return await users.document(name).setData({"name": name, "uid": uid});
//}

  Future updateUserCollection(String name, String prodName, String description,
      double price) async {
    return await users.document(name).setData({
      "name": name,
      "prodName": prodName,
      "description": description,
      "price": price
    });
  }

  List<ItemModel> _itemListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ItemModel(
          name: doc.data["name" ?? ""],
          prodName: doc.data["prodName" ?? ""],
          description: doc.data["description"],
          price: doc.data["price"]

      );
    }).toList();
  }

  Stream<List<ItemModel>> get items {
    return users.snapshots().map(_itemListfromSnapshot);
  }

// items list from snapshot


}