part of 'company_bloc.dart';

abstract class CompanyEvent {}

class SearchCom extends CompanyEvent {
  final RequestSearchComp reqcom;
  SearchCom(this.reqcom);
}

class GetBusiness extends CompanyEvent {
  GetBusiness();
}

class GetCityCom extends CompanyEvent {
  GetCityCom();
}

class GetTypeCom extends CompanyEvent {
  GetTypeCom();
}

class AddCom extends CompanyEvent {
  final RequestComAdd reqadd;
  AddCom(this.reqadd);
}

class EditCom extends CompanyEvent {
  final RequestComAdd reqedit;
  EditCom(this.reqedit);
}

class DeleteCom extends CompanyEvent {
  final RequestComDelete delreq;
  DeleteCom(this.delreq);
}

class UploadComFile extends CompanyEvent {
  final File_Data_Model req;
  UploadComFile(this.req);
}

class DownloadFileCom extends CompanyEvent {
  final DownlaodRequestComp downfile;
  DownloadFileCom(this.downfile);
}

class DownloadTemplateCom extends CompanyEvent {
  DownloadTemplateCom();
}
