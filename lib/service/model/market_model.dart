class CryptoCurrencyModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  double? high24;
  double? low24;
  double? priceChange24;
  double? priceChangePercentage24;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool isFavourite = false;

  CryptoCurrencyModel(
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.high24,
    this.low24,
    this.priceChange24,
    this.priceChangePercentage24,
    this.circulatingSupply,
    this.ath,
    this.atl,
  );

  factory CryptoCurrencyModel.fromJSON(Map<String, dynamic> map) {
    return CryptoCurrencyModel(
      map['id'],
      map['symbol'],
      map['name'],
      map['image'],
      double.parse(map['current_price'].toString()),
      double.parse(map['market_cap'].toString()),
      double.parse(map['high_24h'].toString()),
      double.parse(map['low_24h'].toString()),
      double.parse(map['price_change_24h'].toString()),
      double.parse(map['price_change_percentage_24h'].toString()),
      double.parse(map['circulating_supply'].toString()),
      double.parse(map['ath'].toString()),
      double.parse(map['atl'].toString()),
    );
  }
}
