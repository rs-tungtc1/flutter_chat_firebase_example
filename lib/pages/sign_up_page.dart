import 'package:chat_example/pages/home_page.dart';
import 'package:chat_example/pages/sign_in_page.dart';
import 'package:chat_example/services/auth.dart';
import 'package:chat_example/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey _formKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  Auth authService = Auth();

  void _signUp() {
    authService
        .signUpWithEmailAndPassword(_emailController.text, _passController.text)
        .then((value) {
      Map<String, String> userInfo = {
        "email": _emailController.text,
        "name": _nameController.text
      };
      Database.uploadUserInfo(userInfo);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  void _navigatorSignIn() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                SizedBox(
                    width: double.infinity,
                    child: Text('Sign up',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                        textAlign: TextAlign.center)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'Full name'),
                  ),
                ),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.red)),
                        onPressed: _signUp,
                        child: Text('Sign up',
                            style: TextStyle(color: Colors.white)))),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If you have account ? ",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: _navigatorSignIn,
                          child: Text(
                            'Sign in now',
                            style: TextStyle(color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
