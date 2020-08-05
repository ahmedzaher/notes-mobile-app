import 'package:flutter/material.dart';
import 'package:notes_app/screens/authenticate/sign-in.dart';
import 'package:notes_app/screens/authenticate/sign-up.dart';
import 'package:notes_app/services/auth.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn = true;

  toggleView() => setState(() => _showSignIn = !_showSignIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _showSignIn
            ? SignIn(onToggleView: toggleView)
            : SignUp(onToggleView: toggleView),
      ),
    );
  }
}
