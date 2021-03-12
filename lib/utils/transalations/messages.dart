import 'package:get/get.dart';
import 'package:crypto_template/utils/transalations/en.dart';
import 'package:crypto_template/utils/transalations/ru.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ru_RU': ru,
      };
}
