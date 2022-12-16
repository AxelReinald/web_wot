import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:io';

UploadSetting(String filename, Uint8List? fileBytes) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.0.130:9013/temacs/api/temacs/main/v1/uploadSettingGroup'));
  request.files.add(await http.MultipartFile.fromPath('xlsx', filename));
  var res = await request.send();
}
