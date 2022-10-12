// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:http/http.dart';

///
///
///
void main() async {
  int cardTest = 5;

  Map<String, CreditCardType> tests = <String, CreditCardType>{};

  Uri base = Uri.parse('https://www.invertexto.com/ajax/gerar-cartao.php');

  Map<String, CreditCardType> cardsRequest = <String, CreditCardType>{
    'mastercard': CreditCardType.mastercard,
    'visa16': CreditCardType.visa,
    'visa13': CreditCardType.visa,
    'amex': CreditCardType.amex,
    'diners': CreditCardType.dinersclub,
    'voyager': CreditCardType.unknown,
  };

  for (MapEntry<String, CreditCardType> entry in cardsRequest.entries) {
    try {
      for (int i = 0; i < cardTest; i++) {
        Response response = await post(
          base,
          body: <String, String>{
            'bandeira': entry.key,
          },
        );

        Map<String, dynamic> data = jsonDecode(response.body);
        String? ccNum = data['numero'];

        if (ccNum != null) {
          ccNum = ccNum.trim();
          tests[ccNum] = entry.value;
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
          'Testing "${entry.key}" for ${entry.value}',
          () => expect(CreditCardType.detectType(entry.key), entry.value),
        );
      }
    },
  );

  group(
    'Credit card luhn check',
    () {
      for (MapEntry<String, CreditCardType> entry in tests.entries) {
        test(
          'Testing "${entry.key}"',
          () => expect(entry.value.validNumber(entry.key), true),
        );
      }
    },
  );

  Map<String, bool> cvvFailTests = <String, bool>{
    '': false,
    '  ': false,
    '   ': false,
    '    ': false,
    'A': false,
    'A ': false,
    'AA': false,
    'AA ': false,
    'AAA': false,
    'AAA ': false,
    'AAAA': false,
    'AAAA ': false,
    'AAAAA': false,
    'AAAAA ': false,
    '!': false,
    '! ': false,
    '!!': false,
    '!! ': false,
    '!!!': false,
    '!!! ': false,
    '!!!!': false,
    '!!!! ': false,
    '!!!!!': false,
    '!!!!! ': false,
    '1': false,
    '1 ': false,
    '11': false,
    '11 ': false,
    '1111 ': false,
    '11111': false,
    '*': false,
    '**': false,
    '** ': false,
    ' * ': false,
    ' **': false,
    ' * *': false,
  };

  Map<String, bool> cvvMasterTests = <String, bool>{
    ...cvvFailTests,
    '111 ': false,
    '234': true,
    '2345': false,
  };

  group(
    'Credit card CVV check for Mastercard',
    () {
      for (MapEntry<String, bool> entry in cvvMasterTests.entries) {
        test(
          'Testing "${entry.key}"',
          () => expect(
            CreditCardType.mastercard.cvvCheck(entry.key),
            entry.value,
          ),
        );
      }
    },
  );

  Map<String, bool> cvvAmexTests = <String, bool>{
    ...cvvFailTests,
    '111 ': false,
    '234': false,
    '2345': true,
  };

  group(
    'Credit card CVV check for American Express',
    () {
      for (MapEntry<String, bool> entry in cvvAmexTests.entries) {
        test(
          'Testing "${entry.key}"',
          () => expect(
            CreditCardType.amex.cvvCheck(entry.key),
            entry.value,
          ),
        );
      }
    },
  );

  Map<String, bool> cvvUnknownTests = <String, bool>{
    ...cvvFailTests,
    '111 ': true,
    '234': true,
    '2345': true,
  };

  group(
    'Credit card CVV check for Unknown',
    () {
      for (MapEntry<String, bool> entry in cvvUnknownTests.entries) {
        test(
          'Testing "${entry.key}"',
          () => expect(
            CreditCardType.unknown.cvvCheck(entry.key),
            entry.value,
          ),
        );
      }
    },
  );

  Map<String?, CreditCardType> typeTests = <String?, CreditCardType>{
    null: CreditCardType.unknown,
    '': CreditCardType.unknown,
    ' ': CreditCardType.unknown,
    'unknown': CreditCardType.unknown,
    'a': CreditCardType.unknown,
    '1': CreditCardType.unknown,
    'Mastercard': CreditCardType.mastercard,
    'mastercard': CreditCardType.mastercard,
    'MASTERCARD': CreditCardType.mastercard,
    'Master card': CreditCardType.mastercard,
    'Master Card': CreditCardType.mastercard,
    'master card': CreditCardType.mastercard,
    'MASTER CARD': CreditCardType.mastercard,
    'master': CreditCardType.mastercard,
    ' master ': CreditCardType.mastercard,
    ' master': CreditCardType.mastercard,
    'master ': CreditCardType.mastercard,
    'Master': CreditCardType.mastercard,
    'MASTER': CreditCardType.mastercard,
    'M4ST3R': CreditCardType.unknown,
    'visa': CreditCardType.visa,
    'VISA': CreditCardType.visa,
    'Visa': CreditCardType.visa,
    'V1S4': CreditCardType.unknown,
    'Amex': CreditCardType.amex,
    'amex': CreditCardType.amex,
    'AMEX': CreditCardType.amex,
    'American Express': CreditCardType.amex,
    'American express': CreditCardType.amex,
    'american express': CreditCardType.amex,
    'AmericanExpress': CreditCardType.amex,
    'Americanexpress': CreditCardType.amex,
    'americanexpress': CreditCardType.amex,
    'americanExpress': CreditCardType.amex,
    '4M3X': CreditCardType.unknown,
    'Diners': CreditCardType.dinersclub,
    'diners': CreditCardType.dinersclub,
    'DINERS': CreditCardType.dinersclub,
    'Diners Club': CreditCardType.dinersclub,
    'Diners club': CreditCardType.dinersclub,
    'diners club': CreditCardType.dinersclub,
    'DinersClub': CreditCardType.dinersclub,
    'Dinersclub': CreditCardType.dinersclub,
    'dinersclub': CreditCardType.dinersclub,
  };

  /*
  discover(
    brand: 'Discover',

  jcb(
    brand: 'JCB',

  unionpay(
    brand: 'UnionPay',

  maestro(
    brand: 'Maestro',

  elo(
    brand: 'Elo',

  mir(
    brand: 'Mir',

  hiper(
    brand: 'Hiper',

  hipercard(
    brand: 'Hipercard',
   */


  group(
    'Credit card type parse check',
    () {
      for (MapEntry<String?, CreditCardType> entry in typeTests.entries) {
        test(
          'Testing "${entry.key}"',
          () => expect(
            CreditCardType.parse(entry.key),
            entry.value,
          ),
        );
      }
    },
  );
}
