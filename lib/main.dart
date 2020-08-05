import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/home.dart';
import 'package:notes_app/screens/note-form//note-form.dart';
import 'package:notes_app/screens/wrapper.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Wrapper(),
      '/home': (context) => Home(),
      '/note-form': (context) => NoteForm(),
    },
  ));
}


