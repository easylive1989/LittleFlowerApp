// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'controller/ki_board_controller.dart' as _i7;
import 'repository/ki_board_repository_factory.dart' as _i4;
import 'repository/preference_api.dart' as _i3;
import 'service/board_list_service.dart' as _i6;
import 'service/ki_board_service.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.PreferenceApi>(() => _i3.PreferenceApi());
  gh.factory<_i4.KiBoardRepositoryFactory>(
      () => _i4.KiBoardRepositoryFactory(get<_i3.PreferenceApi>()));
  gh.factory<_i5.KiBoardService>(
      () => _i5.KiBoardService(get<_i4.KiBoardRepositoryFactory>()));
  gh.factory<_i6.BoardListService>(
      () => _i6.BoardListService(get<_i4.KiBoardRepositoryFactory>()));
  gh.factory<_i7.KiBoardController>(() => _i7.KiBoardController(
      boardListService: get<_i6.BoardListService>(),
      kiBoardService: get<_i5.KiBoardService>()));
  return get;
}
