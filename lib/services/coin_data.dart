import 'dart:convert';
import 'package:bitcoin_ticker/models/crypto_currency.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String kApiKey = '';

class CoinData {
  Future<List<CryptoCurrency>> getCoinData(String currency) async {
    List<CryptoCurrency> l = [];

    for (String crypto in cryptoList) {
      String urlBase =
          'https://api.nomics.com/v1/currencies/ticker?key=$kApiKey&ids=$crypto&interval=1d,30d&convert=$currency';
      var response = await http.get(urlBase);
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
        l.add(CryptoCurrency(
            crypto: crypto, number: decoded[0]['price'], currency: currency));
      } else {
        print('Error : ${response.statusCode}');
      }
    }
    return l;
  }
}
