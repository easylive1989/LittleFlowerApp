import 'package:firebase_database/firebase_database.dart';

class KiBoardsDatabaseApi {
  DatabaseReference _kiBoardRef;

  KiBoardsDatabaseApi() {
    _kiBoardRef = FirebaseDatabase.instance.reference().child('kiBoards');
  }

  update(String gameId, String board) {
    _kiBoardRef.child(gameId).set(board);
  }
}
