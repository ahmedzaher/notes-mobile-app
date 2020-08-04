import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/DateUtils.dart';

Widget NoteCard(Note note) {
  return Card(
    color: Colors.yellow[100],
    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),

    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            note.content,
            style: TextStyle(
                fontFamily: 'IndieFlower', letterSpacing: 1.5, fontSize: 26.0, color: Colors.grey[900]),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formatDate(note.creationDate),
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    ),
  );
}
