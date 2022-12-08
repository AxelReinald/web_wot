part of 'setting_bloc.dart';

abstract class SettingEvent {}

class Search extends SettingEvent {
  final RequestSettings reqsetting;
  Search(this.reqsetting);
}

class InitialScreen extends SettingEvent {
  final RequestSettings reqsetting;
  InitialScreen(this.reqsetting);
}
