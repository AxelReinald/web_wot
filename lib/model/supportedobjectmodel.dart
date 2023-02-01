class RequestSearchSO {
  String? companyName;
  String? objectName;
  String? objectType;
  int? pageNumber;
  int? pageSize;

  RequestSearchSO(
      {this.companyName,
      this.objectName,
      this.objectType,
      this.pageNumber,
      this.pageSize});

  RequestSearchSO.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    objectName = json['objectName'];
    objectType = json['objectType'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['objectName'] = this.objectName;
    data['objectType'] = this.objectType;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class ResponseSearchSO {
  String? status;
  String? message;
  int? countData;
  List<DataSO>? data;

  ResponseSearchSO({this.status, this.message, this.countData, this.data});

  ResponseSearchSO.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <DataSO>[];
      json['data'].forEach((v) {
        data!.add(new DataSO.fromJson(v));
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

class DataSO {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? objectCode;
  String? objectName;
  String? objectTypeCode;
  String? objectTypeName;
  String? description;
  String? companyName;
  String? companyId;

  DataSO(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.objectCode,
      this.objectName,
      this.objectTypeCode,
      this.objectTypeName,
      this.description,
      this.companyName,
      this.companyId});

  DataSO.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    objectCode = json['objectCode'];
    objectName = json['objectName'];
    objectTypeCode = json['objectTypeCode'];
    objectTypeName = json['objectTypeName'];
    description = json['description'];
    companyName = json['companyName'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['objectCode'] = this.objectCode;
    data['objectName'] = this.objectName;
    data['objectTypeCode'] = this.objectTypeCode;
    data['objectTypeName'] = this.objectTypeName;
    data['description'] = this.description;
    data['companyName'] = this.companyName;
    data['companyId'] = this.companyId;
    return data;
  }
}

class RequestSOAdd {
  String? companyId;
  String? description;
  String? objectCode;
  String? objectName;
  String? objectType;

  RequestSOAdd(
      {this.companyId,
      this.description,
      this.objectCode,
      this.objectName,
      this.objectType});

  RequestSOAdd.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    description = json['description'];
    objectCode = json['objectCode'];
    objectName = json['objectName'];
    objectType = json['objectType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['description'] = this.description;
    data['objectCode'] = this.objectCode;
    data['objectName'] = this.objectName;
    data['objectType'] = this.objectType;
    return data;
  }
}

class ResponseSOAdd {
  String? status;
  String? message;
  int? countData;
  SoAddData? data;

  ResponseSOAdd({this.status, this.message, this.countData, this.data});

  ResponseSOAdd.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new SoAddData.fromJson(json['data']) : null;
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

class SoAddData {
  String? recordFlag;
  String? createdBy;
  String? createdTime;
  Null? updatedBy;
  Null? updatedTime;
  int? objectId;
  String? objectCode;
  String? objectName;
  String? objectType;
  String? description;
  int? companyId;

  SoAddData(
      {this.recordFlag,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.objectId,
      this.objectCode,
      this.objectName,
      this.objectType,
      this.description,
      this.companyId});

  SoAddData.fromJson(Map<String, dynamic> json) {
    recordFlag = json['recordFlag'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    objectId = json['objectId'];
    objectCode = json['objectCode'];
    objectName = json['objectName'];
    objectType = json['objectType'];
    description = json['description'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordFlag'] = this.recordFlag;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['objectId'] = this.objectId;
    data['objectCode'] = this.objectCode;
    data['objectName'] = this.objectName;
    data['objectType'] = this.objectType;
    data['description'] = this.description;
    data['companyId'] = this.companyId;
    return data;
  }
}

class ResponseSOGetType {
  String? status;
  String? message;
  Null? countData;
  List<GetSOData>? data;

  ResponseSOGetType({this.status, this.message, this.countData, this.data});

  ResponseSOGetType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <GetSOData>[];
      json['data'].forEach((v) {
        data!.add(new GetSOData.fromJson(v));
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

class GetSOData {
  String? objectTypeCode;
  String? objectTypeName;

  GetSOData({this.objectTypeCode, this.objectTypeName});

  GetSOData.fromJson(Map<String, dynamic> json) {
    objectTypeCode = json['objectTypeCode'];
    objectTypeName = json['objectTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectTypeCode'] = this.objectTypeCode;
    data['objectTypeName'] = this.objectTypeName;
    return data;
  }
}

class ResponseSOGetCom {
  String? status;
  String? message;
  int? countData;
  List<ComData>? data;

  ResponseSOGetCom({this.status, this.message, this.countData, this.data});

  ResponseSOGetCom.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <ComData>[];
      json['data'].forEach((v) {
        data!.add(new ComData.fromJson(v));
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

class ComData {
  String? companyId;
  String? companyName;

  ComData({this.companyId, this.companyName});

  ComData.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    return data;
  }
}

class RequestDeleteSO {
  List<DelListCode>? listCode;

  RequestDeleteSO({this.listCode});

  RequestDeleteSO.fromJson(Map<String, dynamic> json) {
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

class ResponseTempData {
  String? status;
  String? message;
  Null? countData;
  TempData? data;

  ResponseTempData({this.status, this.message, this.countData, this.data});

  ResponseTempData.fromJson(Map<String, dynamic> json) {
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

class DownloadRequestSO {
  String? objectType;
  String? objectName;
  String? companyName;
  String? extention;

  DownloadRequestSO(
      {this.objectType, this.objectName, this.companyName, this.extention});

  DownloadRequestSO.fromJson(Map<String, dynamic> json) {
    objectType = json['objectType'];
    objectName = json['objectName'];
    companyName = json['companyName'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectType'] = this.objectType;
    data['objectName'] = this.objectName;
    data['companyName'] = this.companyName;
    data['extention'] = this.extention;
    return data;
  }
}

class ResponseDownloadSO {
  String? status;
  String? message;
  Null? countData;
  DownDataSO? data;

  ResponseDownloadSO({this.status, this.message, this.countData, this.data});

  ResponseDownloadSO.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new DownDataSO.fromJson(json['data']) : null;
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

class DownDataSO {
  String? base64Data;
  String? fileName;
  Null? filePathName;

  DownDataSO({this.base64Data, this.fileName, this.filePathName});

  DownDataSO.fromJson(Map<String, dynamic> json) {
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

class ResponseUploadSO {
  String? status;
  String? message;
  Null? countData;
  List<String>? data;

  ResponseUploadSO({this.status, this.message, this.countData, this.data});

  ResponseUploadSO.fromJson(Map<String, dynamic> json) {
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
