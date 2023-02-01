part of 'setting_bloc.dart';

abstract class SettingState {}

class SettingsLoading extends SettingState {}

class SettingsError extends SettingState {
  final String error;
  SettingsError(this.error);
}

class SettingsInitial extends SettingState {}

class SettingsSuccess extends SettingState {
  final ResponseSettings resp;
  SettingsSuccess(this.resp);
}

class GetDataSettingGroupSuccess extends SettingState {
  final ResponseGetSettingGroupCode resp;
  GetDataSettingGroupSuccess(this.resp);
}

class GetDataSettingValueTypeSuccess extends SettingState {
  final ResponseGetSettingValueType resp;
  GetDataSettingValueTypeSuccess(this.resp);
}

class TemplateSuccess extends SettingState {
  final ResponseDownloadTemplate resp;
  TemplateSuccess(this.resp);
}

class AddSuccess extends SettingState {
  final RequestAddSetting resp;
  AddSuccess(this.resp);
}

class DownloadSettingSuccess extends SettingState {
  final DownloadResponseSetting resp;
  DownloadSettingSuccess(this.resp);
}

class EditSuccess extends SettingState {
  final RequestAddSetting resp;
  EditSuccess(this.resp);
}

class DeleteSuccess extends SettingState {
  final DeleteRequestSetting resp;
  DeleteSuccess(this.resp);
}

class UploadSettingSuccess extends SettingState {
  final UploadSettingresponse upresp;
  UploadSettingSuccess(this.upresp);
}

class InitSetsSuccess extends SettingState {
  final ResponseSettings resp;
  InitSetsSuccess(this.resp);
}
