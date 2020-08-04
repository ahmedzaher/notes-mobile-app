import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/services/notes-service.dart';

import 'note_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Note>>(
        stream: NotesService().getNotes('0'),
        builder: (context, snapshot) {
          List<Note> notes = snapshot.data ?? [];
          notes.sort((a, b) => b.creationDate.compareTo(a.creationDate));
          return Scaffold(
            backgroundColor: Colors.amber[400],
            body: SafeArea(
              child: notes.length == 0  ?_emptyNotes() : _notesWidget(notes, context)
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                dynamic data = await Navigator.pushNamed(context, '/note-form');
              },
              backgroundColor: Colors.yellow[50],
              child: Icon(
                Icons.add,
                size: 30.0,
                color: Colors.amber[700],
              ),
            ),
          );
        });
  }

  Widget _emptyNotes() {
    return Center(
      child: Text(
        'No notes yet',
        style: TextStyle(
            color: Colors.grey[100],
            fontSize: 35.0,
            fontFamily: 'IndieFlower',
            letterSpacing: 1.5),
      ),
    );
  }

  Widget _notesWidget(List<Note> notes, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: notes
            .map((note) => GestureDetector(
                  child: NoteCard(note),
                  onTap: () async {
                    dynamic data = await Navigator.pushNamed(
                        context, '/note-form',
                        arguments: {'noteId': note.id});
                  },
                ))
            .toList(),
      ),
    );
  }
}
