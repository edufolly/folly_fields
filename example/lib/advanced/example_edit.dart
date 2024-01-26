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
import 'package:folly_fields/fields/ipv4_field.dart';
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
    ExampleConsumer, EmptyEditController<ExampleModel, int>, int> {
  ///
  ///
  ///
  const ExampleEdit(
    super.model,
    super.builder,
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
    ExampleModel model, {
    required bool edit,
    bool Function()? formValidate,
    void Function({required bool refresh})? refresh,
  }) {
    return <Responsive>[
      /// Texto
      StringField(
        labelPrefix: builder.labelPrefix,
        label: 'Texto*',
        enabled: edit,
        initialValue: model.text,
        validator: (String? value) => (value?.isEmpty ?? true)
            ? 'O campo texto precisa ser informado.'
            : null,
        onSaved: (String? value) => model.text = value ?? '',
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// E-mail
      EmailField(
        labelPrefix: builder.labelPrefix,
        label: 'E-mail*',
        enabled: edit,
        initialValue: model.email,
        onSaved: (String? value) => model.email = value ?? '',
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Senha
      PasswordField(
        labelPrefix: builder.labelPrefix,
        label: 'Senha*',
        enabled: edit,
        validator: (String? value) => (value?.isEmpty ?? true)
            ? 'O campo senha precisa ser informado.'
            : null,
        onSaved: (String? value) => model.password = value ?? '',
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Decimal
      DecimalField(
        labelPrefix: builder.labelPrefix,
        label: 'Decimal*',
        enabled: edit,
        initialValue: model.decimal,
        onSaved: (Decimal? value) => model.decimal = value!,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Integer
      IntegerField(
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
        label: 'CPF*',
        enabled: edit,
        initialValue: model.cpf,
        onSaved: (String? value) => model.cpf = value!,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// CNPJ
      CnpjField(
        labelPrefix: builder.labelPrefix,
        label: 'CNPJ*',
        enabled: edit,
        initialValue: model.cnpj,
        onSaved: (String? value) => model.cnpj = value!,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// CPF ou CNPJ
      CpfCnpjField(
        labelPrefix: builder.labelPrefix,
        label: 'CPF ou CNPJ*',
        enabled: edit,
        initialValue: model.document,
        onSaved: (String? value) => model.document = value!,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Telefone
      PhoneField(
        labelPrefix: builder.labelPrefix,
        label: 'Telefone*',
        enabled: edit,
        initialValue: model.phone,
        onSaved: (String? value) => model.phone = value ?? '',
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Telefone sem DDD
      LocalPhoneField(
        labelPrefix: builder.labelPrefix,
        label: 'Telefone sem DDD*',
        enabled: edit,
        initialValue: model.localPhone,
        onSaved: (String? value) => model.localPhone = value ?? '',
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Data e Hora
      DateTimeField(
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
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
        labelPrefix: builder.labelPrefix,
        label: 'Cor*',
        enabled: edit,
        initialValue: model.color,
        onSaved: (Color? value) => model.color = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// IPv4
      Ipv4Field(
        labelPrefix: builder.labelPrefix,
        label: 'IPv4*',
        enabled: edit,
        initialValue: model.ipv4,
        onSaved: (String? value) => model.ipv4 = value,
        sizeSmall: 12,
        sizeMedium: 6,
        sizeLarge: 4,
        sizeExtraLarge: 3,
      ),

      /// Dropdown
      DropdownField<ExampleEnum, Widget>(
        labelPrefix: builder.labelPrefix,
        label: 'Ordinal',
        enabled: edit,
        items: ExampleEnum.values.asMap().map(
              (_, ExampleEnum value) =>
                  MapEntry<ExampleEnum, Widget>(value, Text(value.value)),
            ),
        initialValue: model.ordinal,
        validator: FollyValidators.notNull,
        onSaved: (ExampleEnum? value) => model.ordinal = value!,
        sizeMedium: 12,
        sizeLarge: 6,
      ),

      /// Multiline
      MultilineField(
        labelPrefix: builder.labelPrefix,
        label: 'Multiline*',
        enabled: edit,
        initialValue: model.multiline,
        validator: (String? value) => value == null || value.isEmpty
            ? 'O campo multiline precisa ser informado.'
            : null,
        onSaved: (String? value) => model.multiline = value ?? '',
        style: GoogleFonts.firaMono(
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        sizeMedium: 12,
        sizeLarge: 6,
      ),
    ];
  }
}
