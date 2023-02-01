part of 'menu_screen_bloc.dart';

abstract class MenuScreenEvent {}

class Search extends MenuScreenEvent {
  final RequestMenuSearch reqmenu;
  Search(this.reqmenu);
}

class AddMenu extends MenuScreenEvent {
  final RequestMenuAdd reqadd;
  AddMenu(this.reqadd);
}

class GetParent extends MenuScreenEvent {
  GetParent();
}

class DownloadTemplate extends MenuScreenEvent {
  DownloadTemplate();
}

class DownloadMenu extends MenuScreenEvent {
  final DownloadReq down;
  DownloadMenu(this.down);
}

class DeleteMenu extends MenuScreenEvent {
  final RequestMenuDel delreq;
  DeleteMenu(this.delreq);
}

class UploadMenu extends MenuScreenEvent {
  final File_Data_Model req;
  UploadMenu(this.req);
}

class EditMenu extends MenuScreenEvent {
  final RequestMenuAdd reqedit;
  EditMenu(this.reqedit);
}
