import 'dart:convert';

import 'package:Planalist/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class Signin {
  final String email;
  final String password;

  Signin({
    this.email,
    this.password,
  });
  factory Signin.fromJson(Map<String, dynamic> json) {
    return Signin(
      email: json['email'],
      password: json['password'],
    );
  }
}

class _SignupState extends State<Signup> {
  Widget buttonLogIn() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: TextButton(
        child: Text(
          "Login",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'PoppinsStyle',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w100),
        ),
        onPressed: () {
          Navigator.pop(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 800),
                child: Login(),
                ctx: context),
          );
        },
      ),
    );
  }

  Widget buttonLoginWithGoogle() {
    return Container(
      child: FlatButton.icon(
        // onPressed: () {},
        onPressed: () {
          // Navigator.pushReplacement(
          //   context,
          //   PageTransition(
          //       type: PageTransitionType.fade,
          //       duration: Duration(milliseconds: 500),
          //       child: Home(),
          //       ctx: context),
          // );
        },
        icon: Image(
          image: AssetImage('image/google.png'),
        ),
        label: Text(
          "Login with google",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontFamily: 'PoppinsStyle',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w100,
          ),
        ),
        color: Colors.white,
        splashColor: Colors.grey.shade200,
        height: 36,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List user;
    Signin lp = new Signin();

    Future<Loginpost> connectToAPI(String email, String password) async {
      String lh = main.defaultLocalhost;
      String apiURL = "$lh/api/auth/signUp";

      final apiResult = await http.post(apiURL, body: {
        "email": email,
        "password": password,
      });
      if (apiResult.statusCode == 200) {
        final jsonObject = jsonDecode(apiResult.body);

        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 500),
            child: Login(),
          ),
        );
        setState(() {});
      } else {
        setState(() {});
      }
    }

    String email;
    String password;
    String passwordcheck;
    final formKey = GlobalKey<FormState>();
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            child: AppBar(
              backgroundColor: Colors.white,
              leading: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              title: Container(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'PoppinsStyle',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              actions: [
                Row(
                  children: [buttonLogIn()],
                ),
              ],
            ),
          ),
        ),
        body: Builder(builder: (context) {
          return Form(
            key: formKey,
            child: Container(
              margin: EdgeInsets.all(20),
              child: ListView(
                children: [
                  SizedBox(height: 5.0),
                  Text("Email",
                      style: TextStyle(
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100)),
                  SizedBox(height: 12.0),
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Masukkan email anda';
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      autofocus: false,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100),
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 6.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 22.0),
                  Text("Password",
                      style: TextStyle(
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100)),
                  SizedBox(height: 12.0),
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Masukkan password anda';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      autofocus: false,
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        // hintText: 'Password',
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 6.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 22.0),
                  Text("Password",
                      style: TextStyle(
                          fontFamily: 'PoppinsStyle',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w100)),
                  SizedBox(height: 12.0),
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Masukkan password anda';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          passwordcheck = value;
                        });
                      },
                      obscureText: true,
                      autofocus: false,
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        // hintText: 'Password',
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 6.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  SizedBox(height: 32.0),
                  Container(
                    child: RaisedButton(
                      // onPressed: () {},
                      // onPressed: () {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.fade,
                      //         duration: Duration(milliseconds: 500),
                      //         child: Home(),
                      //         ctx: context),
                      //   );
                      // },
                      onPressed: () {
                        if (formKey.currentState.validate() == true) {
                          formKey.currentState.save();
                          if ("$password" == "$passwordcheck") {
                            connectToAPI("$email", "$password");
                          } else {
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Password tidak sinkron')));
                            });
                          }
                        }
                      },

                      color: Colors.greenAccent,
                      splashColor: Colors.green,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontFamily: 'PoppinsStyle',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w100),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Center(
                    child: Text(
                      "Or",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: 'PoppinsStyle',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  buttonLoginWithGoogle(),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            "Don’t have an account? Sign up",
            style: TextStyle(
                fontSize: 12,
                fontFamily: 'PoppinsStyle',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
    );
  }
}
