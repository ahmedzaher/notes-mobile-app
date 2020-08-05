import 'package:flutter/material.dart';
import 'package:notes_app/models/user.dart';
import 'package:notes_app/screens/authenticate/authenticate.dart';
import 'package:notes_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return user == null ? Authenticate() : Home();

  }
}
