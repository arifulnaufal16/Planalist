import 'package:Planalist/login.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(color: Colors.black),
                ),
              ),
              actions: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      child: TextButton(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Login();
                            }));
                          }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(height: 5.0),
              Text("Email"),
              SizedBox(height: 15.0),
              Container(
                child: TextField(
                  autofocus: false,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: 'Username',
                    filled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text("Password"),
              SizedBox(height: 15.0),
              Container(
                child: TextField(
                  obscureText: true,
                  autofocus: false,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: 'Password',
                    filled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text("Re-Enter Password"),
              SizedBox(height: 15.0),
              Container(
                child: TextField(
                  obscureText: true,
                  autofocus: false,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // hintText: 'Password',
                    filled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35.0),
              Container(
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.amberAccent,
                  splashColor: Colors.amber,
                  child: Text("Sign Up"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text("Don’t have an account? Sign up"),
        ),
      ),
    );
  }
}
