import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/crud/empty_edit_controller.dart';
import 'package:folly_fields/fields/bool_field.dart';
import 'package:folly_fields/fields/cep_field.dart';
import 'package:folly_fields/fields/cest_field.dart';
import 'package:folly_fields/fields/cnae_field.dart';
import 'package:folly_fields/fields/cnpj_field.dart';
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
import 'package:folly_fields_example/advanced/example_builder.dart';
import 'package:folly_fields_example/advanced/example_consumer.dart';
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
    ExampleModel model,
    ExampleBuilder uiBuilder,
    ExampleConsumer consumer,
    bool edit, {
    Key? key,
  }) : super(model, uiBuilder, consumer, edit, key: key);

  ///
  ///
  ///
  @override
  List<Responsive> formContent(
    BuildContext context,
    ExampleModel model,
    bool edit,
    String prefix,
    Function(bool refresh) refresh,
    _,
  ) {
    return <Responsive>[
      /// Texto
      StringField(
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
        label: 'Data e Hora*',
        enabled: edit,
        initialValue: model.dateTime,
        validator: (DateTime? value) =>
            value == null ? 'Informe uma data' : null,
        onSaved: (DateTime? value) => model.dateTime = value!,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Data
      DateField(
        prefix: prefix,
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
        prefix: prefix,
        label: 'Hora*',
        enabled: edit,
        initialValue: model.time,
        onSaved: (TimeOfDay? value) => model.time = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Mac Address
      MacAddressField(
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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
        prefix: prefix,
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

      /// Dropdown
      DropdownField<Color>(
        prefix: prefix,
        label: 'Cor',
        enabled: edit,
        items: ExampleModel.colors,
        initialValue: model.color,
        validator: (Color? value) =>
            value == null ? 'Selecione uma cor.' : null,
        onSaved: (Color? value) => model.color = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Multiline
      MultilineField(
        prefix: prefix,
        label: 'Multiline*',
        enabled: edit,
        initialValue: model.multiline,
        validator: (String value) =>
            value.isEmpty ? 'O campo multiline precisa ser informado.' : null,
        onSaved: (String value) => model.multiline = value,
        style: GoogleFonts.firaMono(),
      ),
    ];
  }
}
