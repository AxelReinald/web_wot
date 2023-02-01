class RequestSearchComp {
  String? business;
  String? companyCd;
  String? companyName;
  int? pageNumber;
  int? pageSize;

  RequestSearchComp(
      {this.business,
      this.companyCd,
      this.companyName,
      this.pageNumber,
      this.pageSize});

  RequestSearchComp.fromJson(Map<String, dynamic> json) {
    business = json['business'];
    companyCd = json['companyCd'];
    companyName = json['companyName'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business'] = this.business;
    data['companyCd'] = this.companyCd;
    data['companyName'] = this.companyName;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class ResponseSearchComp {
  String? status;
  String? message;
  int? countData;
  List<RespCompData>? data;

  ResponseSearchComp({this.status, this.message, this.countData, this.data});

  ResponseSearchComp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <RespCompData>[];
      json['data'].forEach((v) {
        data!.add(new RespCompData.fromJson(v));
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

class RespCompData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? companyCd;
  String? companyName;
  String? type;
  String? business;
  String? address;
  String? cityId;
  String? companyType;
  String? companyBusiness;
  String? provinceName;

  RespCompData(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.companyCd,
      this.companyName,
      this.type,
      this.business,
      this.address,
      this.cityId,
      this.companyType,
      this.companyBusiness,
      this.provinceName});

  RespCompData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    companyCd = json['companyCd'];
    companyName = json['companyName'];
    type = json['type'];
    business = json['business'];
    address = json['address'];
    cityId = json['cityId'];
    companyType = json['companyType'];
    companyBusiness = json['companyBusiness'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['companyCd'] = this.companyCd;
    data['companyName'] = this.companyName;
    data['type'] = this.type;
    data['business'] = this.business;
    data['address'] = this.address;
    data['cityId'] = this.cityId;
    data['companyType'] = this.companyType;
    data['companyBusiness'] = this.companyBusiness;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class RequestComAdd {
  String? address;
  String? cityCd;
  String? companyBusiness;
  String? companyCd;
  String? companyName;
  String? companyType;

  RequestComAdd(
      {this.address,
      this.cityCd,
      this.companyBusiness,
      this.companyCd,
      this.companyName,
      this.companyType});

  RequestComAdd.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    cityCd = json['cityCd'];
    companyBusiness = json['companyBusiness'];
    companyCd = json['companyCd'];
    companyName = json['companyName'];
    companyType = json['companyType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['cityCd'] = this.cityCd;
    data['companyBusiness'] = this.companyBusiness;
    data['companyCd'] = this.companyCd;
    data['companyName'] = this.companyName;
    data['companyType'] = this.companyType;
    return data;
  }
}

class RequestComDelete {
  List<DelListCode>? listCode;

  RequestComDelete({this.listCode});

  RequestComDelete.fromJson(Map<String, dynamic> json) {
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

class DownlaodRequestComp {
  String? business;
  String? companyCd;
  String? companyName;
  String? extention;

  DownlaodRequestComp(
      {this.business, this.companyCd, this.companyName, this.extention});

  DownlaodRequestComp.fromJson(Map<String, dynamic> json) {
    business = json['business'];
    companyCd = json['companyCd'];
    companyName = json['companyName'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business'] = this.business;
    data['companyCd'] = this.companyCd;
    data['companyName'] = this.companyName;
    data['extention'] = this.extention;
    return data;
  }
}

class DownloadResponseComp {
  String? status;
  String? message;
  int? countData;
  DowncomData? data;

  DownloadResponseComp({this.status, this.message, this.countData, this.data});

  DownloadResponseComp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new DowncomData.fromJson(json['data']) : null;
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

class DowncomData {
  String? base64Data;
  String? fileName;
  Null filePathName;

  DowncomData({this.base64Data, this.fileName, this.filePathName});

  DowncomData.fromJson(Map<String, dynamic> json) {
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

class UploadComresponse {
  String? status;
  String? message;
  int? countData;
  List<UploadComData>? data;

  UploadComresponse({this.status, this.message, this.countData, this.data});

  UploadComresponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <UploadComData>[];
      json['data'].forEach((v) {
        data!.add(new UploadComData.fromJson(v));
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

class UploadComData {
  String? message;
  int? row;
  String? settingGroupCd;

  UploadComData({this.message, this.row, this.settingGroupCd});

  UploadComData.fromJson(Map<String, dynamic> json) {
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

class ResponseDownloadTemplateCom {
  String? status;
  String? message;
  int? countData;
  DownloadTemplateDataCom? data;

  ResponseDownloadTemplateCom(
      {this.status, this.message, this.countData, this.data});

  ResponseDownloadTemplateCom.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null
        ? new DownloadTemplateDataCom.fromJson(json['data'])
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

class DownloadTemplateDataCom {
  String? base64Data;
  String? fileName;
  Null filePathName;

  DownloadTemplateDataCom({this.base64Data, this.fileName, this.filePathName});

  DownloadTemplateDataCom.fromJson(Map<String, dynamic> json) {
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

class ResponseComBusiness {
  String? status;
  String? message;
  int? countData;
  List<BusData>? data;

  ResponseComBusiness({this.status, this.message, this.countData, this.data});

  ResponseComBusiness.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <BusData>[];
      json['data'].forEach((v) {
        data!.add(new BusData.fromJson(v));
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

class BusData {
  String? paramCode;
  String? companyBusiness;

  BusData({this.paramCode, this.companyBusiness});

  BusData.fromJson(Map<String, dynamic> json) {
    paramCode = json['paramCode'];
    companyBusiness = json['companyBusiness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramCode'] = this.paramCode;
    data['companyBusiness'] = this.companyBusiness;
    return data;
  }
}

class ResponseComCity {
  String? status;
  String? message;
  int? countData;
  List<ComCityData>? data;

  ResponseComCity({this.status, this.message, this.countData, this.data});

  ResponseComCity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <ComCityData>[];
      json['data'].forEach((v) {
        data!.add(new ComCityData.fromJson(v));
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

class ComCityData {
  String? cityId;
  String? cityName;
  String? provinceName;

  ComCityData({this.cityId, this.cityName, this.provinceName});

  ComCityData.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    cityName = json['cityName'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class ResponseComType {
  String? status;
  String? message;
  int? countData;
  List<TypeComData>? data;

  ResponseComType({this.status, this.message, this.countData, this.data});

  ResponseComType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <TypeComData>[];
      json['data'].forEach((v) {
        data!.add(new TypeComData.fromJson(v));
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

class TypeComData {
  String? paramCode;
  String? companyType;

  TypeComData({this.paramCode, this.companyType});

  TypeComData.fromJson(Map<String, dynamic> json) {
    paramCode = json['paramCode'];
    companyType = json['companyType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramCode'] = this.paramCode;
    data['companyType'] = this.companyType;
    return data;
  }
}
