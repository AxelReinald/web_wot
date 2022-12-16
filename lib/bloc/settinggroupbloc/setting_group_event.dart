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
  final DeleteRequestSettings reqdel;
  Delete(this.reqdel);
}

class InitialScreen extends SettingGroupEvent {
  final RequestSetting reqset;
  InitialScreen(this.reqset);
}

class Download extends SettingGroupEvent {
  final DownloadRequestSettings downreq;
  Download(this.downreq);
}

class DownloadTemplate extends SettingGroupEvent {
  final DownloadRequestSettings downreq;
  DownloadTemplate(this.downreq);
}

class Upload extends SettingGroupEvent {
  Upload(String file);
}
