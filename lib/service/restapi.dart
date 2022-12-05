import 'package:flutter/material.dart';
import 'package:web_wot/service/api_url.dart';
import 'package:web_wot/service/net_util.dart';

class RestApi extends UrlApi {
  NetworkUtil util = NetworkUtil();

  // Future<dynamic> create({Map<String, dynamic>? body}) {
  //   return util
  //       .post(
  //     BaseUrl + "/api/users",
  //     body: body,
  //   )
  //       .then((value) {
  //     return value;
  //   });
  // }
  Future<dynamic> ListSetting({Map<String, dynamic>? body}) {
    return util
        .post(
      BaseUrl + "searchSettingGroup",
      body: body,
    )
        .then((value) {
      return value;
    });
  }
}
