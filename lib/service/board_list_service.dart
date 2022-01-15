import 'package:injectable/injectable.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/ki_board_repository_factory.dart';

@Injectable()
class BoardListService {
  final KiBoardRepository _localRepository;

  BoardListService(KiBoardRepositoryFactory kiBoardRepositoryFactory)
      : _localRepository = kiBoardRepositoryFactory.local();

  Future<List<String>> allOtherBoardIds(String boardId) async =>
      (await _getBoardIdList()).where((id) => id != boardId).toList();

  Future<List<String>> get allBoardIds async => await _getBoardIdList();

  Future<List<String>> _getBoardIdList() async {
    return await _localRepository.getBoardIds();
  }
}