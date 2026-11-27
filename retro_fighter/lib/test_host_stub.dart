import 'turn_test.dart';

const canHost = false;

class TestHost {
  final game = TurnTest();
  List<String> get urls => const [];
  static Future<TestHost> start(void Function() changed) =>
      throw UnsupportedError('Start the test on an Android phone.');
  Future<void> close() async {}
}
