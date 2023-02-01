part of 'province_bloc.dart';

@immutable
abstract class ProvinceEvent {}

class SearchPro extends ProvinceEvent {
  final ProvinceRequestSearch reqpro;
  SearchPro(this.reqpro);
}

class AddPro extends ProvinceEvent {
  final ProvinceRequestAdd addpro;
  AddPro(this.addpro);
}

class EditPro extends ProvinceEvent {
  final ProvinceRequestEdit editpro;
  EditPro(this.editpro);
}

class DeletePro extends ProvinceEvent {
  final ProvinceRequestDelete reqdel;
  DeletePro(this.reqdel);
}

class DownloadPro extends ProvinceEvent {
  final DownloadRequestPro downpro;
  DownloadPro(this.downpro);
}

class DownloadProTemplate extends ProvinceEvent {
  DownloadProTemplate();
}

class UploadProFile extends ProvinceEvent {
  final File_Data_Model req;
  UploadProFile(this.req);
}
