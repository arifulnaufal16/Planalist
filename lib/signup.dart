import 'package:Planalist/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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

  Widget buttonSignUp() {
    return Container(
      child: RaisedButton(
        // onPressed: () {},
        onPressed: () {},
        color: Colors.amberAccent,
        splashColor: Colors.amber,
        child: Text("Sign Up"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget buttonLogIn() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: TextButton(
        child: Text(
          "Login",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        onPressed: () {
          Navigator.push(
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
                  style: TextStyle(color: Colors.black, fontSize: 16),
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
              SizedBox(height: 25.0),
              Text("Re-Enter Password"),
              SizedBox(height: 15.0),
              formTextPassword(),
              SizedBox(height: 35.0),
              buttonSignUp(),
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
