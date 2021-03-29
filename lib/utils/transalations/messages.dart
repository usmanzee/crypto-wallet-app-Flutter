import 'package:get/get.dart';
import 'package:b4u_wallet/utils/transalations/en.dart';
import 'package:b4u_wallet/utils/transalations/ru.dart';
import 'package:b4u_wallet/utils/transalations/es.dart';
import 'package:b4u_wallet/utils/transalations/ml.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ru_RU': ru,
        'es_ES': es,
        'ms_MY': ml,
      };
}
