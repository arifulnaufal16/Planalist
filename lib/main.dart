import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  "Log In",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              actions: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.black),
                      ),
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
                  autofocus: true,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Username',
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
                  autofocus: true,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
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
                  child: Text("Log In"),
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
