import 'dart:io';

import 'package:http/http.dart';

///
///
///
void main() async {
  const String version = '10.5.0';

  Response response = await get(
    Uri.parse(
      'https://raw.githubusercontent.com/fluttercommunity/font_awesome_flutter'
      '/$version/lib/font_awesome_flutter.dart',
    ),
  );

  List<String> lines = <String>[];

  List<String> rows = response.body.split('\n');

  for (int pos = 0; pos < rows.length; pos++) {
    String row = rows[pos].trim();
    if (row.startsWith('static const IconData')) {
      StringBuffer stringBuffer = StringBuffer(row);
      while (!row.endsWith(';')) {
        pos++;
        row = rows[pos].trim();
        stringBuffer
          ..write(' ')
          ..write(row);
      }
      lines.add(stringBuffer.toString());
    }
  }

  RegExp regExp = RegExp('static const IconData (.*)=(.*);');

  StringBuffer sb = StringBuffer();

  for (final String line in lines) {
    RegExpMatch? match = regExp.firstMatch(line);
    if (match != null) {
      String? name = match.group(1)?.trim();
      String? icon = match.group(2)?.trim();
      if ((icon?.contains('IconData') ?? true) && name != null) {
        sb.writeln("'$name': FontAwesomeIcons.$name,");
      } else {
        sb.writeln("'$name': FontAwesomeIcons.$icon,");
      }
    }
  }

  File('fa_code.txt')
    ..createSync(recursive: true)
    ..writeAsStringSync(sb.toString());
}
