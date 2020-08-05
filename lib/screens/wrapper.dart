import 'package:flutter/material.dart';
import 'package:notes_app/models/user.dart';
import 'package:notes_app/screens/authenticate/authenticate.dart';
import 'package:notes_app/screens/home/home.dart';
import 'package:notes_app/services/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        return snapshot.hasData ? Home() : Authenticate();
      }
    );
  }
}
