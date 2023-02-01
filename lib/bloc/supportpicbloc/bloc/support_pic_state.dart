part of 'support_pic_bloc.dart';

abstract class SupportPicState {}

class SupportPicInitial extends SupportPicState {}

class SupportpicLoad extends SupportPicState {}

class ErrorPIC extends SupportPicState {
  final String error;
  ErrorPIC(this.error);
}

class SearchpicSuccess extends SupportPicState {
  final ResponseSuppicSearch resp;
  SearchpicSuccess(this.resp);
}

class DownloadPicSuccess extends SupportPicState {
  final ResponsePicDownload resp;
  DownloadPicSuccess(this.resp);
}

class GetPicSuccess extends SupportPicState {
  final ResponseGetPIC resp;
  GetPicSuccess(this.resp);
}

class GetAutoSuccess extends SupportPicState {
  final ResponseGetAuto resp;
  GetAutoSuccess(this.resp);
}

class AddSuccess extends SupportPicState {
  final RequestAddPic resp;
  AddSuccess(this.resp);
}
