import 'package:html/parser.dart' as html_parser;

String stripHtml(String htmlString) {
  final document = html_parser.parse(htmlString);
  return document.body?.text ?? '';
}
