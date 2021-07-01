import 'package:chaiwala420/models/chai_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chai_tile.dart';


class ChaiList extends StatefulWidget {

  @override
  _ChaiListState createState() => _ChaiListState();
}

class _ChaiListState extends State<ChaiList> {


  @override
  Widget build(BuildContext context) {

    final chai = Provider.of<List<ChaiModel>>(context);

    return ListView.builder(
        itemCount: chai.length,
        itemBuilder: (context, index) {
          return ChaiTile(chai: chai[index]);
        });
  }
}
