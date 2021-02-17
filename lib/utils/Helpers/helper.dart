import 'dart:math';

class Helper {
  static List<dynamic> accumulateVolume(List<dynamic> list) {
    List<dynamic> total = [];
    List<dynamic> volArr = [];
    for (var i = 0; i < list.length; i++) {
      volArr.add(double.parse(list[i][1]));
    }
    for (var i = 0; i < volArr.length; i++) {
      var accumulator = i - 1 > -1 ? total[i - 1] : 0;
      total.add(accumulator + volArr[i]);
    }
    return total;
  }

  static dynamic calcMaxVolume(bids, asks) {
    List<dynamic> combinedList = [
      ...accumulateVolume(bids),
      ...accumulateVolume(asks)
    ];
    final maxValue = combinedList.cast<num>().reduce(max);
    return maxValue;
  }

  static dynamic mapValues(maxVolume, data) {
    var resultData = data != null && maxVolume != 0 && data.length > 0
        ? data.map((currentVolume) {
            return {"value": (currentVolume / maxVolume) * 100};
          }).toList()
        : [];

    return resultData;
  }
}
