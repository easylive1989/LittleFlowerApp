import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:little_flower_app/model/ki_board.dart';

class FirebaseDatabaseApi {
  DatabaseReference _kiBoardRef;

  FirebaseDatabaseApi() {
    _kiBoardRef = FirebaseDatabase.instance.reference().child('kiBoards');
  }

  void update(String boardId, KiBoard kiBoard) {
    _kiBoardRef.child(boardId).set(jsonEncode(kiBoard.toJson()));
  }

  Stream<KiBoard> onValue(boardId) {
    return _kiBoardRef.child(boardId).onValue.map((event) {
      return event.snapshot.value != null
          ? KiBoard.fromJson(jsonDecode(event.snapshot.value))
          : KiBoard();
    });
  }
}
