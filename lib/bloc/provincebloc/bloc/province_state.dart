part of 'province_bloc.dart';

abstract class ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceInitial extends ProvinceState {}

class ProvinceError extends ProvinceState {
  final String error;
  ProvinceError(this.error);
}

class SearchSuccess extends ProvinceState {
  final ProvinceResponseSearch resp;
  SearchSuccess(this.resp);
}

class AddProSuccess extends ProvinceState {
  final ProvinceRequestAdd resp;
  AddProSuccess(this.resp);
}

class EditProSuccess extends ProvinceState {
  final ProvinceRequestEdit resp;
  EditProSuccess(this.resp);
}

class DeleteProSuccess extends ProvinceState {
  final ProvinceRequestDelete resp;
  DeleteProSuccess(this.resp);
}

class DownloadProSuccess extends ProvinceState {
  final ProvinceRespDownload resp;
  DownloadProSuccess(this.resp);
}

class TemplateProSuccess extends ProvinceState {
  final ProvinceRespTemplate resp;
  TemplateProSuccess(this.resp);
}

class UploadProSuccess extends ProvinceState {
  final UploadProResponse upresp;
  UploadProSuccess(this.upresp);
}
