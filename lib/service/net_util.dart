import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_wot/helper/app_exception.dart';

class NetworkUtil {
  static NetworkUtil instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => instance;

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? param,
    encoding,
  }) async {
    String jsonBody = jsonEncode(body);
    Map<String, String> headerJson = {
      "Accept": "*/*",
      "Content-Type": "application/json",
    };
    if (headers != null) {
      headerJson.addAll(headers);
    }
    return await http
        .post(Uri.parse(url),
            headers: headerJson, body: jsonBody, encoding: encoding)
        .then((http.Response response) => _returnResponse(response));
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson;
        if (response.body.isNotEmpty) {
          responseJson = jsonDecode(response.body.toString());
        } else {
          responseJson = response.body;
        }
        return responseJson;
      case 201:
        dynamic responseJson;
        if (response.body.isNotEmpty) {
          responseJson = jsonDecode(response.body.toString());
        } else {
          responseJson = response.body;
        }
        return responseJson;
      case 400:
        var responseJson = jsonDecode(response.body.toString());
        throw BadRequestException(responseJson['message']);
      case 500:
        var responseJson = jsonDecode(response.body.toString());
        throw BadRequestException(responseJson['message']);
      default:
        throw FetchDataException(
          'Error occured while communication with server with statuscode : ' +
              response.statusCode.toString(),
        );
    }
  }
}
