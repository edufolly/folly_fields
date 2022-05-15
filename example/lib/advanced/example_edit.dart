import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/bool_field.dart';
import 'package:folly_fields/fields/cep_field.dart';
import 'package:folly_fields/fields/cest_field.dart';
import 'package:folly_fields/fields/cnae_field.dart';
import 'package:folly_fields/fields/cnpj_field.dart';
import 'package:folly_fields/fields/color_field.dart';
import 'package:folly_fields/fields/cpf_cnpj_field.dart';
import 'package:folly_fields/fields/cpf_field.dart';
import 'package:folly_fields/fields/date_field.dart';
import 'package:folly_fields/fields/date_time_field.dart';
import 'package:folly_fields/fields/decimal_field.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/email_field.dart';
import 'package:folly_fields/fields/integer_field.dart';
import 'package:folly_fields/fields/local_phone_field.dart';
import 'package:folly_fields/fields/mac_address_field.dart';
import 'package:folly_fields/fields/multiline_field.dart';
import 'package:folly_fields/fields/ncm_field.dart';
import 'package:folly_fields/fields/password_field.dart';
import 'package:folly_fields/fields/phone_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/fields/time_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/folly_validators.dart';
import 'package:folly_fields_example/advanced/example_builder.dart';
import 'package:folly_fields_example/advanced/example_consumer.dart';
import 'package:folly_fields_example/example_enum.dart';
import 'package:folly_fields_example/example_model.dart';
import 'package:google_fonts/google_fonts.dart';

///
///
///
class ExampleEdit extends AbstractEdit<ExampleModel, ExampleBuilder,
    ExampleConsumer, EmptyEditController<ExampleModel>> {
  ///
  ///
  ///
  const ExampleEdit(
    super.model,
    super.uiBuilder,
    super.consumer, {
    required super.edit,
    super.key,
  });

  ///
  ///
  ///
  @override
  List<Responsive> formContent(
    BuildContext context,
    ExampleModel model,
    String labelPrefix,
    Function(bool refresh) refresh,
    _,
    __, {
    required bool edit,
  }) {
    return <Responsive>[
      /// Texto
      StringField(
        labelPrefix: labelPrefix,
        label: 'Texto*',
        enabled: edit,
        initialValue: model.text,
        validator: (String? value) => value == null || value.isEmpty
            ? 'O campo texto precisa ser informado.'
            : null,
        onSaved: (String value) => model.text = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// E-mail
      EmailField(
        labelPrefix: labelPrefix,
        label: 'E-mail*',
        enabled: edit,
        initialValue: model.email,
        onSaved: (String value) => model.email = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Senha
      PasswordField(
        labelPrefix: labelPrefix,
        label: 'Senha*',
        enabled: edit,
        validator: (String? value) => value == null || value.isEmpty
            ? 'O campo senha precisa ser informado.'
            : null,
        onSaved: (String value) => model.password = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Decimal
      DecimalField(
        labelPrefix: labelPrefix,
        label: 'Decimal*',
        enabled: edit,
        initialValue: model.decimal,
        onSaved: (Decimal value) => model.decimal = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Integer
      IntegerField(
        labelPrefix: labelPrefix,
        label: 'Integer*',
        enabled: edit,
        initialValue: model.integer,
        onSaved: (int? value) => model.integer = value ?? 0,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// CPF
      CpfField(
        labelPrefix: labelPrefix,
        label: 'CPF*',
        enabled: edit,
        initialValue: model.cpf,
        onSaved: (String value) => model.cpf = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// CNPJ
      CnpjField(
        labelPrefix: labelPrefix,
        label: 'CNPJ*',
        enabled: edit,
        initialValue: model.cnpj,
        onSaved: (String value) => model.cnpj = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// CPF ou CNPJ
      CpfCnpjField(
        labelPrefix: labelPrefix,
        label: 'CPF ou CNPJ*',
        enabled: edit,
        initialValue: model.document,
        onSaved: (String value) => model.document = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Telefone
      PhoneField(
        labelPrefix: labelPrefix,
        label: 'Telefone*',
        enabled: edit,
        initialValue: model.phone,
        onSaved: (String value) => model.phone = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Telefone sem DDD
      LocalPhoneField(
        labelPrefix: labelPrefix,
        label: 'Telefone sem DDD*',
        enabled: edit,
        initialValue: model.localPhone,
        onSaved: (String value) => model.localPhone = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Data e Hora
      DateTimeField(
        labelPrefix: labelPrefix,
        label: 'Data e Hora*',
        enabled: edit,
        initialValue: model.dateTime,
        validator: (DateTime? value) =>
            value == null ? 'Informe uma data' : null,
        onSaved: (DateTime? value) => model.dateTime = value!,
        clearOnCancel: false,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Data
      DateField(
        labelPrefix: labelPrefix,
        label: 'Data*',
        enabled: edit,
        initialValue: model.date,
        onSaved: (DateTime? value) => model.date = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Hora
      TimeField(
        labelPrefix: labelPrefix,
        label: 'Hora*',
        enabled: edit,
        initialValue: model.time,
        validator: FollyValidators.notNull,
        onSaved: (TimeOfDay? value) => model.time = value!,
        clearOnCancel: false,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Mac Address
      MacAddressField(
        labelPrefix: labelPrefix,
        label: 'Mac Address*',
        enabled: edit,
        initialValue: model.macAddress,
        onSaved: (String? value) => model.macAddress = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Ncm
      NcmField(
        labelPrefix: labelPrefix,
        label: 'NCM*',
        enabled: edit,
        initialValue: model.ncm,
        onSaved: (String? value) => model.ncm = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Cest
      CestField(
        labelPrefix: labelPrefix,
        label: 'CEST*',
        enabled: edit,
        initialValue: model.cest,
        onSaved: (String? value) => model.cest = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Cnae
      CnaeField(
        labelPrefix: labelPrefix,
        label: 'CNAE*',
        enabled: edit,
        initialValue: model.cnae,
        onSaved: (String? value) => model.cnae = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// CEP
      CepField(
        labelPrefix: labelPrefix,
        label: 'CEP*',
        enabled: edit,
        initialValue: model.cep,
        onSaved: (String? value) => model.cep = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Bool
      BoolField(
        labelPrefix: labelPrefix,
        label: 'Campo Boleano',
        enabled: edit,
        initialValue: model.active,
        validator: (bool? value) => !(value ?? false)
            ? 'Para testes, este campo deve ser sempre verdadeiro.'
            : null,
        onSaved: (bool value) => model.active = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Color
      ColorField(
        labelPrefix: labelPrefix,
        label: 'Cor*',
        enabled: edit,
        initialValue: model.color,
        onSaved: (Color? value) => model.color = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Dropdown
      DropdownField<ExampleEnum>(
        labelPrefix: labelPrefix,
        label: 'Ordinal',
        enabled: edit,
        items: const ExampleEnumParser().items,
        initialValue: model.ordinal,
        validator: FollyValidators.notNull,
        onSaved: (ExampleEnum? value) => model.ordinal = value!,
        sizeMedium: 12,
        sizeLarge: 6,
      ),

      /// Multiline
      MultilineField(
        labelPrefix: labelPrefix,
        label: 'Multiline*',
        enabled: edit,
        initialValue: model.multiline,
        validator: (String value) =>
            value.isEmpty ? 'O campo multiline precisa ser informado.' : null,
        onSaved: (String value) => model.multiline = value,
        style: GoogleFonts.firaMono(
          textStyle: Theme.of(context).textTheme.bodyText2,
        ),
        sizeMedium: 12,
        sizeLarge: 6,
      ),
    ];
  }
}
