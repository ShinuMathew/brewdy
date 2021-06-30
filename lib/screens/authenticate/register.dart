import 'package:chaiwala420/services/auth.dart';
import 'package:chaiwala420/shared/constants.dart';
import 'package:chaiwala420/shared/loading.dart';
import 'package:chaiwala420/widgets/common/hamburger.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //  Text field state
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.brown[100],
            drawer: Hamburger().buildPublicHamburger(),
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text(
                "CHAIWALA 420",
                style: TextStyle(
                  fontSize: 20,
                  // letterSpacing: 2
                ),
              ),
              actions: [
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      widget.toggleView();
                    },
                    label: Text('Sign In'))
              ],
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
                        Text("REGISTER USER",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.brown[600],
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1)),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter a First Name" : null,
                          // textAlign: TextAlign.center,
                          maxLength: 20,
                          style: TextStyle(fontSize: 20, height: 1),
                          decoration: textInputDecoration.copyWith(
                              hintText: "First Name"),
                          onChanged: (val) {
                            setState(() {
                              firstName = val;
                            });
                          },
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter a Last Name" : null,
                          // textAlign: TextAlign.center,
                          maxLength: 20,
                          style: TextStyle(fontSize: 20, height: 1),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Last Name"),
                          onChanged: (val) {
                            setState(() {
                              lastName = val;
                            });
                          },
                        ),
                        TextFormField(
                          // textAlign: TextAlign.center,
                          validator: (val) =>
                              val.isEmpty ? "Enter an email" : null,
                          maxLength: 30,
                          style: TextStyle(fontSize: 20, height: 1),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Email Id"),
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
                          // textAlign: TextAlign.center,
                          validator: (val) => val.length < 6
                              ? "Password should by greater than 6 characters"
                              : null,
                          style: TextStyle(fontSize: 20, height: 1),
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          // textAlign: TextAlign.center,
                          validator: (val) =>
                              val != password ? "Password mismatched" : null,
                          style: TextStyle(fontSize: 20, height: 1),
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: "Confirm Password"),
                          onChanged: (val) {
                            setState(() => confirmPassword = val);
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
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password, firstName, lastName);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        "Registration Failed!\nPlease make sure you are entering a valid email and password";
                                  });
                                }
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        )
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
