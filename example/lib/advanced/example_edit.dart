import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/fields/bool_field.dart';
import 'package:folly_fields/fields/cep_field.dart';
import 'package:folly_fields/fields/cest_field.dart';
import 'package:folly_fields/fields/cnae_field.dart';
import 'package:folly_fields/fields/cnpj_field.dart';
import 'package:folly_fields/fields/cpf_field.dart';
import 'package:folly_fields/fields/cpf_cnpj_field.dart';
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
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields_example/advanced/example_builder.dart';
import 'package:folly_fields_example/advanced/example_consumer.dart';
import 'package:folly_fields_example/example_model.dart';
import 'package:google_fonts/google_fonts.dart';

///
///
///
class ExampleEdit
    extends AbstractEdit<ExampleModel, ExampleBuilder, ExampleConsumer> {
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
  List<Widget> formContent(
    BuildContext context,
    ExampleModel model,
    bool edit,
    Map<String, dynamic> stateInjection,
    String prefix,
    Function(bool refresh) refresh,
  ) {
    return <Widget>[
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
      ),

      /// E-mail
      EmailField(
        prefix: prefix,
        label: 'E-mail*',
        enabled: edit,
        initialValue: model.email,
        onSaved: (String value) => model.email = value,
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
      ),

      /// Decimal
      DecimalField(
        prefix: prefix,
        label: 'Decimal*',
        enabled: edit,
        initialValue: model.decimal,
        onSaved: (Decimal value) => model.decimal = value,
      ),

      /// Integer
      IntegerField(
        prefix: prefix,
        label: 'Integer*',
        enabled: edit,
        initialValue: model.integer,
        onSaved: (int? value) => model.integer = value ?? 0,
      ),

      /// CPF
      CpfField(
        prefix: prefix,
        label: 'CPF*',
        enabled: edit,
        initialValue: model.cpf,
        onSaved: (String value) => model.cpf = value,
      ),

      /// CNPJ
      CnpjField(
        prefix: prefix,
        label: 'CNPJ*',
        enabled: edit,
        initialValue: model.cnpj,
        onSaved: (String value) => model.cnpj = value,
      ),

      /// CPF ou CNPJ
      CpfCnpjField(
        prefix: prefix,
        label: 'CPF ou CNPJ*',
        enabled: edit,
        initialValue: model.document,
        onSaved: (String value) => model.document = value,
      ),

      /// Telefone
      PhoneField(
        prefix: prefix,
        label: 'Telefone*',
        enabled: edit,
        initialValue: model.phone,
        onSaved: (String value) => model.phone = value,
      ),

      /// Telefone sem DDD
      LocalPhoneField(
        prefix: prefix,
        label: 'Telefone sem DDD*',
        enabled: edit,
        initialValue: model.localPhone,
        onSaved: (String value) => model.localPhone = value,
      ),

      /// Data e Hora
      DateTimeField(
        prefix: prefix,
        label: 'Data e Hora*',
        enabled: edit,
        initialValue: model.dateTime,
        required: true,
        onSaved: (DateTime? value) => model.dateTime = value,
      ),

      /// Data
      DateField(
        prefix: prefix,
        label: 'Data*',
        enabled: edit,
        initialValue: model.date,
        onSaved: (DateTime? value) => model.date = value,
      ),

      /// Hora
      TimeField(
        prefix: prefix,
        label: 'Hora*',
        enabled: edit,
        initialValue: model.time,
        onSaved: (TimeOfDay? value) => model.time = value,
      ),

      /// Mac Address
      MacAddressField(
        prefix: prefix,
        label: 'Mac Address*',
        enabled: edit,
        initialValue: model.macAddress,
        onSaved: (String? value) => model.macAddress = value,
      ),

      /// Ncm
      NcmField(
        prefix: prefix,
        label: 'NCM*',
        enabled: edit,
        initialValue: model.ncm,
        onSaved: (String? value) => model.ncm = value,
      ),

      /// Cest
      CestField(
        prefix: prefix,
        label: 'CEST*',
        enabled: edit,
        initialValue: model.cest,
        onSaved: (String? value) => model.cest = value,
      ),

      /// Cnae
      CnaeField(
        prefix: prefix,
        label: 'CNAE*',
        enabled: edit,
        initialValue: model.cnae,
        onSaved: (String? value) => model.cnae = value,
      ),

      /// CEP
      CepField(
        prefix: prefix,
        label: 'CEP*',
        enabled: edit,
        initialValue: model.cep,
        onSaved: (String? value) => model.cep = value,
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
