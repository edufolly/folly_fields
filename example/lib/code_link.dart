import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

import 'package:folly_fields/widgets/folly_dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class CodeLink extends StatelessWidget {
  final String code;
  final String tag;
  final String source;
  final Widget child;

  ///
  ///
  ///
  const CodeLink({
    Key? key,
    required this.code,
    required this.tag,
    required this.source,
    required this.child,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: child,
        ),
        IconButton(
          icon: const Text(
            '?',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => _showCode(context),
        ),
      ],
    );
  }

  ///
  ///
  ///
  void _showCode(BuildContext context) {
    String example = RegExp('// \\[$tag\\]([\\S\\s]*)// \\[/$tag\\]')
        .firstMatch(code)!
        .group(1)!
        .replaceAll('              ', '')
        .replaceAll('            ', '  ')
        .replaceAll('          ', '')
        .trim();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tag),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.black38,
              child: SingleChildScrollView(
                child: HighlightView(
                  example,
                  language: 'dart',
                  theme: myTheme,
                  textStyle: GoogleFonts.firaCode(fontSize: 14.0),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              label: const Text('Copiar'),
              icon: const Icon(Icons.copy),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: example));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Código copiado para a área de transferência.',
                    ),
                  ),
                );
              },
            ),
            ElevatedButton.icon(
              label: const Text('Código Fonte'),
              icon: const Icon(FontAwesomeIcons.github),
              onPressed: () async {
                if (await canLaunch(source)) {
                  await launch(source);
                } else {
                  await FollyDialogs.dialogMessage(
                    context: context,
                    message: 'Não foi possível abrir $source',
                  );
                }
              },
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
      useSafeArea: true,
    );
  }

  ///
  ///
  ///
  static const Map<String, TextStyle> myTheme = <String, TextStyle>{
    'root': TextStyle(
      color: Color(0xffa9b7c6),
      backgroundColor: Color(0x00000000),
    ),
    'number': TextStyle(color: Color(0xff6897BB)),
    'literal': TextStyle(color: Color(0xff6897BB)),
    'symbol': TextStyle(color: Color(0xff6897BB)),
    'bullet': TextStyle(color: Color(0xff6897BB)),
    'keyword': TextStyle(color: Color(0xffcc7832)),
    'selector-tag': TextStyle(color: Color(0xffcc7832)),
    'deletion': TextStyle(color: Color(0xffcc7832)),
    'variable': TextStyle(color: Color(0xff629755)),
    'template-variable': TextStyle(color: Color(0xff629755)),
    'link': TextStyle(color: Color(0xff629755)),
    'comment': TextStyle(color: Color(0xff808080)),
    'quote': TextStyle(color: Color(0xff808080)),
    'meta': TextStyle(color: Color(0xffbbb529)),
    'string': TextStyle(color: Color(0xff6A8759)),
    'attribute': TextStyle(color: Color(0xff6A8759)),
    'addition': TextStyle(color: Color(0xff6A8759)),
    'section': TextStyle(color: Color(0xffffc66d)),
    'title': TextStyle(color: Color(0xffffc66d)),
    'type': TextStyle(color: Color(0xffffc66d)),
    'name': TextStyle(color: Color(0xffe8bf6a)),
    'selector-id': TextStyle(color: Color(0xffe8bf6a)),
    'selector-class': TextStyle(color: Color(0xffe8bf6a)),
    'emphasis': TextStyle(fontStyle: FontStyle.italic),
    'strong': TextStyle(fontWeight: FontWeight.bold),
  };
}
