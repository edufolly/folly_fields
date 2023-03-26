import 'package:flutter/material.dart';
import 'package:folly_fields/fields/credit_card_code_field.dart';
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
class CreditCardChange {
  final CreditCardType creditCardType;
  final bool isValid;

  ///
  ///
  ///
  const CreditCardChange({required this.creditCardType, required this.isValid});

  ///
  ///
  ///
  CreditCardChange copy({CreditCardType? creditCardType, bool? isValid}) =>
      CreditCardChange(
        creditCardType: creditCardType ?? this.creditCardType,
        isValid: isValid ?? this.isValid,
      );
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
  State<CreditCard> createState() => _CreditCardState();
}

///
///
///
class _CreditCardState extends State<CreditCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CreditCardModel model = CreditCardModel();
  final ValueNotifier<CreditCardChange> _notifier =
      ValueNotifier<CreditCardChange>(
    const CreditCardChange(
      creditCardType: CreditCardType.unknown,
      isValid: false,
    ),
  );

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
                  onTypeChange: (CreditCardType ccType) => _notifier.value =
                      _notifier.value.copy(creditCardType: ccType),
                  onValid: (bool isValid) =>
                      _notifier.value = _notifier.value.copy(isValid: isValid),
                  onSaved: (String? value) => model.number = value,
                  suffix: ValueListenableBuilder<CreditCardChange>(
                    valueListenable: _notifier,
                    builder: (BuildContext context, CreditCardChange value, _) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          getIcon(
                            value.creditCardType,
                            Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          if (value.isValid)
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Icon(FontAwesomeIcons.check),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                CreditCardExpirationField(
                  label: 'Validade',
                  hintText: 'MM/AA',
                  initialValue: model.expiration,
                  sizeMedium: 6,
                  onSaved: (String? value) => model.expiration = value,
                ),
                ResponsiveValueListenableBuilder<CreditCardChange>(
                  valueListenable: _notifier,
                  sizeMedium: 6,
                  builder: (BuildContext context, CreditCardChange value, _) {
                    return CreditCardCodeField(
                      creditCardType: value.creditCardType,
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
  Icon getIcon(CreditCardType creditCardType, Color? color) {
    IconData iconData = FontAwesomeIcons.creditCard;

    // ignore: missing_enum_constant_in_switch
    switch (creditCardType) {
      case CreditCardType.visa:
        iconData = FontAwesomeIcons.ccVisa;
        break;
      case CreditCardType.mastercard:
        iconData = FontAwesomeIcons.ccMastercard;
        break;
      case CreditCardType.amex:
        iconData = FontAwesomeIcons.ccAmex;
        break;
      case CreditCardType.dinersclub:
        iconData = FontAwesomeIcons.ccDinersClub;
        break;
      case CreditCardType.discover:
        iconData = FontAwesomeIcons.ccDiscover;
        break;
      case CreditCardType.jcb:
        iconData = FontAwesomeIcons.ccJcb;
        break;
      case CreditCardType.unknown:
        iconData = FontAwesomeIcons.solidCreditCard;
        break;
    }

    return Icon(iconData, color: color);
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
