import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/repository/firebase_database_api.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/preference_api.dart';

class KiBoardRepositoryFactory {
  KiBoardRepository get(GameVisibility gameVisibility) {
    switch (gameVisibility) {
      case GameVisibility.public:
        return FirebaseDatabaseApi();
      case GameVisibility.private:
        return PreferenceApi();
    }
  }
}
