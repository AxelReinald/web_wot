class RequestSetting {
  String? groupCd;
  String? groupName;
  int? pageNumber;
  int? pageSize;

  RequestSetting(
      {this.groupCd, this.groupName, this.pageNumber, this.pageSize});

  RequestSetting.fromJson(Map<String, dynamic> json) {
    groupCd = json['groupCd'];
    groupName = json['groupName'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupCd'] = groupCd == null ? '' : groupCd.toString();
    data['groupName'] = groupName == null ? '' : groupName.toString();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class AddRequestSettings {
  String? groupCd;
  String? groupDesc;
  String? groupName;

  AddRequestSettings({this.groupCd, this.groupDesc, this.groupName});

  AddRequestSettings.fromJson(Map<String, dynamic> json) {
    groupCd = json['groupCd'];
    groupDesc = json['groupDesc'];
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupCd'] = this.groupCd;
    data['groupDesc'] = this.groupDesc;
    data['groupName'] = this.groupName;
    return data;
  }
}

class ResponseSetting {
  String? status;
  String? message;
  int? countData;
  List<RData>? data;

  ResponseSetting({this.status, this.message, this.countData, this.data});

  ResponseSetting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <RData>[];
      json['data'].forEach((v) {
        data!.add(new RData.fromJson(v));
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

class RData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? settingGroupCode;
  String? settingGroupName;
  String? settingGroupDesc;

  RData(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.settingGroupCode,
      this.settingGroupName,
      this.settingGroupDesc});

  RData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
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

class DeleteRequestSettings {
  List<ListCode>? listCode;

  DeleteRequestSettings({this.listCode});

  DeleteRequestSettings.fromJson(Map<String, dynamic> json) {
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

class DeleteResponseSetting {
  String? status;
  String? message;
  int? countData;
  Data? data;

  DeleteResponseSetting({this.status, this.message, this.countData, this.data});

  DeleteResponseSetting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Null? status;
  String? message;
  Null? countData;
  List<String>? data;

  Data({this.status, this.message, this.countData, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countData'] = this.countData;
    data['data'] = this.data;
    return data;
  }
}

//Request Download
class DownloadRequestSettings {
  String? groupCd;
  String? groupName;
  String? extention;

  DownloadRequestSettings({this.groupCd, this.groupName, this.extention});

  DownloadRequestSettings.fromJson(Map<String, dynamic> json) {
    groupCd = json['groupCd'];
    groupName = json['groupName'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupCd'] = this.groupCd;
    data['groupName'] = this.groupName;
    data['extention'] = this.extention;
    return data;
  }
}

//Response Download
class DownloadResponseSettingGroup {
  String? status;
  String? message;
  int? countData;
  DownData? data;

  DownloadResponseSettingGroup(
      {this.status, this.message, this.countData, this.data});

  DownloadResponseSettingGroup.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DownData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
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

class DownData {
  String? base64Data;
  String? fileName;
  String? filePathName;

  DownData({this.base64Data, this.fileName, this.filePathName});

  DownData.fromJson(Map<String, dynamic> json) {
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

class Uploadresponse {
  String? status;
  String? message;
  int? countData;
  List<UploadData>? data;

  Uploadresponse({this.status, this.message, this.countData, this.data});

  Uploadresponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <UploadData>[];
      json['data'].forEach((v) {
        data!.add(new UploadData.fromJson(v));
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

class UploadData {
  String? message;
  int? row;
  String? settingGroupCd;

  UploadData({this.message, this.row, this.settingGroupCd});

  UploadData.fromJson(Map<String, dynamic> json) {
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
