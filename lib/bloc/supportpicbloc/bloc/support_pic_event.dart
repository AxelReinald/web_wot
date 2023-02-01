part of 'support_pic_bloc.dart';

abstract class SupportPicEvent {}

class SupportPIC extends SupportPicEvent {}

class SearchPIC extends SupportPicEvent {
  final RequestSuppicSearch reqpic;
  SearchPIC(this.reqpic);
}

class DownloadPic extends SupportPicEvent {
  final DownloadRequestPic req;
  DownloadPic(this.req);
}

class GetPic extends SupportPicEvent {
  final int? id;
  GetPic(this.id);
}

class GetAuto extends SupportPicEvent {
  GetAuto();
}

class AddBlocPIC extends SupportPicEvent {
  final RequestAddPic req;
  AddBlocPIC(this.req);
}
