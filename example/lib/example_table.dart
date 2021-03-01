import 'package:flutter/material.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';
import 'package:folly_fields/validators/cpf_validator.dart';
import 'package:folly_fields/validators/phone_validator.dart';
import 'package:folly_fields/widgets/folly_table.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleTable extends StatefulWidget {
  ///
  ///
  ///
  @override
  _ExampleTableState createState() => _ExampleTableState();
}

///
///
///
class _ExampleTableState extends State<ExampleTable> {
  final List<ExampleModel> list = List<ExampleModel>.generate(
      50, (int index) => ExampleModel.generate(seed: index));

  final CpfValidator cpfValidator = CpfValidator();
  final CnpjValidator cnpjValidator = CnpjValidator();
  final PhoneValidator phoneValidator = PhoneValidator();

  final double rowHeight = 26.0;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FollyTable(
          rowsCount: list.length,
          headerHeight: rowHeight * 2.1,
          rowHeight: rowHeight,
          columnsSize: <double>[160.0, 250.0, 150.0, 200.0, 100.0, 150.0],
          headerColumns: <FollyCell>[
            FollyCell.textHeaderCenter('Text'),
            FollyCell.textHeaderCenter('E-mail'),
            FollyCell.textHeaderCenter('CPF'),
            FollyCell.textHeaderCenter('CNPJ'),
            FollyCell.textHeaderCenter('Decimal'),
            FollyCell.textHeaderCenter('Telefone'),
          ],
          cellBuilder: (int row, int col) {
            ExampleModel model = list[row];
            switch (col) {
              case 0:
                return FollyCell.text(model.text);
              case 1:
                return FollyCell.text(model.email);
              case 2:
                return FollyCell.text(cpfValidator.format(model.cpf));
              case 3:
                return FollyCell.text(cnpjValidator.format(model.cnpj));
              case 4:
                return FollyCell.number(model.decimal.value);
              case 5:
                return FollyCell.text(
                  phoneValidator.format(model.phone),
                  align: Alignment.center,
                  textAlign: TextAlign.center,
                );
              default:
                return FollyCell.text('ERRO: $row - $col');
            }
          },
        ),
      ),
    );
  }
}
