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
  Future updateUsersCollection(String name, String uid) async {
    return await users.document(uid).setData({
      "name": name,
      "uid": uid,
    });
  }
////to be changed to update items collection for each category
  Future updateUserCollection(String name, String prodName, String description,
        double price, String url1, String url2, String url3) async {
      return await users.document(name).setData({
        "name": name,
        "prodName": prodName,
        "description": description,
        "price": price,
        "url1" : url1,
        "url2": url2,
        "url3": url3
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