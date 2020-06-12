import 'package:flutter/material.dart';
import 'itemModal.dart';


class ItemTile extends StatelessWidget {
  final ItemModel item;
  ItemTile({this.item});

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber,

          ),
          title: Text(item.name),
        ),
      ),
    );
  }
}
