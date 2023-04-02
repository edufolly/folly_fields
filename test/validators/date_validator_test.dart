import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/date_validator.dart';
import 'package:intl/date_symbol_data_local.dart';

///
///
///
void main() {
  setUp(() => initializeDateFormatting('pt_br'));

  group(
    'DateValidator isValid',
    () {
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

      DateValidator validator = DateValidator();

      for (final MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  group('DateValidator parse', () {
    Map<String, DateTime?> isValidTests = <String, DateTime?>{
      '': null,
      '00': null,
      '00-00-00': null,
      '01/01/00': null,
      '01/01/0000': DateTime(0),
      '00/01/0000': null,
      '01/00/0000': null,
      '00/00/0000': null,
      '01/01/00000': null,
      '00/01/2000': null,

      /// Invalid Month - 2000
      '00/00/2000': null,
      '01/00/2000': null,
      '02/00/2000': null,
      '29/00/2000': null,
      '30/00/2000': null,
      '31/00/2000': null,
      '32/00/2000': null,

      /// Jan - 2000
      '01/01/2000': DateTime(2000),
      '02/01/2000': DateTime(2000, 1, 2),
      '29/01/2000': DateTime(2000, 1, 29),
      '30/01/2000': DateTime(2000, 1, 30),
      '31/01/2000': DateTime(2000, 1, 31),
      '32/01/2000': null,

      /// Fev - 2000
      '00/02/2000': null,
      '01/02/2000': DateTime(2000, 2),
      '02/02/2000': DateTime(2000, 2, 2),
      '28/02/2000': DateTime(2000, 2, 28),
      '29/02/2000': DateTime(2000, 2, 29),
      '30/02/2000': null,

      /// Mar - 2000
      '00/03/2000': null,
      '01/03/2000': DateTime(2000, 3),
      '02/03/2000': DateTime(2000, 3, 2),
      '29/03/2000': DateTime(2000, 3, 29),
      '30/03/2000': DateTime(2000, 3, 30),
      '31/03/2000': DateTime(2000, 3, 31),
      '32/03/2000': null,

      /// Abr - 2000
      '00/04/2000': null,
      '01/04/2000': DateTime(2000, 4),
      '02/04/2000': DateTime(2000, 4, 2),
      '29/04/2000': DateTime(2000, 4, 29),
      '30/04/2000': DateTime(2000, 4, 30),
      '31/04/2000': null,
      '32/04/2000': null,

      /// Mai - 2000
      '00/05/2000': null,
      '01/05/2000': DateTime(2000, 5),
      '02/05/2000': DateTime(2000, 5, 2),
      '29/05/2000': DateTime(2000, 5, 29),
      '30/05/2000': DateTime(2000, 5, 30),
      '31/05/2000': DateTime(2000, 5, 31),
      '32/05/2000': null,

      /// Jun - 2000
      '00/06/2000': null,
      '01/06/2000': DateTime(2000, 6),
      '02/06/2000': DateTime(2000, 6, 2),
      '29/06/2000': DateTime(2000, 6, 29),
      '30/06/2000': DateTime(2000, 6, 30),
      '31/06/2000': null,
      '32/06/2000': null,

      /// Jul - 2000
      '00/07/2000': null,
      '01/07/2000': DateTime(2000, 7),
      '02/07/2000': DateTime(2000, 7, 2),
      '29/07/2000': DateTime(2000, 7, 29),
      '30/07/2000': DateTime(2000, 7, 30),
      '31/07/2000': DateTime(2000, 7, 31),
      '32/07/2000': null,

      /// Ago - 2000
      '00/08/2000': null,
      '01/08/2000': DateTime(2000, 8),
      '02/08/2000': DateTime(2000, 8, 2),
      '29/08/2000': DateTime(2000, 8, 29),
      '30/08/2000': DateTime(2000, 8, 30),
      '31/08/2000': DateTime(2000, 8, 31),
      '32/08/2000': null,

      /// Set - 2000
      '00/09/2000': null,
      '01/09/2000': DateTime(2000, 9),
      '02/09/2000': DateTime(2000, 9, 2),
      '29/09/2000': DateTime(2000, 9, 29),
      '30/09/2000': DateTime(2000, 9, 30),
      '31/09/2000': null,
      '32/09/2000': null,

      /// Out - 2000
      '00/10/2000': null,
      '01/10/2000': DateTime(2000, 10),
      '02/10/2000': DateTime(2000, 10, 2),
      '29/10/2000': DateTime(2000, 10, 29),
      '30/10/2000': DateTime(2000, 10, 30),
      '31/10/2000': DateTime(2000, 10, 31),
      '32/10/2000': null,

      /// Nov - 2000
      '00/11/2000': null,
      '01/11/2000': DateTime(2000, 11),
      '02/11/2000': DateTime(2000, 11, 2),
      '29/11/2000': DateTime(2000, 11, 29),
      '30/11/2000': DateTime(2000, 11, 30),
      '31/11/2000': null,
      '32/11/2000': null,

      /// Dez - 2000
      '00/12/2000': null,
      '01/12/2000': DateTime(2000, 12),
      '02/12/2000': DateTime(2000, 12, 2),
      '29/12/2000': DateTime(2000, 12, 29),
      '30/12/2000': DateTime(2000, 12, 30),
      '31/12/2000': DateTime(2000, 12, 31),
      '32/12/2000': null,

      /// Invalid Month - 2000
      '00/13/2000': null,
      '01/13/2000': null,
      '02/13/2000': null,
      '29/13/2000': null,
      '30/13/2000': null,
      '31/13/2000': null,
      '32/13/2000': null,

      /// Fev - 2001
      '00/02/2001': null,
      '01/02/2001': DateTime(2001, 2),
      '02/02/2001': DateTime(2001, 2, 2),
      '28/02/2001': DateTime(2001, 2, 28),
      '29/02/2001': null,
      '30/02/2001': null,

      /// Fev - 2002
      '00/02/2002': null,
      '01/02/2002': DateTime(2002, 2),
      '02/02/2002': DateTime(2002, 2, 2),
      '28/02/2002': DateTime(2002, 2, 28),
      '29/02/2002': null,
      '30/02/2002': null,

      /// Fev - 2003
      '00/02/2003': null,
      '01/02/2003': DateTime(2003, 2),
      '02/02/2003': DateTime(2003, 2, 2),
      '28/02/2003': DateTime(2003, 2, 28),
      '29/02/2003': null,
      '30/02/2003': null,

      /// Fev - 2004
      '00/02/2004': null,
      '01/02/2004': DateTime(2004, 2),
      '02/02/2004': DateTime(2004, 2, 2),
      '28/02/2004': DateTime(2004, 2, 28),
      '29/02/2004': DateTime(2004, 2, 29),
      '30/02/2004': null,

      /// Fev - 2096
      '00/02/2096': null,
      '01/02/2096': DateTime(2096, 2),
      '02/02/2096': DateTime(2096, 2, 2),
      '28/02/2096': DateTime(2096, 2, 28),
      '29/02/2096': DateTime(2096, 2, 29),
      '30/02/2096': null,

      /// Fev - 2100
      '00/02/2100': null,
      '01/02/2100': DateTime(2100, 2),
      '02/02/2100': DateTime(2100, 2, 2),
      '28/02/2100': DateTime(2100, 2, 28),
      '29/02/2100': null,
      '30/02/2100': null,

      /// Fev - 2104
      '00/02/2104': null,
      '01/02/2104': DateTime(2104, 2),
      '02/02/2104': DateTime(2104, 2, 2),
      '28/02/2104': DateTime(2104, 2, 28),
      '29/02/2104': DateTime(2104, 2, 29),
      '30/02/2104': null,
    };

    DateValidator validator = DateValidator();

    for (final MapEntry<String, DateTime?> input in isValidTests.entries) {
      test(
        'Testing: ${input.key}',
        () => expect(
          validator.parse(input.key),
          input.value,
        ),
      );
    }
  });
}
