class FormatedMarket {
  String id;
  String name;
  String baseUnit;
  String quoteUnit;
  String minPrice;
  String maxPrice;
  String priceInUsd;
  String minAmount;
  int amountPrecision;
  int pricePrecision;
  String state;

  bool isPositiveChange;

  String buy;
  String sell;
  double low;
  double high;
  double open;
  double last;
  double volume;
  String avgPrice;
  String priceChangePercent;
  String vol;
  bool isSparkLineLoading;
  List<double> sparkLineData;

  FormatedMarket(
      {this.id,
      this.name,
      this.baseUnit,
      this.quoteUnit,
      this.minPrice,
      this.maxPrice,
      this.priceInUsd,
      this.minAmount,
      this.amountPrecision,
      this.pricePrecision,
      this.state,
      this.isPositiveChange,
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
      this.isSparkLineLoading,
      this.sparkLineData});
}
