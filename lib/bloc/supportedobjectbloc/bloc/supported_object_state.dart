part of 'supported_object_bloc.dart';

abstract class SupportedObjectState {}

class SupportedObjectInitial extends SupportedObjectState {}

class LoadingSO extends SupportedObjectState {}

class ErrorSO extends SupportedObjectState {
  final String error;
  ErrorSO(this.error);
}

class AddSOSuccess extends SupportedObjectState {
  final RequestSOAdd resp;
  AddSOSuccess(this.resp);
}

class SearchSOSuccess extends SupportedObjectState {
  final ResponseSearchSO resp;
  SearchSOSuccess(this.resp);
}

class EditSOSuccess extends SupportedObjectState {
  final RequestSOAdd resp;
  EditSOSuccess(this.resp);
}

class GetTypeSuccess extends SupportedObjectState {
  final ResponseSOGetType resp;
  GetTypeSuccess(this.resp);
}

class GetComSuccess extends SupportedObjectState {
  final ResponseSOGetCom resp;
  GetComSuccess(this.resp);
}

class DeleteSOSuccess extends SupportedObjectState {
  final RequestDeleteSO resp;
  DeleteSOSuccess(this.resp);
}

class TemplateSuccess extends SupportedObjectState {
  final ResponseTempData resp;
  TemplateSuccess(this.resp);
}

class DownloadSOSuccess extends SupportedObjectState {
  final ResponseDownloadSO resp;
  DownloadSOSuccess(this.resp);
}

class UploadSOSuccess extends SupportedObjectState {
  final ResponseUploadSO resp;
  UploadSOSuccess(this.resp);
}
