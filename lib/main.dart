import 'package:flutter/material.dart';
import 'package:notes_app/models/user.dart';
import 'package:notes_app/screens/home/home.dart';
import 'package:notes_app/screens/note-form//note-form.dart';
import 'package:notes_app/screens/wrapper.dart';
import 'package:notes_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/note-form': (context) => NoteForm(),
        },
      ),
    );
  }
}
