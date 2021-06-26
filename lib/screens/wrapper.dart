import 'package:chaiwala420/models/user_model.dart';
import 'package:chaiwala420/screens/authenticate/authenticate.dart';
import 'package:chaiwala420/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    //  Return either Authenticate or Home widget
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
