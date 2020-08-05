import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/user.dart';
import 'package:notes_app/screens/shared/loading.dart';
import 'package:notes_app/services/notes-service.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {

  bool _loading = false;
  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);

    Map data = ModalRoute.of(context).settings.arguments;
    bool isExistNote = data != null && data.containsKey('noteId') ;
    String barTitle = isExistNote ? 'Edit note' : 'Type note';

    return _loading ? Loading() : FutureBuilder<Note>(
      future: isExistNote ? NotesService().getNote2(data['noteId']) : Future(() => Note()),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Loading();
        } else {
          Note note = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(barTitle),
              centerTitle: true,
              backgroundColor: Colors.amber[400],
              elevation: 0,
              actions: !isExistNote? [] : [
                IconButton(
                    onPressed: () => _deleteNote(note.id),
                    icon: Icon(Icons.delete, color: Colors.white),)
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: TextFormField(
                    initialValue: note.content,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'IndieFlower'
                    ),
                    decoration: InputDecoration(
                        hintText: "Type your note here",
                        fillColor: Colors.yellow[100],
                        filled: true
                    ),
                    scrollPadding: EdgeInsets.all(20.0),

                    keyboardType: TextInputType.multiline,
                    maxLines: 99999,
                    autofocus: true,
                    onChanged: (value) {
                      note.content = value;
                    }
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amber[400],
              child: Icon(Icons.check),
              onPressed: () async {
                if(note.content.isEmpty) {
                  return;
                }
                if(note.id == null) {
                  note.uid = user.uid;
                  dynamic n =  await NotesService().addNote(note);
                } else {
                  await NotesService().updateNote(note);
                }
                Navigator.pop(context);
              },
            ),
          );
        }

      }
    );

  }

  _deleteNote(String noteId) async {
    _loading = true;
    bool deleted = await NotesService().deleteNote(noteId);
    if(!deleted) {
      _loading = false;
    } else {
      Navigator.pop(context);
    }
  }
}
