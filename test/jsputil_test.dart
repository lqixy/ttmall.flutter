import 'package:flutter_test/flutter_test.dart';
import 'package:ttmall/services/jsp_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('init', () async {
    await JSpUtil.instance.init();
    expect(JSpUtil.instance, isNotNull);
  });
}
