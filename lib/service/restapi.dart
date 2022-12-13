import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_wot/helper/nav_base.dart';
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

  // Future<dynamic> DeleteSettingGroupData(Map<String, String>? body) {
  //   return util
  //       .post(
  //     BaseUrl + "deleteSettingGroup",
  //     body: body,
  //   )
  //       .then(
  //     (value) {
  //       if (value['status'] != 'Success') throw value['message'];
  //       return value;
  //     },
  //   );
  // }

  Future<dynamic> DeleteSettingGroupData(
    // Map<String, String>? header,
    Map<String, dynamic> body,
  ) {
    return util
        .post(
      BaseUrl + "deleteSettingGroup",
      body: body,
      // headers: header,
    )
        .then(
      (dynamic res) {
        if (res["errMsg"] != null) throw (res["errMsg"].toString());
        return DeleteRequestSettings.fromJson(res);
      },
    );
  }

  Future<dynamic> DownloadSettingGroup(Map<String, dynamic> header) {
    return util
        .post(
      BaseUrl + "downloadSettingGroup",
    )
        .then((dynamic res) {
      //if (res["errMsg"] != null) throw (res["errMsg"].toString());
      if (res["errMsg"] != null)
        throw (writeFileWeb(
            "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",
            "DownloadSettings"));
      return DownloadRequestSettings;
    });
  }
  // Future<String> DeleteSettingGroupData(Map<String, dynamic> body) {
  //   return util
  //       .post(
  //     BaseUrl + "deleteSettingGroup",
  //     body: body,
  //   )
  //       .then(
  //     (dynamic res) {
  //       if (res["errMsg"] != null) throw (res["errMsg"].toString());
  //       return .fromJson(res);
  //     },
  //   );
  // }
}
