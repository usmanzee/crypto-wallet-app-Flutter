import 'dart:convert';
import 'package:get/get.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/controllers/web_socket_controller.dart';

class WsHelper {
  static bool isArray(String type) {
    return type.lastIndexOf(']') == type.length - 1;
  }

  static List<T> splice<T>(List<T> list, int index,
      [num howMany = 0, /*<T | List<T>>*/ elements]) {
    var endIndex = index + howMany.truncate();
    list.removeRange(index, endIndex >= list.length ? list.length : endIndex);
    if (elements != null)
      list.insertAll(index, elements is List<T> ? elements : <T>[elements]);
    return list;
  }

  static List<dynamic> handleIncrementalUpdate(depthOld, newLevel, type) {
    if (newLevel.length != 2) {
      return depthOld;
    }
    var newLevelPrice = double.parse(newLevel[0]);
    var newLevelVolume = double.parse(newLevel[1]);
    var depthNew = [...depthOld];

    if (depthOld.length == 0) {
      return [newLevel];
    }

    for (var index = 0; index < depthOld.length; index++) {
      var levelPrice = double.parse(depthOld[index][0]);
      if (type == 'asks' && newLevelVolume > 0) {
        if (newLevelPrice < levelPrice) {
          splice(depthNew, index, 0, [newLevel]);

          break;
        }

        if (newLevelPrice > levelPrice && index == (depthOld.length - 1)) {
          depthNew.add(newLevel);
          break;
        }
      }

      if (type == 'bids' && newLevelVolume > 0) {
        if (newLevelPrice > levelPrice) {
          splice(depthNew, index, 0, [newLevel]);
          break;
        }

        if (newLevelPrice < levelPrice && index == (depthOld.length - 1)) {
          depthNew.add(newLevel);
          break;
        }
      }

      if (newLevelPrice == levelPrice) {
        if (newLevelVolume == 0) {
          splice(depthNew, index, 1);
        } else {
          splice(depthNew, index, 1, [newLevel]);
        }
        break;
      }
    }
    return depthNew;
  }
}
