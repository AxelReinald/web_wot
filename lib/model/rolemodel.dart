class RequestRoleSearch {
  String? roleCode;
  String? roleName;
  int? pageNumber;
  int? pageSize;

  RequestRoleSearch(
      {this.roleCode, this.roleName, this.pageNumber, this.pageSize});

  RequestRoleSearch.fromJson(Map<String, dynamic> json) {
    roleCode = json['roleCode'];
    roleName = json['roleName'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleCode'] = this.roleCode;
    data['roleName'] = this.roleName;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class ResponseRoleSearch {
  String? status;
  String? message;
  int? pageNo;
  int? pageSize;
  int? totalDataInPage;
  int? totalData;
  int? totalPages;
  List<RespData>? data;

  ResponseRoleSearch(
      {this.status,
      this.message,
      this.pageNo,
      this.pageSize,
      this.totalDataInPage,
      this.totalData,
      this.totalPages,
      this.data});

  ResponseRoleSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pageNo = json['pageNo'];
    pageSize = json['pageSize'];
    totalDataInPage = json['totalDataInPage'];
    totalData = json['totalData'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <RespData>[];
      json['data'].forEach((v) {
        data!.add(new RespData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['pageNo'] = this.pageNo;
    data['pageSize'] = this.pageSize;
    data['totalDataInPage'] = this.totalDataInPage;
    data['totalData'] = this.totalData;
    data['totalPages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RespData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? roleCode;
  String? roleName;
  String? roleType;
  String? roleDesc;

  RespData(
      {this.isChecked,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.roleCode,
      this.roleName,
      this.roleType,
      this.roleDesc});

  RespData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    roleCode = json['roleCode'];
    roleName = json['roleName'];
    roleType = json['roleType'];
    roleDesc = json['roleDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['roleCode'] = this.roleCode;
    data['roleName'] = this.roleName;
    data['roleType'] = this.roleType;
    data['roleDesc'] = this.roleDesc;
    return data;
  }
}

class RequestRoleAdd {
  String? roleCode;
  String? roleName;
  String? roleType;
  String? roleDesc;

  RequestRoleAdd({this.roleCode, this.roleName, this.roleType, this.roleDesc});

  RequestRoleAdd.fromJson(Map<String, dynamic> json) {
    roleCode = json['roleCode'];
    roleName = json['roleName'];
    roleType = json['roleType'];
    roleDesc = json['roleDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleCode'] = this.roleCode;
    data['roleName'] = this.roleName;
    data['roleType'] = this.roleType;
    data['roleDesc'] = this.roleDesc;
    return data;
  }
}

class RequestRoleDelete {
  List<DelListCode>? listCode;

  RequestRoleDelete({this.listCode});

  RequestRoleDelete.fromJson(Map<String, dynamic> json) {
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

class ResponseRoleTemp {
  String? status;
  String? message;
  Null? countData;
  TempData? data;

  ResponseRoleTemp({this.status, this.message, this.countData, this.data});

  ResponseRoleTemp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new TempData.fromJson(json['data']) : null;
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

class TempData {
  String? base64Data;
  String? fileName;
  Null? filePathName;

  TempData({this.base64Data, this.fileName, this.filePathName});

  TempData.fromJson(Map<String, dynamic> json) {
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

class ResponseDownload {
  String? status;
  String? message;
  Null? countData;
  DownData? data;

  ResponseDownload({this.status, this.message, this.countData, this.data});

  ResponseDownload.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new DownData.fromJson(json['data']) : null;
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
  Null? filePathName;

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

class ResponseUploadRole {
  String? status;
  String? message;
  Null? countData;
  List<String>? data;

  ResponseUploadRole({this.status, this.message, this.countData, this.data});

  ResponseUploadRole.fromJson(Map<String, dynamic> json) {
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

class DownloadReq {
  String? roleCode;
  String? roleName;
  String? extention;

  DownloadReq({this.roleCode, this.roleName, this.extention});

  DownloadReq.fromJson(Map<String, dynamic> json) {
    roleCode = json['roleCode'];
    roleName = json['roleName'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleCode'] = this.roleCode;
    data['roleName'] = this.roleName;
    data['extention'] = this.extention;
    return data;
  }
}
