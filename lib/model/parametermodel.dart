class RequestParameterSearch {
  int? pageNumber;
  int? pageSize;
  String? param;
  String? paramGroupCode;
  String? paramGroupName;

  RequestParameterSearch(
      {this.pageNumber,
      this.pageSize,
      this.param,
      this.paramGroupCode,
      this.paramGroupName});

  RequestParameterSearch.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    param = json['param'];
    paramGroupCode = json['paramGroupCode'];
    paramGroupName = json['paramGroupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['param'] = this.param;
    data['paramGroupCode'] = this.paramGroupCode;
    data['paramGroupName'] = this.paramGroupName;
    return data;
  }
}

class ResponseParameterSearch {
  String? status;
  String? message;
  int? countData;
  List<ParamData>? data;

  ResponseParameterSearch(
      {this.status, this.message, this.countData, this.data});

  ResponseParameterSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    if (json['data'] != null) {
      data = <ParamData>[];
      json['data'].forEach((v) {
        data!.add(new ParamData.fromJson(v));
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

class ParamData {
  bool? isChecked;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  String? paramGroupCode;
  String? paramGroupName;
  String? paramName;
  List<ListParameter>? listParameter;

  ParamData(
      {this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime,
      this.paramGroupCode,
      this.paramGroupName,
      this.paramName,
      this.listParameter});

  ParamData.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
    paramGroupCode = json['paramGroupCode'];
    paramGroupName = json['paramGroupName'];
    paramName = json['paramName'];
    if (json['listParameter'] != null) {
      listParameter = <ListParameter>[];
      json['listParameter'].forEach((v) {
        listParameter!.add(new ListParameter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    data['paramGroupCode'] = this.paramGroupCode;
    data['paramGroupName'] = this.paramGroupName;
    data['paramName'] = this.paramName;
    if (this.listParameter != null) {
      data['listParameter'] =
          this.listParameter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListParameter {
  bool? isChecked;
  String? paramCode;
  String? paramName;
  String? paramDesc;

  ListParameter(
      {this.isChecked, this.paramCode, this.paramName, this.paramDesc});

  ListParameter.fromJson(Map<String, dynamic> json) {
    paramCode = json['paramCode'];
    paramName = json['paramName'];
    paramDesc = json['paramDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramCode'] = this.paramCode;
    data['paramName'] = this.paramName;
    data['paramDesc'] = this.paramDesc;
    return data;
  }
}

class ResponseParameterDownload {
  String? status;
  String? message;
  int? countData;
  DownParamData? data;

  ResponseParameterDownload(
      {this.status, this.message, this.countData, this.data});

  ResponseParameterDownload.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data =
        json['data'] != null ? new DownParamData.fromJson(json['data']) : null;
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

class DownParamData {
  String? base64Data;
  String? fileName;
  Null filePathName;

  DownParamData({this.base64Data, this.fileName, this.filePathName});

  DownParamData.fromJson(Map<String, dynamic> json) {
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

class DownloadRequestParam {
  String? paramGroupCd;
  String? paramGroupName;
  String? paramName;
  String? extention;

  DownloadRequestParam(
      [this.paramGroupCd, this.paramGroupName, this.paramName, this.extention]);

  DownloadRequestParam.fromJson(Map<String, dynamic> json) {
    paramGroupCd = json['paramGroupCd'];
    paramGroupName = json['paramGroupName'];
    paramName = json['paramName'];
    extention = json['extention'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramGroupCd'] = this.paramGroupCd;
    data['paramGroupName'] = this.paramGroupName;
    data['paramName'] = this.paramName;
    data['extention'] = this.extention;
    return data;
  }
}

class ResponseParameterDelete {
  String? status;
  String? message;
  int? countData;
  DelData? data;

  ResponseParameterDelete(
      {this.status, this.message, this.countData, this.data});

  ResponseParameterDelete.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countData = json['countData'];
    data = json['data'] != null ? new DelData.fromJson(json['data']) : null;
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

class DelData {
  String? status;
  String? message;
  int? countData;
  List<String>? data;

  DelData({this.status, this.message, this.countData, this.data});

  DelData.fromJson(Map<String, dynamic> json) {
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

class RequestParameterDelete {
  List<DelParamListCode>? listCode;

  RequestParameterDelete({this.listCode});

  RequestParameterDelete.fromJson(Map<String, dynamic> json) {
    if (json['listCode'] != null) {
      listCode = <DelParamListCode>[];
      json['listCode'].forEach((v) {
        listCode!.add(new DelParamListCode.fromJson(v));
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

class DelParamListCode {
  String? code;

  DelParamListCode({this.code});

  DelParamListCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class AddDtl {
  bool? isChecked;
  String? detailCd;
  String? detailName;
  String? detailDesc;
  AddDtl({this.isChecked, this.detailCd, this.detailName, this.detailDesc});
}

class RequestParameterAdd {
  String? paramGroupCd;
  String? paramGroupName;
  List<ParamList>? paramList;

  RequestParameterAdd({this.paramGroupCd, this.paramGroupName, this.paramList});

  RequestParameterAdd.fromJson(Map<String, dynamic> json) {
    paramGroupCd = json['paramGroupCd'];
    paramGroupName = json['paramGroupName'];
    if (json['paramList'] != null) {
      paramList = <ParamList>[];
      json['paramList'].forEach((v) {
        paramList!.add(new ParamList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramGroupCd'] = this.paramGroupCd;
    data['paramGroupName'] = this.paramGroupName;
    if (this.paramList != null) {
      data['paramList'] = this.paramList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParamList {
  bool? isChecked;
  String? paramCode;
  String? paramDesc;
  String? paramName;

  ParamList({this.isChecked, this.paramCode, this.paramDesc, this.paramName});

  ParamList.fromJson(Map<String, dynamic> json) {
    isChecked = false;
    paramCode = json['paramCode'];
    paramDesc = json['paramDesc'];
    paramName = json['paramName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paramCode'] = this.paramCode;
    data['paramDesc'] = this.paramDesc;
    data['paramName'] = this.paramName;
    return data;
  }
}
