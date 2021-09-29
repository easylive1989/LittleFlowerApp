// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'repository/firebase_database_api.dart' as _i3;
import 'repository/ki_board_repository_factory.dart' as _i5;
import 'repository/preference_api.dart' as _i4;
import 'service/ki_board_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.FirebaseDatabaseApi>(() => _i3.FirebaseDatabaseApi());
  gh.factory<_i4.PreferenceApi>(() => _i4.PreferenceApi());
  gh.factory<_i5.KiBoardRepositoryFactory>(() => _i5.KiBoardRepositoryFactory(
      get<_i3.FirebaseDatabaseApi>(), get<_i4.PreferenceApi>()));
  gh.factory<_i6.KiBoardService>(
      () => _i6.KiBoardService(get<_i5.KiBoardRepositoryFactory>()));
  return get;
}
