part of 'role_bloc.dart';

abstract class RoleState {}

class RoleInitial extends RoleState {}

class RoleLoading extends RoleState {}

class RoleError extends RoleState {
  final String error;
  RoleError(this.error);
}

class SearchSuccess extends RoleState {
  final ResponseRoleSearch resp;
  SearchSuccess(this.resp);
}

class AddSuccess extends RoleState {
  final RequestRoleAdd resp;
  AddSuccess(this.resp);
}

class DeleteRoleSuccess extends RoleState {
  final RequestRoleDelete resp;
  DeleteRoleSuccess(this.resp);
}

class TemplateSuccess extends RoleState {
  final ResponseRoleTemp resp;
  TemplateSuccess(this.resp);
}

class DownloadRoleSuccess extends RoleState {
  final ResponseDownload resp;
  DownloadRoleSuccess(this.resp);
}

class UploadRoleSuccess extends RoleState {
  final ResponseUploadRole resp;
  UploadRoleSuccess(this.resp);
}

class EditRoleSuccess extends RoleState {
  final RequestRoleAdd resp;
  EditRoleSuccess(this.resp);
}
