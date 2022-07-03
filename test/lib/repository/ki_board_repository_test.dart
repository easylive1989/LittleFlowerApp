import 'package:little_flower_app/entity/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

late MockSharedPreferences mockSharedPreferences;
late KiBoardRepository kiBoardRepository;
main() {
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    kiBoardRepository =
        KiBoardRepository(sharedPreferences: mockSharedPreferences);
  });

  test("saveKiBoard", () async {
    when(() => mockSharedPreferences.setString(any(), any()))
        .thenAnswer((value) async => true);
    await kiBoardRepository.saveKiBoard("123", KiBoard(boardId: "123"));

    verify(() => mockSharedPreferences.setString(
        "123", "{\"blackKiList\":[],\"whiteKiList\":[],\"boardId\":\"123\"}"));
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
