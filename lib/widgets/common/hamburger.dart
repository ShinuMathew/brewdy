import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hamburger {
  Widget buildPublicHamburger() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown[400],
              ),
              child: Image.asset("assets/chaiwala_logo.png")),
          ListTile()
        ],
      ),
    );
  }
}
