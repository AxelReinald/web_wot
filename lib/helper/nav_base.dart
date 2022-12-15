import 'package:universal_html/html.dart' as html;

writeFileWeb(String base64, String? fileName) async {
  String fileUrl =
      "data:application/octet-stream;charset=utf-16le;base64,$base64";
  html.AnchorElement anchorElement = html.AnchorElement(href: fileUrl);
  anchorElement.download = "${fileName ?? 'download'}";
  anchorElement.click();
}
