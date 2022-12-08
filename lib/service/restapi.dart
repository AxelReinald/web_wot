import 'package:flutter/material.dart';
import 'package:web_wot/model/setting.dart';
import 'package:web_wot/model/setting_group.dart';
import 'package:web_wot/service/api_url.dart';
import 'package:web_wot/service/net_util.dart';

class RestApi extends UrlApi {
  NetworkUtil util = NetworkUtil();

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

  Future<ResponseSetting> searchData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "searchSettingGroup",
      body: body,
    )
        .then(
      (dynamic res) {
        // print(res);
        if (res["errMsg"] != null) throw (res["errMsg"].toString());
        return ResponseSetting.fromJson(res);
      },
    );
  }

  Future<ResponseSettings> searchsetData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "searchDataSetting",
      body: body,
    )
        .then(
      (dynamic res) {
        // print(res);
        if (res["errMsg"] != null) throw (res["errMsg"].toString());
        return ResponseSettings.fromJson(res);
      },
    );
  }

  Future<AddRequestSettings> AddSettingGroupData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "insertSettingGroup",
      body: body,
    )
        .then(
      (dynamic res) {
        if (res["errMsg"] != null) throw (res["errMsg"].toString());
        return AddRequestSettings.fromJson(res);
      },
    );
  }

  Future<AddRequestSettings> EditSettingGroupData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "updateSettingGroup",
      body: body,
    )
        .then(
      (dynamic res) {
        if (res["errMsg"] != null) throw (res["errMsg"].toString());
        return AddRequestSettings.fromJson(res);
      },
    );
  }
}
