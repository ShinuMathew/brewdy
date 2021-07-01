import 'package:chaiwala420/models/chai_model.dart';
import 'package:chaiwala420/screens/home/settings_form.dart';
import 'package:chaiwala420/services/auth.dart';
import 'package:chaiwala420/services/database.dart';
import 'package:chaiwala420/widgets/common/hamburger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chai_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DatabaseService _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          },
        isScrollControlled: true,
      );
    }

    return StreamProvider<List<ChaiModel>>.value(
      value: DatabaseService().chai,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          drawer: Hamburger().buildPublicHamburger(),
          appBar: AppBar(
            title: Text(
              "CHAIWALA 420",
              style: TextStyle(
                fontSize: 20,
                // letterSpacing: 2
              ),
            ),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  }),
              FlatButton.icon(
                  icon : Icon(Icons.settings),
                  onPressed: () => _showSettingsPanel(),
                  label: Text('Settings'),
                  ),

            ],
          ),
          body:
          // Column(
          //   children: [
          //     Text(
          //       "WELCOME\n${FirebaseAuth.instance.currentUser.displayName}"
          //           .toUpperCase(),
          //       style: TextStyle(
          //           color: Colors.brown[400], fontSize: 30, letterSpacing: 1.5),
          //       textAlign: TextAlign.center,
          //     ),
          //
          //   ],
          // )
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover
                )
              ),
              child: ChaiList()
          ),
      ),
    );
  }
}
