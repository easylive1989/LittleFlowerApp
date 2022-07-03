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

  test("getKiBoard ok", () async {
    givenGet("{\"blackKiList\":[],\"whiteKiList\":[],\"boardId\":\"123\"}");

    KiBoard? kiBoard = await kiBoardRepository.getKiBoard("123");

    expect(kiBoard, KiBoard(boardId: "123"));
  });

  test("getKiBoard fail", () async {
    givenGetFail();

    expect(() => kiBoardRepository.getKiBoard("123"),
        throwsA(isA<SharedPreferenceAccessException>()));
  });

  test("getBoardIds ok", () async {
    givenGetKeys({"111", "222", "333"});

    List<String> boardIds = await kiBoardRepository.getBoardIds();

    expect(boardIds, ["111", "222", "333"]);
  });

  test("getBoardIds fail", () async {
    givenGetKeysFail();

    expect(() => kiBoardRepository.getBoardIds(),
        throwsA(isA<SharedPreferenceAccessException>()));
  });

  test("remove ok", () async {
    givenRemoveOk();

    await kiBoardRepository.remove("123");

    verify(() => mockSharedPreferences.remove("123"));
  });

  test("remove fail", () async {
    givenRemoveFail();

    expect(() => kiBoardRepository.remove("123"),
        throwsA(isA<SharedPreferenceAccessException>()));
  });
}

void givenRemoveFail() {
  when(() => mockSharedPreferences.remove(any())).thenThrow(Exception());
}

void givenGetKeysFail() {
  when(() => mockSharedPreferences.getKeys()).thenThrow(Exception());
}

void givenGetFail() {
  when(() => mockSharedPreferences.get(any())).thenThrow(Exception());
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
