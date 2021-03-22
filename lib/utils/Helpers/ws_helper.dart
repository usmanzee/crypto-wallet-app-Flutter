import 'package:crypto_template/models/open_order.dart';

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
    var newLevelPrice =
        newLevel[0] != "" ? double.parse(newLevel[0]) : double.parse('0');
    var newLevelVolume =
        newLevel[1] != "" ? double.parse(newLevel[1]) : double.parse('0');
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

  static List<OpenOrder> insertOrUpdate(List<OpenOrder> openOrdersList, order) {
    var id = order['id'];
    var state = order['state'];
    var createdAt = DateTime.fromMillisecondsSinceEpoch(order['at'] * 1000);
    switch (state) {
      case 'wait':
        var index = openOrdersList.indexWhere((openOrder) {
          return openOrder.id == id;
        });
        if (index == -1) {
          var newOpenOrder = new OpenOrder(
            id: id,
            side: order['kind'].toString(),
            ordType: null,
            price: order['price'].toString(),
            avgPrice: null,
            state: state,
            market: order['market'].toString(),
            createdAt: createdAt,
            originVolume: order['origin_volume'].toString(),
            remainingVolume: order['remaining_volume'].toString(),
            executedVolume: null,
            tradesCount: null,
          );
          openOrdersList.insert(0, newOpenOrder);
          return openOrdersList;
        }
        return openOrdersList.map((openOrder) {
          if (openOrder.id == id) {
            var newOpenOrder = new OpenOrder(
              id: id,
              side: order['kind'].toString(),
              ordType: null,
              price: order['price'].toString(),
              avgPrice: null,
              state: state,
              market: order['market'].toString(),
              createdAt: createdAt,
              originVolume: order['origin_volume'].toString(),
              remainingVolume: order['remaining_volume'].toString(),
              executedVolume: null,
              tradesCount: null,
            );
            return newOpenOrder;
          }
          return openOrder;
        }).toList();
      default:
        openOrdersList.removeWhere((openOrder) {
          return openOrder.id == id;
        });
        return openOrdersList;
    }
  }
}
