import 'package:bloc/bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:web_wot/model/parametermodel.dart';
import 'package:web_wot/service/restapi.dart';
part 'parameter_event.dart';
part 'parameter_state.dart';

class ParameterBloc extends Bloc<ParameterEvent, ParameterState> {
  RestApi api = RestApi();
  ResponseParameterSearch resp = ResponseParameterSearch();
  ResponseParameterDownload downparam = ResponseParameterDownload();
  RequestParameterDelete delreq = RequestParameterDelete();
  RequestParameterAdd addreq = RequestParameterAdd();
  ParameterBloc() : super(ParameterInitial()) {
    on<ParameterEvent>((event, emit) async {
      try {
        emit(ParameterLoading());
        if (event is SearchParam) {
          resp = await response(event.req);
          emit(SearchSuccess(resp));
        } else if (event is DownloadParam) {
          downparam = await downloadresp(event.req);
          emit(DownloadSuccess(downparam));
        } else if (event is DeleteParam) {
          delreq = await deleteresp(event.delpar);
          emit(DeleteSuccess(delreq));
        } else if (event is AddParam) {
          addreq = await addresponse(event.addpar);
          emit(AddParamSuccess(addreq));
        }
      } catch (e) {
        emit(ParamError(e.toString()));
      }
    });
  }

  response(RequestParameterSearch req) async {
    ResponseParameterSearch resp = ResponseParameterSearch();
    resp = await api.Searchparam(req.toJson());
    return resp;
  }

  downloadresp(DownloadRequestParam req) async {
    ResponseParameterDownload paramresp = ResponseParameterDownload();
    paramresp = await api.DownloadParam(req.toJson());
    return paramresp;
  }

  deleteresp(RequestParameterDelete delparam) async {
    RequestParameterDelete delresult = RequestParameterDelete();
    delresult = await api.DeleteParameter(delparam.toJson());
    return delresult;
  }

  addresponse(RequestParameterAdd req) async {
    RequestParameterAdd respon = RequestParameterAdd();

    respon = await api.AddParameterData(req.toJson());

    return respon;
  }
}
