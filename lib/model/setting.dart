class RequestSettings {
  int? pageNumber;
  int? pageSize;
  String? settingCode;
  String? settingGroup;
  String? value;

  RequestSettings(
      {this.pageNumber,
      this.pageSize,
      this.settingCode,
      this.settingGroup,
      this.value});

  RequestSettings.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    settingCode = json['settingCode'];
    settingGroup = json['settingGroup'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['settingCode'] = this.settingCode;
    data['settingGroup'] = this.settingGroup;
    data['value'] = this.value;
    return data;
  }
}

class ResponseSettings {
  String? status;
  String? message;
  int? countData;
  List<GData>? data;

  ResponseSettings({this.status, this.message, this.countData, this.data});

  ResponseSettings.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <GData>[];
      json['data'].forEach((v) {
        data!.add(new GData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? settingCode;
  String? settingGroupCode;
  String? settingGroupName;
  String? settingDesc;
  String? settingValue;
  String? settingValueType;

  GData(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.settingCode,
      this.settingGroupCode,
      this.settingGroupName,
      this.settingDesc,
      this.settingValue,
      this.settingValueType});

  GData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    settingCode = json['settingCode'];
    settingGroupCode = json['settingGroupCode'];
    settingGroupName = json['settingGroupName'];
    settingDesc = json['settingDesc'];
    settingValue = json['settingValue'];
    settingValueType = json['settingValueType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['settingCode'] = this.settingCode;
    data['settingGroupCode'] = this.settingGroupCode;
    data['settingGroupName'] = this.settingGroupName;
    data['settingDesc'] = this.settingDesc;
    data['settingValue'] = this.settingValue;
    data['settingValueType'] = this.settingValueType;
    return data;
  }
}

class RequestSettingAdd {
  String? settingCode;
  String? settingDesc;
  String? settingGroupCode;
  String? settingValue;
  String? settingValueType;

  RequestSettingAdd(
      {this.settingCode,
      this.settingDesc,
      this.settingGroupCode,
      this.settingValue,
      this.settingValueType});

  RequestSettingAdd.fromJson(Map<String, dynamic> json) {
    settingCode = json['settingCode'];
    settingDesc = json['settingDesc'];
    settingGroupCode = json['settingGroupCode'];
    settingValue = json['settingValue'];
    settingValueType = json['settingValueType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['settingCode'] = this.settingCode;
    data['settingDesc'] = this.settingDesc;
    data['settingGroupCode'] = this.settingGroupCode;
    data['settingValue'] = this.settingValue;
    data['settingValueType'] = this.settingValueType;
    return data;
  }
}

class ResponseGetSettingGroupCode {
  String? status;
  String? message;
  int? countData;
  List<GetData>? data;

  ResponseGetSettingGroupCode(
      {this.status, this.message, this.countData, this.data});

  ResponseGetSettingGroupCode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <GetData>[];
      json['data'].forEach((v) {
        data!.add(new GetData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetData {
  String? settingGroupCd;
  String? settingGroupName;

  GetData({this.settingGroupCd, this.settingGroupName});

  GetData.fromJson(Map<String, dynamic> json) {
    settingGroupCd = json['settingGroupCd'];
    settingGroupName = json['settingGroupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['settingGroupCd'] = this.settingGroupCd;
    data['settingGroupName'] = this.settingGroupName;
    return data;
  }
}

class ResponseGetSettingValueType {
  String? status;
  String? message;
  int? countData;
  List<ValueData>? data;

  ResponseGetSettingValueType(
      {this.status, this.message, this.countData, this.data});

  ResponseGetSettingValueType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <ValueData>[];
      json['data'].forEach((v) {
        data!.add(new ValueData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValueData {
  String? settingValueType;
  String? paramCode;

  ValueData({this.settingValueType, this.paramCode});

  ValueData.fromJson(Map<String, dynamic> json) {
    settingValueType = json['settingValueType'];
    paramCode = json['paramCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['settingValueType'] = this.settingValueType;
    data['paramCode'] = this.paramCode;
    return data;
  }
}

class ResponseDownloadTemplate {
  String? status;
  String? message;
  int? countData;
  DownloadTemplateData? data;

  ResponseDownloadTemplate(
      {this.status, this.message, this.countData, this.data});

  ResponseDownloadTemplate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null
        ? new DownloadTemplateData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DownloadTemplateData {
  String? base64Data;
  String? fileName;
  Null filePathName;

  DownloadTemplateData({this.base64Data, this.fileName, this.filePathName});

  DownloadTemplateData.fromJson(Map<String, dynamic> json) {
    base64Data = json['base64Data'];
    fileName = json['fileName'];
    filePathName = json['filePathName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base64Data'] = this.base64Data;
    data['fileName'] = this.fileName;
    data['filePathName'] = this.filePathName;
    return data;
  }
}

class RequestAddSetting {
  String? settingCode;
  String? settingDesc;
  String? settingGroupCode;
  String? settingValue;
  String? settingValueType;

  RequestAddSetting(
      {this.settingCode,
      this.settingDesc,
      this.settingGroupCode,
      this.settingValue,
      this.settingValueType});

  RequestAddSetting.fromJson(Map<String, dynamic> json) {
    settingCode = json['settingCode'];
    settingDesc = json['settingDesc'];
    settingGroupCode = json['settingGroupCode'];
    settingValue = json['settingValue'];
    settingValueType = json['settingValueType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['settingCode'] = this.settingCode;
    data['settingDesc'] = this.settingDesc;
    data['settingGroupCode'] = this.settingGroupCode;
    data['settingValue'] = this.settingValue;
    data['settingValueType'] = this.settingValueType;
    return data;
  }
}

class ResponseAddSetting {
  String? status;
  String? message;
  int? countData;
  AddData? data;

  ResponseAddSetting({this.status, this.message, this.countData, this.data});

  ResponseAddSetting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new AddData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddData {
  String? recordFlag;
  String? createdBy;
  String? createdTime;
  Null updatedBy;
  Null updatedTime;
  String? settingCode;
  String? settingGroupCode;
  String? settingDesc;
  String? settingValue;
  String? settingValueType;

  AddData(
      {this.recordFlag,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.settingCode,
      this.settingGroupCode,
      this.settingDesc,
      this.settingValue,
      this.settingValueType});

  AddData.fromJson(Map<String, dynamic> json) {
    recordFlag = json['recordFlag'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    settingCode = json['settingCode'];
    settingGroupCode = json['settingGroupCode'];
    settingDesc = json['settingDesc'];
    settingValue = json['settingValue'];
    settingValueType = json['settingValueType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordFlag'] = this.recordFlag;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['settingCode'] = this.settingCode;
    data['settingGroupCode'] = this.settingGroupCode;
    data['settingDesc'] = this.settingDesc;
    data['settingValue'] = this.settingValue;
    data['settingValueType'] = this.settingValueType;
    return data;
  }
}

class RequestDeleteSetting {
  List<ListCode>? listCode;

  RequestDeleteSetting({this.listCode});

  RequestDeleteSetting.fromJson(Map<String, dynamic> json) {
    if (json['listCode'] != null) {
      listCode = <ListCode>[];
      json['listCode'].forEach((v) {
        listCode!.add(new ListCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listCode != null) {
      data['listCode'] = this.listCode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListCode {
  String? code;

  ListCode({this.code});

  ListCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class DownloadRequestSettings {
  String? settingGroup;
  String? settingName;
  String? value;
  String? extention;

  DownloadRequestSettings(
      {this.settingGroup, this.settingName, this.value, this.extention});

  DownloadRequestSettings.fromJson(Map<String, dynamic> json) {
    settingGroup = json['settingGroup'];
    settingName = json['settingName'];
    value = json['value'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['settingGroup'] = this.settingGroup;
    data['settingName'] = this.settingName;
    data['value'] = this.value;
    data['extention'] = this.extention;
    return data;
  }
}

class DownloadResponseSetting {
  String? status;
  String? message;
  int? countData;
  DsetData? data;

  DownloadResponseSetting(
      {this.status, this.message, this.countData, this.data});

  DownloadResponseSetting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new DsetData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DsetData {
  String? base64Data;
  String? fileName;
  Null filePathName;

  DsetData({this.base64Data, this.fileName, this.filePathName});

  DsetData.fromJson(Map<String, dynamic> json) {
    base64Data = json['base64Data'];
    fileName = json['fileName'];
    filePathName = json['filePathName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base64Data'] = this.base64Data;
    data['fileName'] = this.fileName;
    data['filePathName'] = this.filePathName;
    return data;
  }
}

class DeleteRequestSetting {
  List<DelListCode>? listCode;

  DeleteRequestSetting({this.listCode});

  DeleteRequestSetting.fromJson(Map<String, dynamic> json) {
    if (json['listCode'] != null) {
      listCode = <DelListCode>[];
      json['listCode'].forEach((v) {
        listCode!.add(new DelListCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listCode != null) {
      data['listCode'] = this.listCode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DelListCode {
  String? code;

  DelListCode({this.code});

  DelListCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class UploadSettingresponse {
  String? status;
  String? message;
  int? countData;
  List<UploadSettingData>? data;

  UploadSettingresponse({this.status, this.message, this.countData, this.data});

  UploadSettingresponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <UploadSettingData>[];
      json['data'].forEach((v) {
        data!.add(new UploadSettingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UploadSettingData {
  String? message;
  int? row;
  String? settingGroupCd;

  UploadSettingData({this.message, this.row, this.settingGroupCd});

  UploadSettingData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    row = json['row'];
    settingGroupCd = json['settingGroupCd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['row'] = this.row;
    data['settingGroupCd'] = this.settingGroupCd;
    return data;
  }
}
