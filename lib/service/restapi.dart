import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_wot/model/citymodel.dart';
import 'package:web_wot/model/companymodel.dart';
import 'package:web_wot/model/menumodel.dart';
// import 'package:universal_html/html.dart';
// import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/parametermodel.dart';
import 'package:web_wot/model/provincemodel.dart';
import 'package:web_wot/model/rolemodel.dart';
import 'package:web_wot/model/setting.dart';
import 'package:web_wot/model/setting_group.dart';
import 'package:web_wot/model/supportedobjectmodel.dart';
import 'package:web_wot/model/supportpicmodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/service/api_url.dart';
import 'package:web_wot/service/net_util.dart';

class RestApi extends UrlApi {
  NetworkUtil util = NetworkUtil();
  //Screen Setting Group
  Future<dynamic> ListSetting({Map<String, dynamic>? body}) {
    return util
        .post(
      BaseUrl + "setting-group/searchSettingGroup",
      body: body,
    )
        .then((value) {
      return value;
    });
  }

  Future<ResponseSetting> searchData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "setting-group/searchSettingGroup",
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

  Future<AddRequestSettings> AddSettingGroupData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "setting-group/insertSettingGroup",
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
      BaseUrl + "setting-group/updateSettingGroup",
      body: body,
    )
        .then(
      (dynamic res) {
        if (res["errMsg"] != null) throw (res["errMsg"].toString());
        return AddRequestSettings.fromJson(res);
      },
    );
  }

  Future<dynamic> DeleteSettingGroupData(
    // Map<String, String>? header,
    Map<String, dynamic> body,
  ) {
    return util
        .post(
      BaseUrl + "setting-group/deleteSettingGroup",
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
        BaseUrl +
            "setting-group/downloadSettingGroup?extention=" +
            header["extention"],
        headers: {
          'groupCd': header['groupCd'],
          'groupName': header['groupName'],
        } //+ extension,
        ).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return DownloadResponseSettingGroup.fromJson(res);
    });
  }

  Future<dynamic> DownloadTemplate(Map<String, dynamic> header) {
    return util
        .post(BaseUrl + "setting-group/downloadTemplateSettingGroup")
        .then((dynamic res) {
      if (res["status"] != 'OK') throw res['message'];
      return DownloadResponseSettingGroup.fromJson(res);
    });
  }

  Future<dynamic> UploadSettingGroup() {
    return util.post(BaseUrl + "setting-group/uploadSettingGroup").then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return Uploadresponse.fromJson(res); //AddRequestSettings.fromJson(res);
      },
    );
  }

  Future<dynamic> UploadFileSettingGroup(File_Data_Model req) {
    return util
        .postUpload(BaseUrl + "setting-group/uploadSettingGroup", body: req)
        .then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return Uploadresponse.fromJson(res);
      },
    );
  }

  //Screen Setting

  Future<ResponseSettings> searchsetData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "setting/searchDataSetting",
      body: body,
    )
        .then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseSettings.fromJson(res);
      },
    );
  }

  Future<dynamic> GetSettingGroupCode() {
    return util.post(BaseUrl + "setting/getSettingGroupCode").then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseGetSettingGroupCode.fromJson(
            res); //AddRequestSettings.fromJson(res);
      },
    );
  }

  Future<dynamic> GetSettingValueType() {
    return util.post(BaseUrl + "setting/getSettingValueType").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseGetSettingValueType.fromJson(res);
      },
    );
  }

  Future<dynamic> DownloadTemplateSetting() {
    return util.post(BaseUrl + "setting/downloadTemplateSetting").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseDownloadTemplate.fromJson(res);
      },
    );
  }

  Future<RequestAddSetting> AddSettingData(Map<String, dynamic> body) {
    return util
        .post(BaseUrl + "setting/insertSetting", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestAddSetting.fromJson(res);
    });
  }

  Future<RequestAddSetting> EditSettingData(Map<String, dynamic> body) {
    return util
        .post(BaseUrl + "setting/updateSetting", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestAddSetting.fromJson(res);
    });
  }

  Future<DownloadResponseSetting> DownloadSetting(Map<String, dynamic> header) {
    return util.post(
        BaseUrl + "setting/downloadSetting?extention=" + header["extention"],
        headers: {
          'settingGroup': header['settingGroup'],
          'settingName': header['settingName'],
          'value': header['value'],
        }).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return DownloadResponseSetting.fromJson(res);
    });
  }

  Future<dynamic> DeleteSettingData(Map<String, dynamic> body) {
    return util
        .post(BaseUrl + "setting/deleteSetting", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return DeleteRequestSetting.fromJson(res);
    });
  }

  Future<dynamic> UploadSetting(File_Data_Model req) {
    return util.postUpload(BaseUrl + "setting/uploadSetting", body: req).then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return UploadSettingresponse.fromJson(res);
      },
    );
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

  //Screen Parameter
  Future<ResponseParameterSearch> Searchparam(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrlnew + "searchParameter",
      body: body,
    )
        .then(
      (dynamic res) {
        // print(res);
        if (res["status"].toString().toUpperCase() != "SUCCESS")
          throw (res["message"].toString());
        return ResponseParameterSearch.fromJson(res);
      },
    );
  }

  Future<ResponseParameterDownload> DownloadParam(Map<String, dynamic> header) {
    return util.post(
        BaseUrlnew + "downloadParameter?extention=" + header["extention"],
        headers: {
          'paramGroupCd': header['paramGroupCd'],
          'paramGroupName': header['paramGroupName'],
          'paramName': header['paramName'],
        }).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseParameterDownload.fromJson(res);
    });
  }

  Future<dynamic> DeleteParameter(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "deleteParamGroup", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestParameterDelete.fromJson(res);
    });
  }

  Future<RequestParameterAdd> AddParameterData(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "submitParameter", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestParameterAdd.fromJson(res);
    });
  }

  //api province
  Future<ProvinceResponseSearch> searchproData(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "searchProvince", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ProvinceResponseSearch.fromJson(res);
    });
  }

  Future<ProvinceRequestAdd> AddProvinceData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrlnew + "insertProvince",
      body: body,
    )
        .then(
      (dynamic res) {
        if (res["status"] != 'Success') throw res['message'];
        return ProvinceRequestAdd.fromJson(res);
      },
    );
  }

  Future<ProvinceRequestEdit> EditProvinceData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrlnew + "updateProvince",
      body: body,
    )
        .then(
      (dynamic res) {
        if (res["status"] != 'Success') throw res['message'];
        return ProvinceRequestEdit.fromJson(res);
      },
    );
  }

  Future<dynamic> DeleteProData(
    // Map<String, String>? header,
    Map<String, dynamic> body,
  ) {
    return util
        .post(
      BaseUrlnew + "deleteProvince",
      body: body,
    )
        .then(
      (dynamic res) {
        if (res["status"] != 'Success') throw res['message'];
        return ProvinceRequestDelete.fromJson(res);
      },
    );
  }

  Future<ProvinceRespDownload> DownloadPro(Map<String, dynamic> header) {
    return util.post(
        BaseUrlnew + "downloadProvince?extention=" + header["extention"],
        headers: {
          'provinceCd': header['provinceCd'],
          'provinceName': header['provinceName']
        }).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ProvinceRespDownload.fromJson(res);
    });
  }

  Future<dynamic> TemplatePro() {
    return util.post(BaseUrlnew + "downloadTemplateProvince").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ProvinceRespTemplate.fromJson(res);
      },
    );
  }

  Future<dynamic> UploadPro(File_Data_Model req) {
    return util.postUpload(BaseUrlnew + "uploadProvince", body: req).then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return UploadProResponse.fromJson(res);
      },
    );
  }

  //Screen city

  Future<ResponseCitySearch> searchCityData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrl + "city/searchCity",
      body: body,
    )
        .then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseCitySearch.fromJson(res);
      },
    );
  }

  Future<dynamic> GetProvinceData() {
    return util.post(BaseUrl + "city/getProvinceList").then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseGetProvince.fromJson(res);
      },
    );
  }

  Future<RequestAddCity> AddCityData(Map<String, dynamic> body) {
    return util
        .post(BaseUrl + "city/insertCity", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestAddCity.fromJson(res);
    });
  }

  Future<RequestAddCity> EditCityData(Map<String, dynamic> body) {
    return util
        .post(BaseUrl + "city/updateCity", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestAddCity.fromJson(res);
    });
  }

  Future<dynamic> DeleteCityData(Map<String, dynamic> body) {
    return util
        .post(BaseUrl + "city/deleteCity", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestDeleteCity.fromJson(res);
    });
  }

  Future<ResponseDownloadCity> DownloadCityData(Map<String, dynamic> header) {
    return util.post(
        BaseUrl + "city/downloadCity?extention=" + header["extention"],
        headers: {
          'provinceCd': header['provinceCd'],
          'cityCd': header['cityCd'],
          'cityName': header['cityName'],
        }).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseDownloadCity.fromJson(res);
    });
  }

  Future<dynamic> DownloadTemplateData() {
    return util.post(BaseUrl + "city/downloadTemplateCity").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseTemplateCity.fromJson(res);
      },
    );
  }

  Future<dynamic> UploadCity(File_Data_Model req) {
    return util.postUpload(BaseUrl + "city/uploadCity", body: req).then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseUploadCity.fromJson(res);
      },
    );
  }

  //Screen Company
  Future<ResponseSearchComp> searchcomp(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "searchCompany", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseSearchComp.fromJson(res);
    });
  }

  Future<dynamic> GetBusinessCmb() {
    return util.post(BaseUrlnew + "getBusinessCompany").then((dynamic res) {
      if (res["status"] != 'Success') throw (res['message'].toString());
      return ResponseComBusiness.fromJson(res);
    });
  }

  Future<dynamic> GetTypeCmb() {
    return util.post(BaseUrlnew + "getTypeCompany").then((dynamic res) {
      if (res["status"] != 'Success') throw (res['message'].toString());
      return ResponseComType.fromJson(res);
    });
  }

  Future<dynamic> GetCityCmb() {
    return util.post(BaseUrlnew + "getCityCompany").then((dynamic res) {
      if (res["status"] != 'Success') throw (res['message'].toString());
      return ResponseComCity.fromJson(res);
    });
  }

  Future<RequestComAdd> AddCompData(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "insertCompany", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestComAdd.fromJson(res);
    });
  }

  Future<RequestComAdd> EditCompData(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "updateCompany", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestComAdd.fromJson(res);
    });
  }

  Future<dynamic> DeleteComData(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "deleteCompany", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestComDelete.fromJson(res);
    });
  }

  Future<DownloadResponseComp> DownloadReqData(Map<String, dynamic> header) {
    return util.post(BaseUrlnew + "downloadCompany", //+ header["extention"],
        headers: {
          'business': header['business'],
          'companyCd': header['companyCd'],
          'companyName': header['companyName'],
          'extention': header['extention']
        }).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return DownloadResponseComp.fromJson(res);
    });
  }

  Future<dynamic> UploadReqData(File_Data_Model req) {
    return util.postUpload(BaseUrlnew + "uploadCompany", body: req).then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return UploadComresponse.fromJson(res);
      },
    );
  }

  Future<dynamic> DownloadTemplateComp() {
    return util.post(BaseUrlnew + "downloadTemplateCompany").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseDownloadTemplateCom.fromJson(res);
      },
    );
  }

  //Screen Supported Object

  Future<ResponseSearchSO> Searchso(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "searchSupportedObject", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseSearchSO.fromJson(res);
    });
  }

  Future<RequestSOAdd> Addso(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "insertSupportedObject", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestSOAdd.fromJson(res);
    });
  }

  Future<dynamic> Getso() {
    return util
        .post(BaseUrlnew + "getObjectTypeSupportedObject")
        .then((dynamic res) {
      if (res["status"] != 'Success') throw (res['message'].toString());
      return ResponseSOGetType.fromJson(res);
    });
  }

  Future<dynamic> GetsoComp() {
    return util
        .post(BaseUrlnew + "getCompanySupportedObject")
        .then((dynamic res) {
      if (res["status"] != 'Success') throw (res['message'].toString());
      return ResponseSOGetCom.fromJson(res);
    });
  }

  Future<RequestSOAdd> Editso(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "updateSupportedObject", body: body)
        .then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestSOAdd.fromJson(res);
    });
  }

  Future<dynamic> Deleteso(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "deleteSupportedObject", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestDeleteSO.fromJson(res);
    });
  }

  Future<dynamic> DownloadTemplateSO() {
    return util.post(BaseUrlnew + "downloadTemplateSupportedObject").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseTempData.fromJson(res);
      },
    );
  }

  Future<ResponseDownloadSO> DownloadSOData(Map<String, dynamic> header) {
    return util
        .post(BaseUrlnew + "downloadSupportedObject", //+ header["extention"],
            headers: {
          'objectType': header['objectType'],
          'objectName': header['objectName'],
          'companyName': header['companyName'],
          'extention': header['extention']
        }).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseDownloadSO.fromJson(res);
    });
  }

  Future<dynamic> UploadDataSO(File_Data_Model req) {
    return util
        .postUpload(BaseUrlnew + "uploadSupportedObject", body: req)
        .then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseUploadSO.fromJson(res);
      },
    );
  }

  //Screen Support PIC
  Future<ResponseSuppicSearch> SearchPIC(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "searchSupportPic", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseSuppicSearch.fromJson(res);
    });
  }

  Future<ResponsePicDownload> DownloadPIC(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "downloadSupportPic", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponsePicDownload.fromJson(res);
    });
  }

  Future<ResponseGetPIC> GetPicData(int? header) {
    return util
        .get(
      BaseUrlnew + "assignSupportPic?companyId=" + header.toString(),
    )
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseGetPIC.fromJson(res);
    });
  }

  Future<ResponseGetAuto> GetAutoData() {
    return util.get(BaseUrlnew + "picAutoSupportPic").then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseGetAuto.fromJson(res);
    });
  }

  Future<RequestAddPic> AddPicData(Map<String, dynamic> body) {
    return util
        .post(BaseUrlnew + "submitSupportPic", body: body)
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestAddPic.fromJson(res);
    });
  }

//Screen Menu
  Future<ResponseMenuSearch> SearchMenuData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "searchMenu", body: body).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseMenuSearch.fromJson(res);
    });
  }

  Future<RequestMenuAdd> AddMenuData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "insertMenu", body: body).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestMenuAdd.fromJson(res);
    });
  }

  Future<dynamic> GetParentData() {
    return util.post(BaseUrlnew + "getMenuParent").then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return ResponseGetParent.fromJson(res);
    });
  }

  Future<DownloadResponse> DownloadMenuData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrlnew + "downloadMenu",
      body: body,
    )
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return DownloadResponse.fromJson(res);
    });
  }

  Future<dynamic> DownloadTemplateMenu() {
    return util.post(BaseUrlnew + "downloadTemplateMenu").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return DownloadTemplateResp.fromJson(res);
      },
    );
  }

  Future<dynamic> DeleteMenuData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "deleteMenu", body: body).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestMenuDel.fromJson(res);
    });
  }

  Future<dynamic> UploadMenuData(File_Data_Model req) {
    return util.postUpload(BaseUrlnew + "uploadMenu", body: req).then(
      (dynamic res) {
        // print(res);
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseUploadMenu.fromJson(res);
      },
    );
  }

  Future<RequestMenuAdd> EditMenuData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "updateMenu", body: body).then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestMenuAdd.fromJson(res);
    });
  }

  //Screen Role
  Future<ResponseRoleSearch> SearchRoleData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "searchRole", body: body).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseRoleSearch.fromJson(res);
    });
  }

  Future<RequestRoleAdd> AddRoleData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "insertRole", body: body).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestRoleAdd.fromJson(res);
    });
  }

  Future<dynamic> DeleteRoleData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "deleteRole", body: body).then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return RequestRoleDelete.fromJson(res);
    });
  }

  Future<ResponseDownload> DownloadRoleData(Map<String, dynamic> body) {
    return util
        .post(
      BaseUrlnew + "downloadRole",
      body: body,
    )
        .then((dynamic res) {
      if (res["status"] != 'Success') throw res['message'];
      return ResponseDownload.fromJson(res);
    });
  }

  Future<dynamic> DownloadTempRole() {
    return util.post(BaseUrlnew + "downloadTemplateRole").then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseRoleTemp.fromJson(res);
      },
    );
  }

  Future<dynamic> UploadRoleData(File_Data_Model req) {
    return util.postUpload(BaseUrlnew + "uploadRole", body: req).then(
      (dynamic res) {
        if (res["status"] != "Success") throw (res["message"].toString());
        return ResponseUploadRole.fromJson(res);
      },
    );
  }

  Future<RequestRoleAdd> EditRoleData(Map<String, dynamic> body) {
    return util.post(BaseUrlnew + "updateRole", body: body).then((dynamic res) {
      if (res["status"] != "Success") throw (res["message"].toString());
      return RequestRoleAdd.fromJson(res);
    });
  }
}
