import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_wot/helper/app_exception.dart';
import 'package:web_wot/model/uploadmodel.dart';

class NetworkUtil {
  static NetworkUtil instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => instance;

  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    encoding,
  }) async {
    //String jsonBody = jsonEncode(body);
    Map<String, String> headerJson = {"Accept": "*/*"};
    if (headers != null) {
      headerJson.addAll(headers);
    }
    return await http
        .get(Uri.parse(url), headers: headerJson)
        .then((http.Response response) => _returnResponse(response));
  }

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

  Future<dynamic> postUpload(
    String url, {
    File_Data_Model? body,
    Map<String, String>? headers,
    // Map<String, String>? param,
    encoding,
  }) async {
    final JsonDecoder _decoder = new JsonDecoder();
    // String jsonBody = jsonEncode(body);
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    request.files.add(await http.MultipartFile.fromBytes("file", body!.bytes,
        filename: body.name));

    http.Response respon = await http.Response.fromStream(await request.send());
    return _decoder.convert(respon.body);
    // Map<String, String> headerJson = {
    //   "Accept": "*/*",
    //   "Content-Type": "application/json",
    // };
    // if (headers != null) {
    //   headerJson.addAll(headers);
    // }
    // return await http
    //     .post(Uri.parse(url),
    //         headers: headerJson, body: jsonBody, encoding: encoding)
    //     .then((http.Response response) => _returnResponse(response));
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
