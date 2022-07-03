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
    givenSetStringOk();

    await kiBoardRepository.saveKiBoard("123", KiBoard(boardId: "123"));

    verify(() => mockSharedPreferences.setString(
        "123", "{\"blackKiList\":[],\"whiteKiList\":[],\"boardId\":\"123\"}"));
  });

  test("getKiBoard", () async {
    givenGet("{\"blackKiList\":[],\"whiteKiList\":[],\"boardId\":\"123\"}");

    KiBoard? kiBoard = await kiBoardRepository.getKiBoard("123");

    expect(kiBoard, KiBoard(boardId: "123"));
  });
}

void givenSetStringOk() {
  when(() => mockSharedPreferences.setString(any(), any()))
      .thenAnswer((value) async => true);
}

void givenGet(String data) {
  when(() => mockSharedPreferences.get(any())).thenAnswer((value) {
    return data;
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
