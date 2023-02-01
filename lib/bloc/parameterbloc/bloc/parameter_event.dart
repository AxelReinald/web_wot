part of 'parameter_bloc.dart';

@immutable
abstract class ParameterEvent {}

class SearchParam extends ParameterEvent {
  final RequestParameterSearch req;
  SearchParam(this.req);
}

class DeleteParam extends ParameterEvent {
  final RequestParameterDelete delpar;
  DeleteParam(this.delpar);
}

class DownloadParam extends ParameterEvent {
  final DownloadRequestParam req;
  DownloadParam(this.req);
}

class AddParam extends ParameterEvent {
  final RequestParameterAdd addpar;
  AddParam(this.addpar);
}
