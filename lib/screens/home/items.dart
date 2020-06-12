import 'package:dzstore/screens/home/itemModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzstore/services/database.dart';
import 'itemModal.dart';
import 'itemTile.dart';


class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<ItemModel>>(context) ?? [];
    items.forEach((item) {
      print (item.name);
    });

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemTile (item : items[index]);
        });
  }
}
