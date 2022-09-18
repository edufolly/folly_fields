import 'package:flutter/material.dart';
import 'package:folly_fields/fields/credit_card_cvv_field.dart';
import 'package:folly_fields/fields/credit_card_expiration_field.dart';
import 'package:folly_fields/fields/credit_card_number_field.dart';
import 'package:folly_fields/fields/uppercase_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';
import 'package:folly_fields/responsive/responsive_value_listenable_builder.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:folly_fields/util/folly_validators.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class CreditCardModel {
  String? number;
  String? expiration;
  String? code;
  String? holder;

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['number'] = number;
    map['expiration'] = expiration;
    map['code'] = code;
    map['holder'] = holder;
    return map;
  }
}

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<CreditCardType> _notifier =
      ValueNotifier<CreditCardType>(CreditCardType.unknown);
  final CreditCardModel model = CreditCardModel();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card'),
        actions: <Widget>[
          IconButton(
            onPressed: _save,
            icon: const Icon(FontAwesomeIcons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ResponsiveGrid(
              children: <Responsive>[
                CreditCardNumberField(
                  label: 'Número do Cartão',
                  initialValue: model.number,
                  sizeMedium: 12,
                  onTypeChange: (CreditCardType ccType) =>
                      _notifier.value = ccType,
                  onSaved: (String? value) => model.number = value,
                ),
                CreditCardExpirationField(
                  label: 'Validade',
                  hintText: 'MM/AA',
                  initialValue: model.expiration,
                  sizeMedium: 6,
                  onSaved: (String? value) => model.expiration = value,
                ),
                ResponsiveValueListenableBuilder<CreditCardType>(
                  valueListenable: _notifier,
                  sizeMedium: 6,
                  builder: (BuildContext context, CreditCardType value, _) {
                    return CreditCardCodeField(
                      creditCardType: value,
                      initialValue: model.code,
                      onSaved: (String? value) => model.code = value,
                    );
                  },
                ),
                UppercaseField(
                  label: 'Nome do Titular',
                  initialValue: model.holder,
                  validator: FollyValidators.stringNullNotEmpty,
                  sizeMedium: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FollyDialogs.dialogMessage(
        context: context,
        title: 'Sucesso',
        message: model.toMap().toString(),
      );
    }
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
