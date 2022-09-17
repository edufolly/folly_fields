import 'package:flutter/material.dart';
import 'package:folly_fields/fields/credit_card_cvv_field.dart';
import 'package:folly_fields/fields/credit_card_number_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';
import 'package:folly_fields/responsive/responsive_value_listenable_builder.dart';

import 'package:folly_fields/util/credit_card_type.dart';

///
///
///
class CreditCard extends StatefulWidget {
  ///
  ///
  ///
  const CreditCard({super.key});

  ///
  ///
  ///
  @override
  _CreditCardState createState() => _CreditCardState();
}

///
///
///
class _CreditCardState extends State<CreditCard> {
  final ValueNotifier<CreditCardType> _notifier =
      ValueNotifier<CreditCardType>(CreditCardType.unknown);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ResponsiveGrid(
            children: <Responsive>[
              CreditCardNumberField(
                onTypeChange: (CreditCardType ccType) =>
                    _notifier.value = ccType,
                sizeMedium: 6,
              ),
              ResponsiveValueListenableBuilder<CreditCardType>(
                valueListenable: _notifier,
                sizeMedium: 6,
                builder: (BuildContext context, CreditCardType value, _) {
                  return CreditCardCodeField(
                    creditCardType: value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}
