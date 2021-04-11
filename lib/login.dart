import 'package:Planalist/signup.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget formTextEmail() {
    return Container(
      child: TextField(
        autofocus: false,
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          // hintText: 'Username',
          filled: true,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
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
    );
  }

  Widget formTextPassword() {
    return Container(
      child: TextField(
        obscureText: true,
        autofocus: false,
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          // hintText: 'Password',
          filled: true,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
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
    );
  }

  Widget buttonLogin() {
    return Container(
      child: RaisedButton(
        // onPressed: () {},
        onPressed: () {},
        color: Colors.amberAccent,
        splashColor: Colors.amber,
        child: Text("Login"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget titleBar() {
    return Container(
      child: Text(
        "Login",
        style: TextStyle(color: Colors.black, fontSize: 16),
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
            style: TextStyle(color: Colors.black, fontSize: 16),
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
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(height: 5.0),
              Text("Email"),
              SizedBox(height: 15.0),
              formTextEmail(),
              SizedBox(height: 25.0),
              Text("Password"),
              SizedBox(height: 15.0),
              formTextPassword(),
              SizedBox(height: 35.0),
              buttonLogin()
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
