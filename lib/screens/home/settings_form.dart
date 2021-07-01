import 'package:chaiwala420/models/user_model.dart';
import 'package:chaiwala420/services/database.dart';
import 'package:chaiwala420/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:chaiwala420/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // Form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Update your chai settings',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: _currentName ?? userData.name,
                      decoration: textInputDecoration.copyWith(
                          fillColor: Colors.brown[50]),
                      validator: (val) =>
                          val.isEmpty ? "Please Enter a name" : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //  dropdown
                    DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                            value: sugar, child: Text("$sugar sugars"));
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //  slider
                    Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        color: Colors.brown[400],
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentStrength ?? userData.strength);
                          };
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
