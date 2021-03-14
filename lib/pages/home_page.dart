import 'package:chat_example/pages/search_page.dart';
import 'package:chat_example/pages/sign_in_page.dart';
import 'package:chat_example/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth _authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _authService.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SignInPage()));
              }),
        ],
      ),
      body: Center(
        child: GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => SearchPage())),
            child: Text('Home Page')),
      ),
    );
  }
}
