import 'package:injectable/injectable.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/preference_api.dart';

@Injectable()
class KiBoardRepositoryFactory {
  final PreferenceApi _preferenceApi;

  KiBoardRepositoryFactory(PreferenceApi preferenceApi)
      : _preferenceApi = preferenceApi;

  KiBoardRepository local() {
    return _preferenceApi;
  }
}
