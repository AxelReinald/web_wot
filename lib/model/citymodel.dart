class RequestCitySearch {
  String? cityCd;
  String? cityName;
  int? pageNumber;
  int? pageSize;
  String? provinceId;

  RequestCitySearch(
      {this.cityCd,
      this.cityName,
      this.pageNumber,
      this.pageSize,
      this.provinceId});

  RequestCitySearch.fromJson(Map<String, dynamic> json) {
    cityCd = json['cityCd'];
    cityName = json['cityName'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    provinceId = json['provinceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityCd'] = this.cityCd;
    data['cityName'] = this.cityName;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['provinceId'] = this.provinceId;
    return data;
  }
}

class ResponseCitySearch {
  String? status;
  String? message;
  int? countData;
  List<CityData>? data;

  ResponseCitySearch({this.status, this.message, this.countData, this.data});

  ResponseCitySearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(new CityData.fromJson(v));
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

class CityData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? provinceCode;
  String? cityCd;
  String? cityName;
  String? provinceId;

  CityData(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.provinceCode,
      this.cityCd,
      this.cityName,
      this.provinceId});

  CityData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    provinceCode = json['provinceCode'];
    cityCd = json['cityCd'];
    cityName = json['cityName'];
    provinceId = json['provinceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['provinceCode'] = this.provinceCode;
    data['cityCd'] = this.cityCd;
    data['cityName'] = this.cityName;
    data['provinceId'] = this.provinceId;
    return data;
  }
}

class ResponseGetProvince {
  String? status;
  String? message;
  int? countData;
  List<GetProData>? data;

  ResponseGetProvince({this.status, this.message, this.countData, this.data});

  ResponseGetProvince.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <GetProData>[];
      json['data'].forEach((v) {
        data!.add(new GetProData.fromJson(v));
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

class GetProData {
  String? provinceId;
  String? provinceName;

  GetProData({this.provinceId, this.provinceName});

  GetProData.fromJson(Map<String, dynamic> json) {
    provinceId = json['provinceId'];
    provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceId'] = this.provinceId;
    data['provinceName'] = this.provinceName;
    return data;
  }
}

class RequestAddCity {
  String? cityCd;
  String? cityName;
  String? provinceId;

  RequestAddCity({this.cityCd, this.cityName, this.provinceId});

  RequestAddCity.fromJson(Map<String, dynamic> json) {
    cityCd = json['cityCd'];
    cityName = json['cityName'];
    provinceId = json['provinceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityCd'] = this.cityCd;
    data['cityName'] = this.cityName;
    data['provinceId'] = this.provinceId;
    return data;
  }
}

class RequestDeleteCity {
  List<DelCityListCode>? listCode;

  RequestDeleteCity({this.listCode});

  RequestDeleteCity.fromJson(Map<String, dynamic> json) {
    if (json['listCode'] != null) {
      listCode = <DelCityListCode>[];
      json['listCode'].forEach((v) {
        listCode!.add(new DelCityListCode.fromJson(v));
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

class DelCityListCode {
  String? code;

  DelCityListCode({this.code});

  DelCityListCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class DownloadRequestCity {
  String? provinceCd;
  String? cityCd;
  String? cityName;
  String? extention;

  DownloadRequestCity(
      {this.provinceCd, this.cityCd, this.cityName, this.extention});

  DownloadRequestCity.fromJson(Map<String, dynamic> json) {
    provinceCd = json['provinceCd'];
    cityCd = json['cityCd'];
    cityName = json['cityName'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceCd'] = this.provinceCd;
    data['cityCd'] = this.cityCd;
    data['cityName'] = this.cityName;
    data['extention'] = this.extention;
    return data;
  }
}

class ResponseDownloadCity {
  String? status;
  String? message;
  int? countData;
  DownCityData? data;

  ResponseDownloadCity({this.status, this.message, this.countData, this.data});

  ResponseDownloadCity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data =
        json['data'] != null ? new DownCityData.fromJson(json['data']) : null;
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

class DownCityData {
  String? base64Data;
  String? fileName;
  Null? filePathName;

  DownCityData({this.base64Data, this.fileName, this.filePathName});

  DownCityData.fromJson(Map<String, dynamic> json) {
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

class ResponseTemplateCity {
  String? status;
  String? message;
  int? countData;
  TempData? data;

  ResponseTemplateCity({this.status, this.message, this.countData, this.data});

  ResponseTemplateCity.fromJson(Map<String, dynamic> json) {
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

class ResponseUploadCity {
  String? status;
  String? message;
  int? countData;
  List<UploadCityData>? data;

  ResponseUploadCity({this.status, this.message, this.countData, this.data});

  ResponseUploadCity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <UploadCityData>[];
      json['data'].forEach((v) {
        data!.add(new UploadCityData.fromJson(v));
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

class UploadCityData {
  String? message;
  int? row;

  UploadCityData({this.message, this.row});

  UploadCityData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    row = json['row'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['row'] = this.row;
    return data;
  }
}
