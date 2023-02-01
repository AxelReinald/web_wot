class RequestSuppicSearch {
  String? company;
  int? pageNumber;
  int? pageSize;
  String? picEmail;
  String? picName;

  RequestSuppicSearch(
      {this.company,
      this.pageNumber,
      this.pageSize,
      this.picEmail,
      this.picName});

  RequestSuppicSearch.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    picEmail = json['picEmail'];
    picName = json['picName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['picEmail'] = this.picEmail;
    data['picName'] = this.picName;
    return data;
  }
}

class ResponseSuppicSearch {
  String? status;
  String? message;
  CountData? countData;
  List<PICData>? data;

  ResponseSuppicSearch({this.status, this.message, this.countData, this.data});

  ResponseSuppicSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'] != null
        ? new CountData.fromJson(json['countData'])
        : null;
    if (json['data'] != null) {
      data = <PICData>[];
      json['data'].forEach((v) {
        data!.add(new PICData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.countData != null) {
      data['countData'] = this.countData!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountData {
  int? pageNumber;
  int? pageSize;
  int? totalDataPage;
  int? startData;
  int? endData;
  int? totalData;
  int? totalPage;

  CountData(
      {this.pageNumber,
      this.pageSize,
      this.totalDataPage,
      this.startData,
      this.endData,
      this.totalData,
      this.totalPage});

  CountData.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalDataPage = json['totalDataPage'];
    startData = json['startData'];
    endData = json['endData'];
    totalData = json['totalData'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['totalDataPage'] = this.totalDataPage;
    data['startData'] = this.startData;
    data['endData'] = this.endData;
    data['totalData'] = this.totalData;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class PICData {
  bool? isChecked;
  int? companyId;
  String? companyCode;
  String? companyName;
  List<String>? pic;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  PICData(
      {this.isChecked,
      this.companyId,
      this.companyCode,
      this.companyName,
      this.pic,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime});

  PICData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    companyId = json['companyId'];
    companyCode = json['companyCode'];
    companyName = json['companyName'];
    pic = json['pic'].cast<String>();
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['companyCode'] = this.companyCode;
    data['companyName'] = this.companyName;
    data['pic'] = this.pic;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    return data;
  }
}

class DownloadRequestPic {
  String? company;
  String? picEmail;
  String? picName;
  String? extension;

  DownloadRequestPic(
      [this.company, this.picEmail, this.picName, this.extension]);

  DownloadRequestPic.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    picEmail = json['picEmail'];
    picName = json['picName'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company'] = this.company;
    data['picEmail'] = this.picEmail;
    data['picName'] = this.picName;
    data['extension'] = this.extension;
    return data;
  }
}

class ResponsePicDownload {
  String? status;
  String? message;
  Null? countData;
  DownloadPicData? data;

  ResponsePicDownload({this.status, this.message, this.countData, this.data});

  ResponsePicDownload.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null
        ? new DownloadPicData.fromJson(json['data'])
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

class DownloadPicData {
  String? base64Data;
  String? fileName;
  Null? filePathName;

  DownloadPicData({this.base64Data, this.fileName, this.filePathName});

  DownloadPicData.fromJson(Map<String, dynamic> json) {
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

class AddPIC {
  bool? isChecked;
  String? email;
  String? mobileNo;
  String? name;
  AddPIC({this.isChecked, this.email, this.mobileNo, this.name});
}

class ResponseGetPIC {
  String? status;
  String? message;
  Null? countData;
  GetRespPICData? data;

  ResponseGetPIC({this.status, this.message, this.countData, this.data});

  ResponseGetPIC.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data =
        json['data'] != null ? new GetRespPICData.fromJson(json['data']) : null;
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

class GetRespPICData {
  int? companyId;
  String? companyCode;
  String? companyName;
  List<Pic>? pic;
  dynamic createdBy;
  dynamic createdTime;
  dynamic updatedBy;
  dynamic updatedTime;

  GetRespPICData(
      {this.companyId,
      this.companyCode,
      this.companyName,
      this.pic,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime});

  GetRespPICData.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyCode = json['companyCode'];
    companyName = json['companyName'];
    if (json['pic'] != null) {
      pic = <Pic>[];
      json['pic'].forEach((v) {
        pic!.add(new Pic.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['companyCode'] = this.companyCode;
    data['companyName'] = this.companyName;
    if (this.pic != null) {
      data['pic'] = this.pic!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    return data;
  }
}

class Pic {
  bool? isChecked;
  int? picId;
  String? name;
  String? mobileNo;
  String? email;

  Pic({this.isChecked, this.picId, this.name, this.mobileNo, this.email});

  Pic.fromJson(Map<String, dynamic> json) {
    picId = json['picId'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picId'] = this.picId;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['email'] = this.email;
    return data;
  }
}

class ResponseGetAuto {
  String? status;
  String? message;
  Null? countData;
  List<AutoData>? data;

  ResponseGetAuto({this.status, this.message, this.countData, this.data});

  ResponseGetAuto.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <AutoData>[];
      json['data'].forEach((v) {
        data!.add(new AutoData.fromJson(v));
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

class AutoData {
  bool? isChecked;
  String? recordFlag;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  int? picId;
  String? email;
  String? mobileNo;
  String? fullName;

  AutoData(
      {this.isChecked,
      this.recordFlag,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.picId,
      this.email,
      this.mobileNo,
      this.fullName});

  AutoData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    recordFlag = json['recordFlag'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    picId = json['picId'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordFlag'] = this.recordFlag;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['picId'] = this.picId;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['fullName'] = this.fullName;
    return data;
  }
}

class RequestAddPic {
  int? companyId;
  List<AddNewPic>? pic;

  RequestAddPic({this.companyId, this.pic});

  RequestAddPic.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    if (json['pic'] != null) {
      pic = <AddNewPic>[];
      json['pic'].forEach((v) {
        pic!.add(new AddNewPic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    if (this.pic != null) {
      data['pic'] = this.pic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddNewPic {
  bool? isChecked;
  String? email;
  String? mobileNo;
  String? name;
  int? picId;

  AddNewPic({this.isChecked, this.email, this.mobileNo, this.name, this.picId});

  AddNewPic.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    email = json['email'];
    mobileNo = json['mobileNo'];
    name = json['name'];
    picId = json['picId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['name'] = this.name;
    data['picId'] = this.picId;
    return data;
  }
}

class ResponseAddPic {
  String? status;
  String? message;
  Null? countData;
  NewData? data;

  ResponseAddPic({this.status, this.message, this.countData, this.data});

  ResponseAddPic.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new NewData.fromJson(json['data']) : null;
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

class NewData {
  int? companyId;
  List<RespAddPic>? pic;

  NewData({this.companyId, this.pic});

  NewData.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    if (json['pic'] != null) {
      pic = <RespAddPic>[];
      json['pic'].forEach((v) {
        pic!.add(new RespAddPic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    if (this.pic != null) {
      data['pic'] = this.pic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RespAddPic {
  String? email;
  String? mobileNo;
  String? name;
  int? picId;

  RespAddPic({this.email, this.mobileNo, this.name, this.picId});

  RespAddPic.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobileNo = json['mobileNo'];
    name = json['name'];
    picId = json['picId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['name'] = this.name;
    data['picId'] = this.picId;
    return data;
  }
}
