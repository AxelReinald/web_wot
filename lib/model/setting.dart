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
