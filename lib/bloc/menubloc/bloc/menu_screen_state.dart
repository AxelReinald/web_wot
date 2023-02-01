part of 'menu_screen_bloc.dart';

abstract class MenuScreenState {}

class MenuScreenInitial extends MenuScreenState {}

class MenuLoading extends MenuScreenState {}

class MenuError extends MenuScreenState {
  final String error;
  MenuError(this.error);
}

class SearchSuccess extends MenuScreenState {
  final ResponseMenuSearch resp;
  SearchSuccess(this.resp);
}

class AddSuccess extends MenuScreenState {
  final RequestMenuAdd resp;
  AddSuccess(this.resp);
}

class GetParentSuccess extends MenuScreenState {
  final ResponseGetParent resp;
  GetParentSuccess(this.resp);
}

class DownloadMenuSuccess extends MenuScreenState {
  final DownloadResponse resp;
  DownloadMenuSuccess(this.resp);
}

class TemplateSuccess extends MenuScreenState {
  final DownloadTemplateResp resp;
  TemplateSuccess(this.resp);
}

class DeleteMenuSuccess extends MenuScreenState {
  final RequestMenuDel resp;
  DeleteMenuSuccess(this.resp);
}

class UploadMenuSuccess extends MenuScreenState {
  final ResponseUploadMenu resp;
  UploadMenuSuccess(this.resp);
}

class EditMenuSuccess extends MenuScreenState {
  final RequestMenuAdd resp;
  EditMenuSuccess(this.resp);
}
