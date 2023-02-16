// ignore_for_file: avoid_print

import 'package:http/http.dart';

///
///
///
void main() async {
  String version = '10.4.0';

  Response response = await get(
    Uri.parse(
      'https://raw.githubusercontent.com/fluttercommunity/font_awesome_flutter'
      '/$version/lib/font_awesome_flutter.dart',
    ),
  );

  List<String> lines = <String>[];

  List<String> rows = response.body.split('\n');

  for (int i = 0; i < rows.length; i++) {
    String row = rows[i].trim();
    if (row.startsWith('static const IconData')) {
      StringBuffer sb = StringBuffer(row);
      while (!row.endsWith(';')) {
        i++;
        row = rows[i].trim();
        sb
          ..write(' ')
          ..write(row);
      }
      lines.add(sb.toString());
    }
  }

  RegExp regExp = RegExp('static const IconData (.*)=(.*);');

  for (final String line in lines) {
    RegExpMatch? match = regExp.firstMatch(line);
    if (match != null) {
      String? name = match.group(1)?.trim();
      String? icon = match.group(2)?.trim();
      if ((icon?.contains('IconData') ?? true) && name != null) {
        print("'$name': FontAwesomeIcons.$name,");
      } else {
        print("'$name': FontAwesomeIcons.$icon,");
      }
    }
  }
}
