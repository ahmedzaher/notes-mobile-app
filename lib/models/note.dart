import 'dart:convert';

class Note {

  String id;
  String content;
  DateTime creationDate;
  String uid;

  Note({this.id, this.content, this.creationDate, this.uid});
  static Note clone(Note note) {
    return Note(id: note.id, content: note.content, creationDate: note.creationDate);
  }
}