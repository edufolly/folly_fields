import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/fields/all_fields.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/util/safe_builder.dart';
import 'package:folly_fields/widgets/circular_waiting.dart';
import 'package:folly_fields/widgets/error_message.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields_example/code_link.dart';
import 'package:folly_fields_example/example_enum.dart';
import 'package:folly_fields_example/example_model.dart';
import 'package:folly_fields_example/models/font_awesome_model.dart';
import 'package:folly_fields_example/views/credit_card.dart';
import 'package:folly_fields_example/views/four_images.dart';
import 'package:folly_fields_example/widgets/bottom_sheet_grid_selection.dart';
import 'package:folly_fields_example/widgets/bottom_sheet_header.dart';
import 'package:folly_fields_example/widgets/icon_grid_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart' hide Config;
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'consumers/font_awesome_consumer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Folly Fields Example',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const MyHomePage(),
        '/four_images': (_) => const FourImages(),
        '/credit_card': (_) => const CreditCard(),
      },
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const githubUrl =
      'https://github.com/edufolly/folly_fields/blob/main/lib/fields';

  final _formKey = GlobalKey<FormState>();

  /// Modelo padrão para o exemplo.
  ExampleModel model = ExampleModel.generate();

  // ExampleModel model = ExampleModel();

  @override
  Widget build(context) {
    List<MyMenuItem> menuItems = [
      /// Github
      MyMenuItem(
        name: 'GitHub',
        iconData: FontAwesomeIcons.github,
        onPressed: (context) {
          CircularWaiting wait = CircularWaiting(context)..show();

          launchUrlString(
                'https://github.com/edufolly/folly_fields/',
                mode: LaunchMode.externalApplication,
              )
              .then((_) {
                Future<void>.delayed(const Duration(seconds: 2), wait.close);
              })
              .catchError((e, s) {
                debugPrintStack(label: e.toString(), stackTrace: s);
              });
        },
      ),

      /// Circular Waiting
      MyMenuItem(
        name: 'Circular Waiting',
        iconData: FontAwesomeIcons.spinner,
        onPressed: (context) {
          final wait = CircularWaiting(
            context,
            message: 'This is the main message.',
            subtitle: 'Wait 3 seconds...',
          )..show();

          Future<void>.delayed(const Duration(seconds: 3), wait.close);
        },
      ),

      /// Four Images
      MyMenuItem(
        name: 'Quatro Imagens',
        iconData: FontAwesomeIcons.image,
        onPressed: (context) => Navigator.of(context).pushNamed('/four_images'),
      ),

      MyMenuItem(
        name: 'Credit Card',
        iconData: FontAwesomeIcons.creditCard,
        onPressed: (context) => Navigator.of(context).pushNamed('/credit_card'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Folly Fields'),
        actions: [
          PopupMenuButton<MyMenuItem>(
            tooltip: 'Menu',
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            itemBuilder: (context) =>
                menuItems.map((e) => e.popupMenuItem).toList(),
            onSelected: (item) => item.onPressed(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SafeFutureBuilder<Response>(
          future: get(
            Uri.parse(
              'https://raw.githubusercontent.com/edufolly'
              '/folly_fields/main/example/lib/main.dart',
            ),
          ),
          builder: (context, response, _) {
            int statusCode = response.statusCode;
            if (statusCode < 200 || statusCode > 299) {
              return ErrorMessage(error: 'Status code error: $statusCode');
            }

            String code = response.body;

            final ThemeData theme = Theme.of(context);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Título
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Formulário Básico',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),

                    ListField<ExampleModel>(
                      label: 'Lista',
                      getLeading: (_, model, {required enabled}) => Icon(
                        Icons.circle,
                        color: !enabled
                            ? theme.disabledColor
                            : model.active
                            ? Colors.green
                            : Colors.red,
                      ),
                      getTitle: (_, model, {required enabled}) =>
                          Text(model.text ?? ''),
                      getSubtitle: (_, model, {required enabled}) =>
                          model.document?.let(Text.new),
                      initialValue: model.list,
                      addButtonLabel: 'Adicionar Exemplo',
                      addButtonIcon: FontAwesomeIcons.circlePlus,
                      addButtonOnTap: (context, data) async => List.of(data)
                        ..add(
                          ExampleModel.generate(
                            seed: DateTime.now().microsecond,
                          ),
                        ),
                      onSaved: (value) => model.list = value ?? [],
                    ),

                    // [RootCode]
                    CodeLink(
                      code: code,
                      tag: 'StringField',
                      source: '$githubUrl/string_field.dart',
                      child:
                          // [StringField]
                          StringField(
                            label: 'Texto',
                            initialValue: model.text,
                            onSaved: (value) => model.text = value,
                          ),
                      // [/StringField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'EmailField',
                      source: '$githubUrl/email_field.dart',
                      child:
                          // [EmailField]
                          EmailField(
                            label: 'E-mail',
                            required: false,
                            initialValue: model.email,
                            onSaved: (value) => model.email = value,
                          ),
                      // [/EmailField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'PasswordField',
                      source: '$githubUrl/password_field.dart',
                      child:
                          // [PasswordField]
                          PasswordField(
                            label: 'Senha',
                            onSaved: (value) => model.password = value,
                          ),
                      // [/PasswordField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'PasswordVisibleField',
                      source: '$githubUrl/password_visible_field.dart',
                      child:
                          // [PasswordVisibleField]
                          PasswordVisibleField(
                            label: 'Senha Visível',
                            onSaved: (value) => model.visiblePassword = value,
                          ),
                      // [/PasswordVisibleField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'DecimalField',
                      source: '$githubUrl/decimal_field.dart',
                      child:
                          // [DecimalField]
                          DecimalField(
                            label: 'Decimal',
                            initialValue: model.decimal,
                            onSaved: (value) => model.decimal = value!,
                          ),
                      // [/DecimalField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'IntegerField',
                      source: '$githubUrl/integer_field.dart',
                      child:
                          // [IntegerField]
                          IntegerField(
                            label: 'Integer',
                            initialValue: model.integer,
                            onSaved: (value) => model.integer = value,
                          ),
                      // [/IntegerField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'ColorField',
                      source: '$githubUrl/color_field.dart',
                      child:
                          // [ColorField]
                          ColorField(
                            label: 'Cor',
                            required: false,
                            initialValue: model.color,
                            onSaved: (value) => model.color = value,
                          ),
                      // [/ColorField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'CpfField',
                      source: '$githubUrl/cpf_field.dart',
                      child:
                          // [CpfField]
                          CpfField(
                            label: 'CPF',
                            required: false,
                            initialValue: model.cpf,
                            onSaved: (value) => model.cpf = value,
                          ),
                      // [/CpfField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'CnpjField',
                      source: '$githubUrl/cnpj_field.dart',
                      child:
                          // [CnpjField]
                          CnpjField(
                            label: 'CNPJ',
                            required: false,
                            initialValue: model.cnpj,
                            onSaved: (value) => model.cnpj = value,
                          ),
                      // [/CnpjField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'CpfCnpjField',
                      source: '$githubUrl/cpf_cnpj_field.dart',
                      child:
                          // [CpfCnpjField]
                          CpfCnpjField(
                            label: 'CPF ou CNPJ',
                            required: false,
                            initialValue: model.document,
                            onSaved: (value) => model.document = value,
                          ),
                      // [/CpfCnpjField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'PhoneField',
                      source: '$githubUrl/phone_field.dart',
                      child:
                          // [PhoneField]
                          PhoneField(
                            label: 'Telefone',
                            required: false,
                            initialValue: model.phone,
                            onSaved: (value) => model.phone = value,
                          ),
                      // [/PhoneField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'MobilePhoneField',
                      source: '$githubUrl/mobile_local_phone_field.dart',
                      child:
                          // [MobilePhoneField]
                          MobilePhoneField(
                            label: 'Celular',
                            required: false,
                            initialValue: model.mobilePhone,
                            onSaved: (value) => model.mobilePhone = value,
                          ),
                      // [/MobilePhoneField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'DateTimeField',
                      source: '$githubUrl/date_time_field.dart',
                      child:
                          // [DateTimeField]
                          DateTimeField(
                            label: 'Data e Hora',
                            required: false,
                            clearOnCancel: true,
                            initialValue: model.dateTime,
                            onSaved: (value) => model.dateTime = value,
                          ),
                      // [/DateTimeField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'DateField',
                      source: '$githubUrl/date_field.dart',
                      child:
                          // [DateField]
                          DateField(
                            label: 'Data',
                            required: false,
                            clearOnCancel: true,
                            initialValue: model.date,
                            onSaved: (value) => model.date = value,
                          ),
                      // [/DateField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'TimeField',
                      source: '$githubUrl/time_field.dart',
                      child:
                          // [TimeField]
                          TimeField(
                            label: 'Hora',
                            required: false,
                            clearOnCancel: true,
                            initialValue: model.time,
                            onSaved: (value) => model.time = value,
                          ),
                      // [/TimeField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'MacAddressField',
                      source: '$githubUrl/mac_address_field.dart',
                      child:
                          // [MacAddressField]
                          MacAddressField(
                            label: 'Mac Address',
                            required: false,
                            initialValue: model.macAddress,
                            onSaved: (value) => model.macAddress = value,
                          ),
                      // [/MacAddressField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'NcmField',
                      source: '$githubUrl/ncm_field.dart',
                      child:
                          // [NcmField]
                          NcmField(
                            label: 'NCM',
                            required: false,
                            initialValue: model.ncm,
                            onSaved: (value) => model.ncm = value,
                          ),
                      // [/NcmField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'CestField',
                      source: '$githubUrl/cest_field.dart',
                      child:
                          // [CestField]
                          CestField(
                            label: 'CEST',
                            required: false,
                            initialValue: model.cest,
                            onSaved: (value) => model.cest = value,
                          ),
                      // [/CestField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'CnaeField',
                      source: '$githubUrl/cnae_field.dart',
                      child:
                          // [CnaeField]
                          CnaeField(
                            required: false,
                            label: 'CNAE',
                            initialValue: model.cnae,
                            onSaved: (value) => model.cnae = value,
                          ),
                      // [/CnaeField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'CepField',
                      source: '$githubUrl/cep_field.dart',
                      child:
                          // [CepField]
                          CepField(
                            label: 'CEP',
                            required: false,
                            initialValue: model.cep,
                            onSaved: (value) => model.cep = value,
                          ),
                      // [/CepField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'LicencePlateField',
                      source: '$githubUrl/licence_plate_field.dart',
                      child:
                          // [LicencePlateField]
                          LicencePlateField(
                            label: 'Placa de Veiculo',
                            required: false,
                            initialValue: model.licencePlate,
                            onSaved: (value) => model.licencePlate = value,
                          ),
                      // [/LicencePlateField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'Ipv4Field',
                      source: '$githubUrl/ipv4_field.dart',
                      child:
                          // [Ipv4Field]
                          Ipv4Field(
                            label: 'IPv4',
                            required: false,
                            initialValue: model.ipv4,
                            onSaved: (value) => model.ipv4 = value,
                          ),
                      // [/Ipv4Field]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'BoolField',
                      source: '$githubUrl/bool_field.dart',
                      child:
                          // [BoolField]
                          BoolField(
                            label: 'Campo Boleano',
                            initialValue: model.active,
                            onSaved: (value) => model.active = value,
                          ),
                      // [/BoolField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'IconDataField',
                      source: '$githubUrl/icon_data_field.dart',
                      child:
                          // [IconDataField]
                          IconDataField(
                            label: 'Ícone',
                            clearOnCancel: true,
                            initialValue: model.icon,
                            iconLabel: (value) =>
                                IconHelper.iconName(value) ?? '',
                            selection: (context, value) async {
                              final list =
                                  await showModalBottomSheet<
                                    List<FontAwesomeModel>
                                  >(
                                    context: context,
                                    builder: (context) {
                                      return BottomSheetGridSelection<
                                        FontAwesomeModel,
                                        String
                                      >(
                                        selection: [
                                          if (isNotNull(value))
                                            FontAwesomeModel(
                                              id: IconHelper.iconName(value),
                                              iconData: value,
                                            ),
                                        ],
                                        multiple: false,
                                        title: BottomSheetHeader(
                                          'Selecionar Ícone',
                                        ),
                                        itemBuilder: (context, model) =>
                                            IconGridItem(model: model),
                                        list: FontAwesomeConsumer.list,
                                      );
                                    },
                                  );

                              if (list?.isEmpty ?? true) return null;

                              return list?.first.iconData;
                            },
                            onSaved: (value) => model.icon = value,
                          ),
                      // [/IconDataField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'DropdownField',
                      source: '$githubUrl/dropdown_field.dart',
                      child:
                          // [DropdownField]
                          DropdownField<ExampleEnum, Widget>(
                            label: 'Ordinal',
                            items: ExampleEnum.values.asMap().map((
                              _,
                              ExampleEnum value,
                            ) {
                              return MapEntry(value, Text(value.value));
                            }),
                            initialValue: model.ordinal,
                            onSaved: (value) => model.ordinal = value,
                          ),
                      // [/DropdownField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'MultilineField',
                      source: '$githubUrl/multiline_field.dart',
                      child:
                          // [MultilineField]
                          MultilineField(
                            style: GoogleFonts.firaMono(),
                            label: 'Multiline',
                            counterText: null,
                            maxLength: 600,
                            initialValue: model.multiline,
                            onSaved: (value) => model.multiline = value,
                          ),
                      // [/MultilineField]
                    ),

                    CodeLink(
                      code: code,
                      tag: 'ChoiceChipField',
                      source: '$githubUrl/choice_chip_field.dart',
                      child:
                          // [ChoiceChipField]
                          ChoiceChipField<int>(
                            label: 'Frutas',
                            items: const {
                              0: ChipEntry(
                                '🍎Maça',
                                color: Colors.red,
                                selectedColor: Colors.redAccent,
                              ),
                              1: ChipEntry(
                                '🍌Banana',
                                color: Colors.yellow,
                                selectedColor: Colors.yellowAccent,
                              ),
                              2: ChipEntry(
                                '🍊Tangerina',
                                color: Colors.orange,
                                selectedColor: Colors.orangeAccent,
                              ),
                            },
                            onChanged: (value, {required selected}) =>
                                debugPrint(
                                  'ChoiceChipField $value is'
                                  '${selected ? '' : ' NOT'} selected',
                                ),
                            onSaved: (value) => model.fruitIndex = value?.first,
                          ),
                      // [/ChoiceChipField]
                    ),

                    // [/RootCode]

                    /// Botão Enviar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      child: FilledButton.icon(
                        icon: const Icon(Icons.send),
                        label: const Text('ENVIAR'),
                        onPressed: _send,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _send() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      FollyDialogs.dialogMessage(
        context: context,
        title: 'Result of toMap().',
        message: model
            .toMap()
            .entries
            .map((it) => '${it.key}: ${it.value}')
            .join(',\n'),
      );
    }
  }
}

class MyMenuItem {
  final String name;
  final IconData iconData;
  final Function(BuildContext context) onPressed;

  MyMenuItem({
    required this.name,
    required this.iconData,
    required this.onPressed,
  });

  PopupMenuItem<MyMenuItem> get popupMenuItem => PopupMenuItem<MyMenuItem>(
    value: this,
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(iconData),
        ),
        Text(name),
      ],
    ),
  );
}
