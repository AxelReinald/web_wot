part of 'setting_group_bloc.dart';

@immutable
abstract class SettingGroupEvent {}

class Search extends SettingGroupEvent {
  final RequestSetting reqset;
  Search(this.reqset);
}

class Add extends SettingGroupEvent {
  final AddRequestSettings addset;
  Add(this.addset);
}

class Edit extends SettingGroupEvent {
  final AddRequestSettings addset;
  Edit(this.addset);
}

class Delete extends SettingGroupEvent {
  final DeleteRequestSettings delset;
  Delete(this.delset);
}

class InitialScreen extends SettingGroupEvent {
  final RequestSetting reqset;
  InitialScreen(this.reqset);
}
