part of 'company_bloc.dart';

abstract class CompanyState {}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyError extends CompanyState {
  final String error;
  CompanyError(this.error);
}

class SearchComSuccess extends CompanyState {
  final ResponseSearchComp resp;
  SearchComSuccess(this.resp);
}

class DownloadComSuccess extends CompanyState {
  final DownloadResponseComp resp;
  DownloadComSuccess(this.resp);
}

class AddComSuccess extends CompanyState {
  final RequestComAdd resp;
  AddComSuccess(this.resp);
}

class EditComSuccess extends CompanyState {
  final RequestComAdd resp;
  EditComSuccess(this.resp);
}

class DeleteComSuccess extends CompanyState {
  final RequestComDelete resp;
  DeleteComSuccess(this.resp);
}

class UploadComSuccess extends CompanyState {
  final UploadComresponse upresp;
  UploadComSuccess(this.upresp);
}

class TemplateComSuccess extends CompanyState {
  final ResponseDownloadTemplateCom resp;
  TemplateComSuccess(this.resp);
}

class GetDataBusinessSuccess extends CompanyState {
  final ResponseComBusiness resp;
  GetDataBusinessSuccess(this.resp);
}

class GetDataCitySuccess extends CompanyState {
  final ResponseComCity resp;
  GetDataCitySuccess(this.resp);
}

class GetDataTypeSuccess extends CompanyState {
  final ResponseComType resp;
  GetDataTypeSuccess(this.resp);
}
