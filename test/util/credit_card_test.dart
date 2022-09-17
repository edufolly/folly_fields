// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/credit_card.dart';
import 'package:http/http.dart';

///
///
///
void main() async {
  int cardTest = 5;

  Map<String, CreditCardType> tests = <String, CreditCardType>{};

  Uri base = Uri.parse('https://www.invertexto.com/ajax/gerar-cartao.php');

  Map<CreditCardType, String> cardsRequest = <CreditCardType, String>{
    CreditCardType.mastercard: 'mastercard',
    CreditCardType.visa: 'visa16',
    CreditCardType.amex: 'amex',
    CreditCardType.dinersclub: 'diners',
    CreditCardType.unknown: 'voyager',
  };

  for (MapEntry<CreditCardType, String> entry in cardsRequest.entries) {
    try {
      for (int i = 0; i < cardTest; i++) {
        Response response = await post(
          base,
          body: <String, String>{
            'bandeira': entry.value,
          },
        );

        Map<String, dynamic> data = jsonDecode(response.body);
        String? ccNum = data['numero'];

        if (ccNum != null) {
          ccNum = ccNum.trim();
          print('Adding $ccNum to ${entry.key}');
          tests[ccNum] = entry.key;
        }
      }
    } on Exception catch (e, s) {
      print(e);
      print(s);
    }
  }

  group(
    'Credit card detect type',
    () {
      for (MapEntry<String, CreditCardType> entry in tests.entries) {
        test(
          'Testing ${entry.key}',
          () => expect(CreditCard.detectType(entry.key), entry.value),
        );
      }
    },
  );

  group('Credit card luhn check', () {
    for (MapEntry<String, CreditCardType> entry in tests.entries) {
      if (entry.value.luhnCheck) {
        test(
          'Testing ${entry.key}',
          () => expect(CreditCard.luhnCheck(entry.key), entry.value.luhnCheck),
        );
      }
    }
  });
}
