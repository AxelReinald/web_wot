class RequestMenuSearch {
  String? menuCd;
  String? menuName;
  int? pageNumber;
  int? pageSize;
  String? parent;

  RequestMenuSearch(
      {this.menuCd,
      this.menuName,
      this.pageNumber,
      this.pageSize,
      this.parent});

  RequestMenuSearch.fromJson(Map<String, dynamic> json) {
    menuCd = json['menuCd'];
    menuName = json['menuName'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuCd'] = this.menuCd;
    data['menuName'] = this.menuName;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['parent'] = this.parent;
    return data;
  }
}

class ResponseMenuSearch {
  String? status;
  String? message;
  int? pageNo;
  int? pageSize;
  int? totalDataInPage;
  int? totalData;
  int? totalPages;
  List<RespSearchData>? data;

  ResponseMenuSearch(
      {this.status,
      this.message,
      this.pageNo,
      this.pageSize,
      this.totalDataInPage,
      this.totalData,
      this.totalPages,
      this.data});

  ResponseMenuSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pageNo = json['pageNo'];
    pageSize = json['pageSize'];
    totalDataInPage = json['totalDataInPage'];
    totalData = json['totalData'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = <RespSearchData>[];
      json['data'].forEach((v) {
        data!.add(new RespSearchData.fromJson(v));
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

class RespSearchData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? menuCd;
  String? menuName;
  String? parent;
  String? type;
  String? url;

  RespSearchData(
      {this.isChecked,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.menuCd,
      this.menuName,
      this.parent,
      this.type,
      this.url});

  RespSearchData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    menuCd = json['menuCd'];
    menuName = json['menuName'];
    parent = json['parent'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['menuCd'] = this.menuCd;
    data['menuName'] = this.menuName;
    data['parent'] = this.parent;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class RequestMenuAdd {
  String? menuCd;
  String? menuName;
  String? parent;
  String? type;
  String? url;

  RequestMenuAdd(
      {this.menuCd, this.menuName, this.parent, this.type, this.url});

  RequestMenuAdd.fromJson(Map<String, dynamic> json) {
    menuCd = json['menuCd'];
    menuName = json['menuName'];
    parent = json['parent'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuCd'] = this.menuCd;
    data['menuName'] = this.menuName;
    data['parent'] = this.parent;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class ResponseGetParent {
  String? status;
  String? message;
  Null? countData;
  List<ParentData>? data;

  ResponseGetParent({this.status, this.message, this.countData, this.data});

  ResponseGetParent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <ParentData>[];
      json['data'].forEach((v) {
        data!.add(new ParentData.fromJson(v));
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

class ParentData {
  String? menuId;
  String? menuName;

  ParentData({this.menuId, this.menuName});

  ParentData.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    menuName = json['menuName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuId'] = this.menuId;
    data['menuName'] = this.menuName;
    return data;
  }
}

class DownloadReq {
  String? menuCd;
  String? menuName;
  String? parent;
  String? extention;

  DownloadReq({this.menuCd, this.menuName, this.parent, this.extention});

  DownloadReq.fromJson(Map<String, dynamic> json) {
    menuCd = json['menuCd'];
    menuName = json['menuName'];
    parent = json['parent'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuCd'] = this.menuCd;
    data['menuName'] = this.menuName;
    data['parent'] = this.parent;
    data['extention'] = this.extention;
    return data;
  }
}

class DownloadResponse {
  String? status;
  String? message;
  Null? countData;
  DownData? data;

  DownloadResponse({this.status, this.message, this.countData, this.data});

  DownloadResponse.fromJson(Map<String, dynamic> json) {
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

class DownloadTemplateResp {
  String? status;
  String? message;
  Null? countData;
  TempData? data;

  DownloadTemplateResp({this.status, this.message, this.countData, this.data});

  DownloadTemplateResp.fromJson(Map<String, dynamic> json) {
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

class RequestMenuDel {
  List<DelListCode>? listCode;

  RequestMenuDel({this.listCode});

  RequestMenuDel.fromJson(Map<String, dynamic> json) {
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

class ResponseUploadMenu {
  String? status;
  String? message;
  Null? countData;
  List<String>? data;

  ResponseUploadMenu({this.status, this.message, this.countData, this.data});

  ResponseUploadMenu.fromJson(Map<String, dynamic> json) {
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
