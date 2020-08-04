import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/models/note.dart';

class NotesService {
  CollectionReference notesCollection = Firestore.instance.collection('notes');

  List<Note> _notesFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Note(
            id: doc.documentID,
            content: doc.data['content'],
            creationDate: doc.data['creationDate'].toDate(),
            uid: doc.data['uid']))
        .toList();
  }

  Note _noteFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Note(
        id: snapshot.documentID,
        content: snapshot['content'],
        creationDate: snapshot['creationDate'].toDate(),
        uid: snapshot['uid']);
  }

  Stream<List<Note>> getNotes(String uid) {
      return notesCollection
          .where('uid', isEqualTo: uid)
          .snapshots()
          .map(_notesFromQuerySnapshot)
          .handleError(_handleError);
  }

  Stream<Note> getNote(String id)  {
    return notesCollection
        .document(id)
        .snapshots()
        .map(_noteFromDocumentSnapshot)
        .handleError(_handleError);
  }


//  Stream<Note> getNote(String id)  {
  Future<Note> getNote2(String id) async {
    return await notesCollection.document(id).get().then(_noteFromDocumentSnapshot);
//    return notesCollection
//        .document(id)
//        .snapshots()
//        .map(_noteFromDocumentSnapshot)
//        .handleError(_handleError);
  }


  Future<Note> addNote(Note note) async {
    try {
      DocumentReference docRef = await notesCollection.add({
        'content': note.content,
        'creationDate': DateTime.now(),
        'uid': note.uid
      });
      note.id = docRef.documentID;
      return note;
    } catch (e) {
      print(e);
      return null;
    }
  }

  updateNote(Note note) async {
    try {
      await notesCollection.document(note.id).setData({
        'content': note.content,
        'creationDate': note.creationDate,
        'uid': note.uid,
      });
      print('Note saved');
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> deleteNote(String noteId) async {
    try {
      await notesCollection.document(noteId).delete();
      print('Note deleted');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  _handleError(err) {
    print(err);
    return null;
  }
}
