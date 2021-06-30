import 'package:chaiwala420/services/auth.dart';
import 'package:chaiwala420/shared/constants.dart';
import 'package:chaiwala420/shared/loading.dart';
import 'package:chaiwala420/widgets/common/hamburger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //  Text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      drawer: Hamburger().buildPublicHamburger(),
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () {
                widget.toggleView();
              },
              label: Text('Register'))
        ],
        title: Text(
          "CHAIWALA 420",
          style: TextStyle(
            fontSize: 20,
            // letterSpacing: 2
          ),
        ),
        // centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text("SIGN IN",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.brown[600],
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    // textAlign: TextAlign.center,
                    validator: (val) =>
                        val.isEmpty ? "Please enter an emailId" : null,
                    maxLength: 30,
                    style: TextStyle(fontSize: 20, height: 1),
                    decoration: textInputDecoration.copyWith(hintText: "Email Id"),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? "Please enter a password" : null,
                    // textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, height: 1),
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      // color: Colors.brown[400],
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.brown[400],
                          primary: Colors.brown[400],
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                              "Sign In failed. Please enter a valid credential or register as a new user";
                              loading = false;
                            });
                          } else {
                            User user = await FirebaseAuth.instance.currentUser;
                            print(user.displayName);
                          }
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
            ),
          )
          // RaisedButton(
          //   child: Text("Sign in"),
          //   onPressed: () async {
          //     dynamic result = await _auth.signInAnonymous();
          //     if(result == null)
          //       print("Error signing in");
          //     else {
          //       print("Signed in");
          //       print(result.uid);
          //     }
          //   },
          // ),
          ),
    );
  }
}
