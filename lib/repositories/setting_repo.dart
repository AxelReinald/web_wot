// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:web_wot/model/setting_group.dart';

// class SettingRepository {
//   Future<List<requestSetting>> fetchSetting() async {
//     List<requestSetting> reqset = List();
//     await http
//         .get(
//             Uri.parse("http://192.168.0.130:9013/temacs/api/swagger-ui.html#/"))
//         .then((response) {
//       Iterable it = json.decode(response.body);
//       reqset = it.map((e) => requestSetting.fromJson(e)).toList();
//     });
//     return reqset;
//   }
// }
