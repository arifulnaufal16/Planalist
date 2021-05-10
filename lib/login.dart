import 'dart:convert';
import 'package:Planalist/home.dart';
import 'package:Planalist/signup.dart';
import 'package:Planalist/task/myTask.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Planalist/main.dart' as main;
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class Loginpost {
  final String email;
  final String password;
  Loginpost({this.email, this.password});
  factory Loginpost.fromJson(Map<String, dynamic> json) {
    return Loginpost(
      email: json['email'],
      password: json['password'],
    );
  }
  static Future<Loginpost> connectToAPI(String email, String password) async {
    String lh = main.defaultLocalhost;
    String apiURL = "$lh/api/auth/signin";
    final apiResult = await http.post(apiURL, body: {
      "email": email,
      "password": password,
    });
    if (apiResult.statusCode == 200) {
      final jsonObject = jsonEncode(apiResult.body);
    }
  }
}

class _LoginState extends State<Login> {
  @override
  Widget buttonLoginWithGoogle() {
    return Container(
      child: FlatButton.icon(
        // onPressed: () {},
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                child: Home(),
                ctx: context),
          );
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

  Widget titleBar() {
    return Container(
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'PoppinsStyle',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget nextSignUp() {
    return Container(
      child: FlatButton(
          splashColor: Colors.white,
          highlightColor: Colors.white,
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PoppinsStyle',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 800),
                  child: Signup(),
                  ctx: context),
            );
          }),
    );
  }

  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String email;
    String password;
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
            child: AppBar(
              bottomOpacity: 50,
              backgroundColor: Colors.white,
              leading: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleBar(),
                  nextSignUp(),
                ],
              ),
            ),
          ),
        ),
        body: Form(
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
                    ),
                  ),
                ),
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
                      formKey.currentState.save();
                      Loginpost.connectToAPI("$email", "$password");
                      print(email);
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: Home(),
                            duration: Duration(milliseconds: 500),
                            ctx: context),
                      );

                      // print(widget.plant_length);
                      // print(plant_code.runtimeType);
                    },
                    color: Colors.amberAccent,
                    splashColor: Colors.amber,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
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
        ),
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
