class requestSetting {
  String? groupCd;
  String? groupName;
  int? pageNumber;
  int? pageSize;

  requestSetting(
      {this.groupCd, this.groupName, this.pageNumber, this.pageSize});

  requestSetting.fromJson(Map<String, dynamic> json) {
    groupCd = json['groupCd'];
    groupName = json['groupName'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupCd'] = groupCd == null ? '' : groupCd.toString();
    data['groupName'] = groupName == null ? '' : groupName.toString();
    data['pageNumber'] = 0;
    data['pageSize'] = 10;
    return data;
  }
}

class responseSetting {
  String? createdBy;
  String? createdTime;
  Null? updatedBy;
  String? updatedTime;
  String? settingGroupCode;
  String? settingGroupName;
  String? settingGroupDesc;

  responseSetting(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.settingGroupCode,
      this.settingGroupName,
      this.settingGroupDesc});

  responseSetting.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    settingGroupCode = json['settingGroupCode'];
    settingGroupName = json['settingGroupName'];
    settingGroupDesc = json['settingGroupDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['settingGroupCode'] = this.settingGroupCode;
    data['settingGroupName'] = this.settingGroupName;
    data['settingGroupDesc'] = this.settingGroupDesc;
    return data;
  }
}
