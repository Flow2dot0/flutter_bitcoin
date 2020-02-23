import 'package:bitcoin_ticker/models/crypto_currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/coin_data.dart';
import 'dart:io' show Platform;

import '../services/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  List<CryptoCurrency> list = [];

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> l = [];
    for (String currency in currenciesList) {
      DropdownMenuItem dmi = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );
      l.add(dmi);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: l,
        onChanged: (String v) {
          setState(() {
            selectedCurrency = v;
          });
          getCoinCurrency();
        });
  }

  CupertinoPicker iosPicker() {
    List<Text> l = [];
    for (String currency in currenciesList) {
      l.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (int sIndex) {
        setState(() {
          selectedCurrency = currenciesList[sIndex];
        });
        getCoinCurrency();
      },
      children: l,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  void getCoinCurrency() async {
    try {
      final List<CryptoCurrency> cryptoCurrList =
          await CoinData().getCoinData(selectedCurrency);
      setState(() {
        list = cryptoCurrList;
      });
    } catch (e) {
      print('Error : $e');
    }
  }

  Column generateCards() {
    List<CryptoCurrencyField> l = [];
    for (CryptoCurrency item in list) {
      l.add(CryptoCurrencyField(cryptoCurrency: item));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: l,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          generateCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCurrencyField extends StatelessWidget {
  CryptoCurrencyField({@required this.cryptoCurrency});

  final CryptoCurrency cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${cryptoCurrency.crypto} = ${cryptoCurrency.number} ${cryptoCurrency.currency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
