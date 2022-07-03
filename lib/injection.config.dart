// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import 'controller/ki_board_controller.dart' as _i7;
import 'injectable_module.dart' as _i8;
import 'repository/ki_board_repository.dart' as _i4;
import 'service/board_list_service.dart' as _i6;
import 'service/ki_board_service.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectionModule = _$InjectionModule();
  await gh.factoryAsync<_i3.SharedPreferences>(() => injectionModule.prefs,
      preResolve: true);
  gh.factory<_i4.KiBoardRepository>(() =>
      _i4.KiBoardRepository(sharedPreferences: get<_i3.SharedPreferences>()));
  gh.factory<_i5.KiBoardService>(
      () => _i5.KiBoardService(get<_i4.KiBoardRepository>()));
  gh.factory<_i6.BoardListService>(
      () => _i6.BoardListService(get<_i4.KiBoardRepository>()));
  gh.factory<_i7.KiBoardController>(() => _i7.KiBoardController(
      boardListService: get<_i6.BoardListService>(),
      kiBoardService: get<_i5.KiBoardService>()));
  return get;
}

class _$InjectionModule extends _i8.InjectionModule {}
