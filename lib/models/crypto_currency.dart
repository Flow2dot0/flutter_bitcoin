import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';

class CryptoCurrency {
  String crypto;
  String number;
  String currency;

  CryptoCurrency(
      {@required this.crypto, @required this.currency, this.number = '0'});

  void update({@required String nb, @required String curr}) {
    number = nb;
    currency = curr;
  }
}
