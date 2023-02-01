part of 'role_bloc.dart';

abstract class RoleEvent {}

class SearchRole extends RoleEvent {
  final RequestRoleSearch req;
  SearchRole(this.req);
}

class AddRole extends RoleEvent {
  final RequestRoleAdd reqadd;
  AddRole(this.reqadd);
}

class DeleteRole extends RoleEvent {
  final RequestRoleDelete delreq;
  DeleteRole(this.delreq);
}

class DownloadTempRole extends RoleEvent {
  DownloadTempRole();
}

class EditRole extends RoleEvent {
  final RequestRoleAdd editadd;
  EditRole(this.editadd);
}

class UploadRole extends RoleEvent {
  final File_Data_Model req;
  UploadRole(this.req);
}

class DownloadRole extends RoleEvent {
  final DownloadReq down;
  DownloadRole(this.down);
}
