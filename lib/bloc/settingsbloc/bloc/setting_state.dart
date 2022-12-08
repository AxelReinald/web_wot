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

class InitSetsSuccess extends SettingState {
  final ResponseSettings resp;
  InitSetsSuccess(this.resp);
}
