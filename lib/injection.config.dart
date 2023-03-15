// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'controller/ki_board_controller.dart' as _i5;
import 'repository/ki_board_repository.dart' as _i3;
import 'service/ki_board_service.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.KiBoardRepository>(() => _i3.KiBoardRepository());
  gh.factory<_i4.KiBoardService>(
      () => _i4.KiBoardService(get<_i3.KiBoardRepository>()));
  gh.factory<_i5.KiBoardController>(
      () => _i5.KiBoardController(kiBoardService: get<_i4.KiBoardService>()));
  return get;
}
