import 'package:flutter/material.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';
import 'package:folly_fields/validators/cpf_validator.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';
import 'package:folly_fields/validators/phone_validator.dart';
import 'package:folly_fields/widgets/folly_cell.dart';
import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:folly_fields/widgets/folly_table.dart';
import 'package:folly_fields_example/advanced/example_builder.dart';
import 'package:folly_fields_example/advanced/example_consumer.dart';
import 'package:folly_fields_example/advanced/example_edit.dart';
import 'package:folly_fields_example/example_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

///
///
///
class ExampleTable extends StatefulWidget {
  ///
  ///
  ///
  const ExampleTable({super.key});

  ///
  ///
  ///
  @override
  ExampleTableState createState() => ExampleTableState();
}

///
///
///
class ExampleTableState extends State<ExampleTable> {
  final List<ExampleModel> list = List<ExampleModel>.generate(
    50,
    (int index) => ExampleModel.generate(seed: index),
  );

  final CpfValidator cpfValidator = CpfValidator();
  final CnpjValidator cnpjValidator = CnpjValidator();
  final PhoneValidator phoneValidator = PhoneValidator();
  final MacAddressValidator macAddressValidator = MacAddressValidator();

  final double rowHeight = 26;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabela'),
        actions: <Widget>[
          /// Github
          IconButton(
            icon: const Icon(FontAwesomeIcons.github),
            onPressed: () async {
              const String url = 'https://github.com/edufolly/folly_fields/'
                  'blob/main/example/lib/example_table.dart';
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              } else {
                await FollyDialogs.dialogMessage(
                  context: context,
                  message: 'Não foi possível abrir $url',
                );
              }
            },
            tooltip: 'Github',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // ignore: deprecated_member_use
        child: FollyTable(
          rowsCount: list.length,
          headerHeight: rowHeight,
          rowHeight: rowHeight,
          freezeColumns: 2,
          columnBuilders: <FollyTableColumnBuilder>[
            /// Text
            FollyTableColumnBuilder(
              width: 160,
              header: FollyCell.textHeaderCenter('Text'),
              builder: (int row) => FollyCell.text(list[row].text),
            ),

            /// E-mail
            FollyTableColumnBuilder(
              width: 230,
              header: FollyCell.textHeaderCenter('E-mail'),
              builder: (int row) => FollyCell.text(list[row].email),
            ),

            /// CPF
            FollyTableColumnBuilder(
              width: 150,
              header: FollyCell.textHeaderCenter('CPF'),
              builder: (int row) => FollyCell.textCenter(
                cpfValidator.format(list[row].cpf),
              ),
            ),

            /// CNPJ
            FollyTableColumnBuilder(
              width: 200,
              header: FollyCell.textHeaderCenter('CNPJ'),
              builder: (int row) => FollyCell.textCenter(
                cnpjValidator.format(list[row].cnpj),
              ),
            ),
          ],
          onRowTap: (int row) => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ExampleEdit(
                list[row],
                const ExampleBuilder(),
                const ExampleConsumer(),
                edit: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
