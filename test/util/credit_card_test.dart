// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/credit_card.dart';
import 'package:http/http.dart';

///
///
///
void main() async {
  int cardTest = 5;

  Map<String, CreditCardType> tests = <String, CreditCardType>{};

  Uri base = Uri.parse('https://www.4devs.com.br/ferramentas_online.php');

  RegExp reg = RegExp(r'<.*cartao_numero.*>([\d|\s]*)'
      '<span class="clipboard-copy"></span></div>');

  Map<CreditCardType, String> cardsRequest = <CreditCardType, String>{
    CreditCardType.mastercard: 'master',
    CreditCardType.visa: 'visa16',
    CreditCardType.amex: 'amex',
    CreditCardType.dinersclub: 'diners',
    CreditCardType.unknown: 'aura',
  };

  for (MapEntry<CreditCardType, String> entry in cardsRequest.entries) {
    try {
      for (int i = 0; i < cardTest; i++) {
        Response response = await post(
          base,
          body: <String, String>{
            'acao': 'gerar_cc',
            'pontuacao': 'S',
            'bandeira': entry.value,
          },
        );

        String? ccNum = reg.firstMatch(response.body)?.group(1);

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
}
