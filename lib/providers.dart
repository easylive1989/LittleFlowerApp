import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/entity/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final kiBoardRepositoryProvider =
    FutureProvider<KiBoardRepository>((ref) async {
  return KiBoardRepository(
      sharedPreferences: await SharedPreferences.getInstance());
});

final kiBoardsProvider = FutureProvider<List<KiBoard>>((ref) async {
  var kiBoardRepository = await ref.watch(kiBoardRepositoryProvider.future);
  return kiBoardRepository.getKiBoards();
});
