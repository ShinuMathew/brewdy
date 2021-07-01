import 'package:flutter/material.dart';
import 'package:chaiwala420/shared/constants.dart';

class SettingsForm extends StatefulWidget {

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3' '4'];

  // Form values
  String _currentName;
  String _currentSugars;
  String _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
              'Update your chai settings',
              style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
