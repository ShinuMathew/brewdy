import 'package:flutter/material.dart';
import 'package:chaiwala420/models/chai_model.dart';

class ChaiTile extends StatelessWidget {

  final ChaiModel chai;

  ChaiTile({this.chai});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child : Card(
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.brown[chai.strength],
              backgroundImage: AssetImage('assets/coffee_icon.png'),
            ),
            title: Text(chai.name),
            subtitle: Text('Takes ${chai.sugars} sugar(s)'),
          ),
    )
    );
  }
}
