part of 'setting_bloc.dart';

abstract class SettingEvent {}

class Search extends SettingEvent {
  final RequestSettings reqsetting;
  Search(this.reqsetting);
}

class GetDataSettingGroupCode extends SettingEvent {
  GetDataSettingGroupCode();
}

class GetDataSettingValueType extends SettingEvent {
  GetDataSettingValueType();
}

class DownloadTemplates extends SettingEvent {
  DownloadTemplates();
}

class AddSetting extends SettingEvent {
  final RequestAddSetting reqadds;
  AddSetting(this.reqadds);
}

class DownloadFile extends SettingEvent {
  final DownloadRequestSettings downfile;
  DownloadFile(this.downfile);
}

class EditSettings extends SettingEvent {
  final RequestAddSetting editreq;
  EditSettings(this.editreq);
}

class DeleteSetting extends SettingEvent {
  final DeleteRequestSetting delreq;
  DeleteSetting(this.delreq);
}

class UploadSettingFile extends SettingEvent {
  final File_Data_Model req;
  UploadSettingFile(this.req);
}

class InitialScreen extends SettingEvent {
  final RequestSettings reqsetting;
  InitialScreen(this.reqsetting);
}
