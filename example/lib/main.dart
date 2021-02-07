// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:folly_fields/fields/bool_field.dart';
import 'package:folly_fields/fields/cep_field.dart';
import 'package:folly_fields/fields/cnpj_field.dart';
import 'package:folly_fields/fields/cpf_field.dart';
import 'package:folly_fields/fields/cpj_cnpj_field.dart';
import 'package:folly_fields/fields/date_field.dart';
import 'package:folly_fields/fields/decimal_field.dart';
import 'package:folly_fields/fields/dropdown_field.dart';
import 'package:folly_fields/fields/email_field.dart';
import 'package:folly_fields/fields/icon_data_field.dart';
import 'package:folly_fields/fields/integer_field.dart';
import 'package:folly_fields/fields/local_phone_field.dart';
import 'package:folly_fields/fields/mac_address_field.dart';
import 'package:folly_fields/fields/ncm_field.dart';
import 'package:folly_fields/fields/password_field.dart';
import 'package:folly_fields/fields/phone_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/fields/time_field.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields_example/advanced/example_list.dart';
import 'package:folly_fields_example/config.dart';
import 'package:folly_fields_example/example_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

///
///
///
void main() {
  bool debug = false;

  assert(debug = true);

  WidgetsFlutterBinding.ensureInitialized();

  FollyFields.start(Config(), debug: debug);

  runApp(MyApp());
}

///
///
///
class MyApp extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Folly Fields Example',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('pt', 'BR'),
      ],
    );
  }
}

///
///
///
class MyHomePage extends StatefulWidget {
  ///
  ///
  ///
  MyHomePage({Key key}) : super(key: key);

  ///
  ///
  ///
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

///
///
///
class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Prefixo utilizado no label dos campos.
  /// O conteúdo está no arquivo de configurações.
  String prefix = Config().prefix;

  /// habilita ou desabilita os campos.
  bool edit = true;

  /// Modelo padrão para o exemplo.
  ExampleModel model = ExampleModel.generate();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folly Fields Example'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.github),
            onPressed: () async {
              const String url = 'https://github.com/edufolly/folly_fields';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                await FollyDialogs.dialogMessage(
                  context: context,
                  message: 'Não foi possível abrir $url',
                );
              }
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.list),
            onPressed: _showList,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // FutureDisappear(
              //   delay: Duration(seconds: 10),
              //   animationDuration: Duration(milliseconds: 600),
              //   child: Chip(
              //     label: Text(
              //       'Seja bem vindo à página de exemplos do Folly Fields.',
              //     ),
              //     backgroundColor:
              //         Theme.of(context).accentColor.withOpacity(0.8),
              //   ),
              // ),

              /// Título
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Formulário Básico',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FutureAppear(
              //     delay: Duration(seconds: 30),
              //     animationDuration: Duration(milliseconds: 800),
              //     child: Chip(
              //       label: Text(
              //         'Dificuldades em usar o Folly Fields? Entre em contato...',
              //       ),
              //       backgroundColor:
              //           Theme.of(context).accentColor.withOpacity(0.8),
              //     ),
              //   ),
              // ),

              /// Texto
              StringField(
                prefix: prefix,
                label: 'Texto*',
                enabled: edit,
                initialValue: model.text,
                validator: (String value) => value == null || value.isEmpty
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
                initialValue: model.password,
                validator: (String value) => value == null || value.isEmpty
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
                onSaved: (int value) => model.integer = value,
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

              /// Data
              DateField(
                prefix: prefix,
                label: 'Data*',
                enabled: edit,
                initialValue: model.date,
                onSaved: (DateTime value) => model.date = value,
              ),

              /// Hora
              TimeField(
                prefix: prefix,
                label: 'Hora*',
                enabled: edit,
                initialValue: model.time,
                onSaved: (TimeOfDay value) => model.time = value,
              ),

              /// Mac Address
              MacAddressField(
                prefix: prefix,
                label: 'Mac Address*',
                enabled: edit,
                initialValue: model.macAddress,
                onSaved: (String value) => model.macAddress = value,
              ),

              /// Ncm
              NcmField(
                prefix: prefix,
                label: 'NCM*',
                enabled: edit,
                initialValue: model.ncm,
                onSaved: (String value) => model.ncm = value,
              ),

              /// CEP
              CepField(
                prefix: prefix,
                label: 'CEP*',
                enabled: edit,
                initialValue: model.cep,
                onSaved: (String value) => model.cep = value,
              ),

              /// Bool
              BoolField(
                prefix: prefix,
                label: 'Campo Boleano',
                enabled: edit,
                initialValue: model.active,
                validator: (bool value) => !value
                    ? 'Para testes, este campo deve ser sempre verdadeiro.'
                    : null,
                onSaved: (bool value) => model.active = value,
              ),

              /// Ícone
              IconDataField(
                prefix: prefix,
                label: 'Ícone*',
                enabled: edit,
                icons: IconHelper.data,
                initialValue: model.icon,
                validator: (IconData iconData) =>
                    iconData == null ? 'Selecione um ícone' : null,
                onSaved: (IconData iconData) => model.icon = iconData,
              ),

              /// Dropdown
              DropdownField<Color>(
                prefix: prefix,
                label: 'Cor',
                enabled: edit,
                items: ExampleModel.colors,
                initialValue: model.color,
                validator: (Color value) =>
                    value == null ? 'Selecione uma cor.' : null,
                onSaved: (Color value) => model.color = value,
              ),

              /// Botão Enviar
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('ENVIAR'),
                  onPressed: _send,
                ),
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
  void _send() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print(model.toMap());

      FollyDialogs.dialogMessage(
        context: context,
        title: 'Resultado do método toMap()',
        message: model.toMap().toString(),
      );
    }
  }

  ///
  ///
  ///
  void _showList() => Navigator.of(context)
      .push(MaterialPageRoute<dynamic>(builder: (_) => ExampleList()));
}
