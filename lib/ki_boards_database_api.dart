import 'package:firebase_database/firebase_database.dart';

class KiBoardsDatabaseApi {
  DatabaseReference _kiBoardRef;

  KiBoardsDatabaseApi() {
    _kiBoardRef = FirebaseDatabase.instance.reference().child('kiBoards');
  }

  update(String boardId, String board) {
    _kiBoardRef.child(boardId).set(board);
  }
}
