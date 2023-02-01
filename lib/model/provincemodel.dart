class ProvinceRequestSearch {
  int? pageNumber;
  int? pageSize;
  String? provinceCd;
  String? provinceName;

  ProvinceRequestSearch(
      {this.pageNumber, this.pageSize, this.provinceCd, this.provinceName});

  ProvinceRequestSearch.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    provinceCd = json['provinceCd'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['provinceCd'] = this.provinceCd;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class ProvinceResponseSearch {
  String? status;
  String? message;
  int? countData;
  List<ProData>? data;

  ProvinceResponseSearch(
      {this.status, this.message, this.countData, this.data});

  ProvinceResponseSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <ProData>[];
      json['data'].forEach((v) {
        data!.add(new ProData.fromJson(v));
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

class ProData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? provinceCd;
  String? provinceName;

  ProData(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.provinceCd,
      this.provinceName,
      this.isChecked});

  ProData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    provinceCd = json['provinceCd'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['provinceCd'] = this.provinceCd;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class ProvinceResponseAdd {
  String? status;
  String? message;
  int? countData;
  AddProData? data;

  ProvinceResponseAdd({this.status, this.message, this.countData, this.data});

  ProvinceResponseAdd.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new AddProData.fromJson(json['data']) : null;
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

class AddProData {
  String? recordFlag;
  String? createdBy;
  String? createdTime;
  Null? updatedBy;
  Null? updatedTime;
  int? provinceId;
  String? provinceCd;
  String? provinceName;

  AddProData(
      {this.recordFlag,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.provinceId,
      this.provinceCd,
      this.provinceName});

  AddProData.fromJson(Map<String, dynamic> json) {
    recordFlag = json['recordFlag'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    provinceId = json['provinceId'];
    provinceCd = json['provinceCd'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordFlag'] = this.recordFlag;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['provinceId'] = this.provinceId;
    data['provinceCd'] = this.provinceCd;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class ProvinceRequestAdd {
  String? provinceCd;
  String? provinceName;

  ProvinceRequestAdd({this.provinceCd, this.provinceName});

  ProvinceRequestAdd.fromJson(Map<String, dynamic> json) {
    provinceCd = json['provinceCd'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceCd'] = this.provinceCd;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class ProvinceRequestEdit {
  String? provinceCd;
  String? provinceName;

  ProvinceRequestEdit({this.provinceCd, this.provinceName});

  ProvinceRequestEdit.fromJson(Map<String, dynamic> json) {
    provinceCd = json['provinceCd'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceCd'] = this.provinceCd;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class ProvinceResponseEdit {
  String? status;
  String? message;
  int? countData;
  EditProData? data;

  ProvinceResponseEdit({this.status, this.message, this.countData, this.data});

  ProvinceResponseEdit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new EditProData.fromJson(json['data']) : null;
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

class EditProData {
  String? recordFlag;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  int? provinceId;
  String? provinceCd;
  String? provinceName;

  EditProData(
      {this.recordFlag,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.provinceId,
      this.provinceCd,
      this.provinceName});

  EditProData.fromJson(Map<String, dynamic> json) {
    recordFlag = json['recordFlag'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    provinceId = json['provinceId'];
    provinceCd = json['provinceCd'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordFlag'] = this.recordFlag;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['provinceId'] = this.provinceId;
    data['provinceCd'] = this.provinceCd;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class ProvinceRequestDelete {
  List<ListCode>? listCode;

  ProvinceRequestDelete({this.listCode});

  ProvinceRequestDelete.fromJson(Map<String, dynamic> json) {
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

class DownloadRequestPro {
  String? provinceCd;
  String? provinceName;
  String? extention;

  DownloadRequestPro({this.provinceCd, this.provinceName, this.extention});

  DownloadRequestPro.fromJson(Map<String, dynamic> json) {
    provinceCd = json['provinceCd'];
    provinceName = json['provinceName'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceCd'] = this.provinceCd;
    data['provinceName'] = this.provinceName;
    data['extention'] = this.extention;
    return data;
  }
}

class ProvinceRespDownload {
  String? status;
  String? message;
  int? countData;
  ProDownData? data;

  ProvinceRespDownload({this.status, this.message, this.countData, this.data});

  ProvinceRespDownload.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new ProDownData.fromJson(json['data']) : null;
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

class ProDownData {
  String? base64Data;
  String? fileName;
  Null? filePathName;

  ProDownData({this.base64Data, this.fileName, this.filePathName});

  ProDownData.fromJson(Map<String, dynamic> json) {
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

class ProvinceRespTemplate {
  String? status;
  String? message;
  int? countData;
  TemplateData? data;

  ProvinceRespTemplate({this.status, this.message, this.countData, this.data});

  ProvinceRespTemplate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data =
        json['data'] != null ? new TemplateData.fromJson(json['data']) : null;
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

class TemplateData {
  String? base64Data;
  String? fileName;
  Null? filePathName;

  TemplateData({this.base64Data, this.fileName, this.filePathName});

  TemplateData.fromJson(Map<String, dynamic> json) {
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

class UploadProResponse {
  String? status;
  String? message;
  int? countData;
  List<UploadProData>? data;

  UploadProResponse({this.status, this.message, this.countData, this.data});

  UploadProResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <UploadProData>[];
      json['data'].forEach((v) {
        data!.add(new UploadProData.fromJson(v));
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

class UploadProData {
  String? message;
  int? row;
  String? settingGroupCd;

  UploadProData({this.message, this.row, this.settingGroupCd});

  UploadProData.fromJson(Map<String, dynamic> json) {
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
