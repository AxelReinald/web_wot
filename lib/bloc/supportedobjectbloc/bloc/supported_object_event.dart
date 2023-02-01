part of 'supported_object_bloc.dart';

abstract class SupportedObjectEvent {}

class SupportedObjectLoading extends SupportedObjectEvent {}

class SearchSO extends SupportedObjectEvent {
  final RequestSearchSO reqso;
  SearchSO(this.reqso);
}

class AddSO extends SupportedObjectEvent {
  final RequestSOAdd reqadd;
  AddSO(this.reqadd);
}

class EditSOData extends SupportedObjectEvent {
  final RequestSOAdd editreq;
  EditSOData(this.editreq);
}

class GetObjectType extends SupportedObjectEvent {
  GetObjectType();
}

class GetCom extends SupportedObjectEvent {
  GetCom();
}

class DeleteSOData extends SupportedObjectEvent {
  final RequestDeleteSO delreq;
  DeleteSOData(this.delreq);
}

class DownloadTemplateSO extends SupportedObjectEvent {
  DownloadTemplateSO();
}

class DownloadFileSO extends SupportedObjectEvent {
  final DownloadRequestSO downfile;
  DownloadFileSO(this.downfile);
}

class UploadSOFile extends SupportedObjectEvent {
  final File_Data_Model req;
  UploadSOFile(this.req);
}
