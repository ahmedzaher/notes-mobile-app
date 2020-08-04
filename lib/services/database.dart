import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/models/note.dart';

class DatabaseService {
  CollectionReference notesCollection = Firestore.instance.collection('notes');

  List<Note> _notesFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Note(
            id: doc.data['documentID'],
            content: doc.data['content'],
            creationDate: doc.data['creationDate'],
            uid: doc.data['uid']))
        .toList();
  }

  Note _noteFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Note(
        id: snapshot.documentID,
        content: snapshot['content'],
        creationDate: snapshot['creationDate'],
        uid: snapshot['uid']);
  }

  Stream<List<Note>> getNotes(String uid) {
    return notesCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_notesFromQuerySnapshot);
  }

  Stream<Note> getNote(String id) {
    return notesCollection
        .document(id)
        .snapshots()
        .map(_noteFromDocumentSnapshot);
  }

  addNote(Note note) async {
    try {
      DocumentReference docRef = await notesCollection.add({
        'content': note.content,
        'creationDate': note.creationDate,
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
      });
    } catch (e) {
      print(e);
      return null;
    }
  }
}
