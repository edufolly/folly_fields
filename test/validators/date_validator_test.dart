// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/date_validator.dart';
import 'package:intl/date_symbol_data_local.dart';

///
///
///
void main() {
  const String format = 'dd/MM/yyyy';
  const String locale = 'pt_br';
  const String mask = '##/##/####';

  initializeDateFormatting(locale);

  DateValidator validator = DateValidator(
    format: format,
    locale: locale,
    mask: mask,
  );

  Map<String, bool> isValidTests = <String, bool>{
    '': false,
    '00': false,
    '00-00-00': false,
    '01/01/00': false,
    '01/01/0000': true,
    '00/01/0000': false,
    '01/00/0000': false,
    '00/00/0000': false,
    '01/01/00000': false,
    '00/01/2000': false,

    /// Invalid Month - 2000
    '00/00/2000': false,
    '01/00/2000': false,
    '02/00/2000': false,
    '29/00/2000': false,
    '30/00/2000': false,
    '31/00/2000': false,
    '32/00/2000': false,

    /// Jan - 2000
    '01/01/2000': true,
    '02/01/2000': true,
    '29/01/2000': true,
    '30/01/2000': true,
    '31/01/2000': true,
    '32/01/2000': false,

    /// Fev - 2000
    '00/02/2000': false,
    '01/02/2000': true,
    '02/02/2000': true,
    '28/02/2000': true,
    '29/02/2000': true,
    '30/02/2000': false,

    /// Mar - 2000
    '00/03/2000': false,
    '01/03/2000': true,
    '02/03/2000': true,
    '29/03/2000': true,
    '30/03/2000': true,
    '31/03/2000': true,
    '32/03/2000': false,

    /// Abr - 2000
    '00/04/2000': false,
    '01/04/2000': true,
    '02/04/2000': true,
    '29/04/2000': true,
    '30/04/2000': true,
    '31/04/2000': false,
    '32/04/2000': false,

    /// Mai - 2000
    '00/05/2000': false,
    '01/05/2000': true,
    '02/05/2000': true,
    '29/05/2000': true,
    '30/05/2000': true,
    '31/05/2000': true,
    '32/05/2000': false,

    /// Jun - 2000
    '00/06/2000': false,
    '01/06/2000': true,
    '02/06/2000': true,
    '29/06/2000': true,
    '30/06/2000': true,
    '31/06/2000': false,
    '32/06/2000': false,

    /// Jul - 2000
    '00/07/2000': false,
    '01/07/2000': true,
    '02/07/2000': true,
    '29/07/2000': true,
    '30/07/2000': true,
    '31/07/2000': true,
    '32/07/2000': false,

    /// Ago - 2000
    '00/08/2000': false,
    '01/08/2000': true,
    '02/08/2000': true,
    '29/08/2000': true,
    '30/08/2000': true,
    '31/08/2000': true,
    '32/08/2000': false,

    /// Set - 2000
    '00/09/2000': false,
    '01/09/2000': true,
    '02/09/2000': true,
    '29/09/2000': true,
    '30/09/2000': true,
    '31/09/2000': false,
    '32/09/2000': false,

    /// Out - 2000
    '00/10/2000': false,
    '01/10/2000': true,
    '02/10/2000': true,
    '29/10/2000': true,
    '30/10/2000': true,
    '31/10/2000': true,
    '32/10/2000': false,

    /// Nov - 2000
    '00/11/2000': false,
    '01/11/2000': true,
    '02/11/2000': true,
    '29/11/2000': true,
    '30/11/2000': true,
    '31/11/2000': false,
    '32/11/2000': false,

    /// Dez - 2000
    '00/12/2000': false,
    '01/12/2000': true,
    '02/12/2000': true,
    '29/12/2000': true,
    '30/12/2000': true,
    '31/12/2000': true,
    '32/12/2000': false,

    /// Invalid Month - 2000
    '00/13/2000': false,
    '01/13/2000': false,
    '02/13/2000': false,
    '29/13/2000': false,
    '30/13/2000': false,
    '31/13/2000': false,
    '32/13/2000': false,

    /// Fev - 2001
    '00/02/2001': false,
    '01/02/2001': true,
    '02/02/2001': true,
    '28/02/2001': true,
    '29/02/2001': false,
    '30/02/2001': false,

    /// Fev - 2002
    '00/02/2002': false,
    '01/02/2002': true,
    '02/02/2002': true,
    '28/02/2002': true,
    '29/02/2002': false,
    '30/02/2002': false,

    /// Fev - 2003
    '00/02/2003': false,
    '01/02/2003': true,
    '02/02/2003': true,
    '28/02/2003': true,
    '29/02/2003': false,
    '30/02/2003': false,

    /// Fev - 2004
    '00/02/2004': false,
    '01/02/2004': true,
    '02/02/2004': true,
    '28/02/2004': true,
    '29/02/2004': true,
    '30/02/2004': false,

    /// Fev - 2096
    '00/02/2096': false,
    '01/02/2096': true,
    '02/02/2096': true,
    '28/02/2096': true,
    '29/02/2096': true,
    '30/02/2096': false,

    /// Fev - 2100
    '00/02/2100': false,
    '01/02/2100': true,
    '02/02/2100': true,
    '28/02/2100': true,
    '29/02/2100': false,
    '30/02/2100': false,

    /// Fev - 2104
    '00/02/2104': false,
    '01/02/2104': true,
    '02/02/2104': true,
    '28/02/2104': true,
    '29/02/2104': true,
    '30/02/2104': false,
  };

  group(
    'DateValidator isValid',
    () {
      for (MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );
}
