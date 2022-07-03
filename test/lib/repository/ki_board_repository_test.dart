import 'package:little_flower_app/entity/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:little_flower_app/repository/shared_preference_access_exception.dart';
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

  test("saveKiBoard ok", () async {
    givenSetStringOk();

    await kiBoardRepository.saveKiBoard("123", KiBoard(boardId: "123"));

    verify(() => mockSharedPreferences.setString(
        "123", "{\"blackKiList\":[],\"whiteKiList\":[],\"boardId\":\"123\"}"));
  });

  test("saveKiBoard fail", () async {
    givenSetStringFail();

    expect(() => kiBoardRepository.saveKiBoard("123", KiBoard(boardId: "123")),
        throwsA(isA<SharedPreferenceAccessException>()));
  });

  test("getKiBoard", () async {
    givenGet("{\"blackKiList\":[],\"whiteKiList\":[],\"boardId\":\"123\"}");

    KiBoard? kiBoard = await kiBoardRepository.getKiBoard("123");

    expect(kiBoard, KiBoard(boardId: "123"));
  });

  test("getBoardIds", () async {
    givenGetKeys({"111", "222", "333"});

    List<String> boardIds = await kiBoardRepository.getBoardIds();

    expect(boardIds, ["111", "222", "333"]);
  });

  test("remove", () async {
    givenRemoveOk();

    await kiBoardRepository.remove("123");

    verify(() => mockSharedPreferences.remove("123"));
  });
}

void givenSetStringFail() {
  when(() => mockSharedPreferences.setString(any(), any()))
      .thenThrow(Exception());
}

void givenRemoveOk() {
  when(() => mockSharedPreferences.remove(any()))
      .thenAnswer((invocation) async => true);
}

void givenGetKeys(Set<String> boardIds) {
  when(() => mockSharedPreferences.getKeys()).thenReturn(boardIds);
}

void givenSetStringOk() {
  when(() => mockSharedPreferences.setString(any(), any()))
      .thenAnswer((value) async => true);
}

void givenGet(String data) {
  when(() => mockSharedPreferences.get(any())).thenReturn((value) {
    return data;
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
