import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/game_visibility.dart';
import 'package:little_flower_app/repository/firebase_database_api.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/preference_api.dart';

@Injectable()
class KiBoardRepositoryFactory {
  final FirebaseDatabaseApi _firebaseDatabaseApi;
  final PreferenceApi _preferenceApi;

  KiBoardRepositoryFactory(
      FirebaseDatabaseApi firebaseDatabaseApi, PreferenceApi preferenceApi)
      : _firebaseDatabaseApi = firebaseDatabaseApi,
        _preferenceApi = preferenceApi;

  KiBoardRepository get(GameVisibility gameVisibility) {
    switch (gameVisibility) {
      case GameVisibility.public:
        return _firebaseDatabaseApi;
      case GameVisibility.private:
        return _preferenceApi;
    }
  }
}
