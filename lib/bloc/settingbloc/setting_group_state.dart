part of 'setting_group_bloc.dart';

@immutable
abstract class SettingGroupState {}

class SettingLoading extends SettingGroupState {}

class SettingError extends SettingGroupState {
  final String error;
  SettingError(this.error);
}

class SettingInitial extends SettingGroupState {}

class SettingSuccess extends SettingGroupState {
  final ResponseSetting resp;
  SettingSuccess(this.resp);
}

class AddSettingSuccess extends SettingGroupState {
  final AddRequestSettings resp;
  AddSettingSuccess(this.resp);
}

class EditSettingSuccess extends SettingGroupState {
  final AddRequestSettings resp;
  EditSettingSuccess(this.resp);
}

class DeleteSettingSuccess extends SettingGroupState {
  final DeleteRequestSettings resp;
  DeleteSettingSuccess(this.resp);
}

class InitSetSuccess extends SettingGroupState {
  final ResponseSetting resp;
  InitSetSuccess(this.resp);
}
