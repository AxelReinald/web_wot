part of 'parameter_bloc.dart';

@immutable
abstract class ParameterState {}

class ParameterInitial extends ParameterState {}

class ParameterLoading extends ParameterState {}

class SearchSuccess extends ParameterState {
  final ResponseParameterSearch resp;
  SearchSuccess(this.resp);
}

class DownloadSuccess extends ParameterState {
  final ResponseParameterDownload resp;
  DownloadSuccess(this.resp);
}

class DeleteSuccess extends ParameterState {
  final RequestParameterDelete resp;
  DeleteSuccess(this.resp);
}

class ParamError extends ParameterState {
  final String error;
  ParamError(this.error);
}

class AddParamSuccess extends ParameterState {
  final RequestParameterAdd resp;
  AddParamSuccess(this.resp);
}
