import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
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

  Future<DownloadResponseSettingGroup> DownloadSettingGroup(
      Map<String, dynamic> header) {
    return util.post(
        BaseUrl + "downloadSettingGroup?extention=" + header["extention"],
        headers: {
          'groupCd': header['groupCd'],
          'groupName': header['groupName'],
        } //+ extension,
        ).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return DownloadResponseSettingGroup.fromJson(res);
    });
  }

  // Future<SearchSOResult> searchData(
  //     Map<String, dynamic> body, String token, String url) {
  //   return net
  //       .post(url + ApiConstants.Search_Data_SO,
  //           headers: {
  //             'Accept': 'application/json',
  //             'Content-Type': 'application/json',
  //             'Authorization': token
  //           },
  //           body: body,
  //           encoding: Encoding.getByName('utf-8'),
  //           param: {})
  //       .then(
  //     (dynamic res) {
  //       print(res);
  //       if (res["errMsg"] != null) throw (res["errMsg"].toString());
  //       return SearchSOResult.fromJson(res);
  //     },
  //   );
  // }
}
