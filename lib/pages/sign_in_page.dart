import 'package:chat_example/pages/home_page.dart';
import 'package:chat_example/pages/sign_up_page.dart';
import 'package:chat_example/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey _formKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  Auth authService = Auth();

  void _login() async {
    authService
        .signInWithEmailAndPassword(_emailController.text, _passController.text)
        .then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  void _navigatorSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
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
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                        textAlign: TextAlign.center)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Username'),
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
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.red)),
                        onPressed: _login,
                        child: Text('Sign in',
                            style: TextStyle(color: Colors.white)))),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If you don't have account? ",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: _navigatorSignUp,
                          child: Text(
                            'Sign up now',
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
