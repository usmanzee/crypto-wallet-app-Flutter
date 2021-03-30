import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:http/http.dart' as http;

class MarketDetailGraph extends StatefulWidget {
  final selectedGraph;
  final String title;

  MarketDetailGraph({Key key, this.title, @required this.selectedGraph})
      : super(key: key);

  @override
  _MarketDetailGraphState createState() =>
      _MarketDetailGraphState(selectedGraph);
}

class _MarketDetailGraphState extends State<MarketDetailGraph> {
  final selectedGraph;
  _MarketDetailGraphState(this.selectedGraph);

  List<KLineEntity> newData = <KLineEntity>[];
  List<KLineEntity> datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  bool isChinese = true;
  List<DepthEntity> _bids, _asks;

  @override
  void initState() {
    super.initState();
    getData('1min');
    getApiData();
    rootBundle.loadString('assets/depth.json').then((result) {
      final parseJson = json.decode(result);
      Map tick = parseJson['tick'];
      var bids = tick['bids']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      var asks = tick['asks']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      initDepth(bids, asks);
    });
  }

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids?.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids.insert(0, item);
    });

    amount = 0.0;
    asks?.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks?.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks.add(item);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(children: <Widget>[
          if (showLoading)
            Container(
                width: double.infinity,
                height: 200,
                alignment: Alignment.center,
                child: CircularProgressIndicator()),
          Container(
            height: 200,
            width: double.infinity,
            child: KChartWidget(
              newData,
              isLine: isLine,
              mainState: _mainState,
              volHidden: _volHidden,
              secondaryState: _secondaryState,
              fixedLength: 2,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              isChinese: isChinese,
              bgColor: [
                Colors.white,
                Colors.white,
              ],
            ),
          ),
        ]),
        // buildButtons(),

        Container(
          height: 230,
          width: double.infinity,
          child: DepthChart(_bids, _asks),
        )
      ],
    );
  }

  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        button("Time sharing", onPressed: () => isLine = true),
        button("k line", onPressed: () => isLine = false),
        button("MA", onPressed: () => _mainState = MainState.MA),
        button("BOLL", onPressed: () => _mainState = MainState.BOLL),
        button("hide", onPressed: () => _mainState = MainState.NONE),
        button("MACD", onPressed: () => _secondaryState = SecondaryState.MACD),
        button("KDJ", onPressed: () => _secondaryState = SecondaryState.KDJ),
        button("RSI", onPressed: () => _secondaryState = SecondaryState.RSI),
        button("WR", onPressed: () => _secondaryState = SecondaryState.WR),
        button("Hide side view",
            onPressed: () => _secondaryState = SecondaryState.NONE),
        button(_volHidden ? "Show volume" : "Hide volume",
            onPressed: () => _volHidden = !_volHidden),
        button("切换中英文", onPressed: () => isChinese = !isChinese),
      ],
    );
  }

  Widget button(String text, {VoidCallback onPressed}) {
    return MaterialButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
            setState(() {});
          }
        },
        child: Text("$text"),
        color: Colors.blue);
  }

  void getData(String period) {
    Future<String> future = getIPAddress('$period');
    future.then((result) {
      Map parseJson = json.decode(result);
      List list = parseJson['data'];
      // print('luist');
      // print(list);
      datas = list
          .map((item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      // print(datas);
      DataUtil.calculate(datas);
      showLoading = false;
      setState(() {});
    }).catchError((_) {
      showLoading = false;
      setState(() {});
      print('获取数据失败');
    });
  }

  void getApiData() {
    Future<String> future = callURL(
        'https://ewallet.b4uwallet.com/api/v2/peatio/public/markets/rscusd/k-line?period=15&time_from=1610582371&time_to=1610695831');
    future.then((result) {
      var data = json.decode(result);

      var keys = ['time', 'open', 'high', 'low', 'close', 'vol'];
      for (var i = 0; i < data.length; i++) {
        Map<String, dynamic> newObj = {};
        KLineEntity newKlineObj;
        for (var j = 0; j < keys.length; j++) {
          newObj.addAll({keys[j]: data[i][j]});
        }
        newKlineObj = new KLineEntity.fromJson(newObj);
        newData.add(newKlineObj);
        DataUtil.calculate(newData);
      }
    }).catchError((e) {
      showLoading = false;
      setState(() {});
      print('error url: $e');
    });
  }

  //获取火币数据，需要翻墙
  Future<String> getIPAddress(String period) async {
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';
    print('url: $url');
    String result;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      print('Failed getting IP address');
    }
    return result;
  }

  Future<String> callURL(String url) async {
    print('url: $url');
    String result;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      print('Failed getting IP address');
    }
    return result;
  }
}

class KlineClass {
  final date;
  final open;
  final high;
  final low;
  final close;
  final volume;

  KlineClass(
      this.date, this.open, this.high, this.low, this.close, this.volume);
}
