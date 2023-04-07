import 'package:get/get.dart';
class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'Ā' : 'A',
        },
        'hi_IN': {
          'hello': 'नमस्ते दुनिया',
          'Ā' : 'आ',
        }
      };
}