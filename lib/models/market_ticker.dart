import 'dart:convert';

Map<String, MarketTicker> marketTickerFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, MarketTicker>(k, MarketTicker.fromJson(v)));

String marketTickerToJson(Map<String, MarketTicker> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class MarketTicker {
  MarketTicker({
    this.at,
    this.ticker,
  });

  int at;
  Ticker ticker;

  factory MarketTicker.fromJson(Map<String, dynamic> json) => MarketTicker(
        at: json["at"],
        ticker: Ticker.fromJson(json["ticker"]),
      );

  Map<String, dynamic> toJson() => {
        "at": at,
        "ticker": ticker.toJson(),
      };
}

class Ticker {
  Ticker({
    this.buy,
    this.sell,
    this.low,
    this.high,
    this.open,
    this.last,
    this.volume,
    this.avgPrice,
    this.priceChangePercent,
    this.vol,
  });

  String buy;
  String sell;
  String low;
  String high;
  String open;
  String last;
  String volume;
  String avgPrice;
  String priceChangePercent;
  String vol;

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
        buy: json["buy"],
        sell: json["sell"],
        low: json["low"],
        high: json["high"],
        open: json["open"],
        last: json["last"],
        volume: json["volume"],
        avgPrice: json["avg_price"],
        priceChangePercent: json["price_change_percent"],
        vol: json["vol"],
      );

  Map<String, dynamic> toJson() => {
        "buy": buy,
        "sell": sell,
        "low": low,
        "high": high,
        "open": open,
        "last": last,
        "volume": volume,
        "avg_price": avgPrice,
        "price_change_percent": priceChangePercent,
        "vol": vol,
      };
}
