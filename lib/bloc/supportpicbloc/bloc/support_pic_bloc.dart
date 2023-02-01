import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_wot/model/supportpicmodel.dart';
import 'package:web_wot/service/restapi.dart';

part 'support_pic_event.dart';
part 'support_pic_state.dart';

class SupportPicBloc extends Bloc<SupportPicEvent, SupportPicState> {
  RestApi api = RestApi();
  ResponseSuppicSearch resp = ResponseSuppicSearch();
  ResponsePicDownload downpic = ResponsePicDownload();
  ResponseGetPIC respgetpic = ResponseGetPIC();
  ResponseGetAuto respauto = ResponseGetAuto();
  ResponseAddPic respadd = ResponseAddPic();
  RequestAddPic reqadd = RequestAddPic();
  SupportPicBloc() : super(SupportPicInitial()) {
    on<SupportPicEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(SupportpicLoad());
        if (event is SearchPIC) {
          resp = await response(event.reqpic);
          emit(SearchpicSuccess(resp));
        } else if (event is DownloadPic) {
          downpic = await downloadresp(event.req);
          emit(DownloadPicSuccess(downpic));
        } else if (event is GetPic) {
          respgetpic = await getpic(event.id);
          emit(GetPicSuccess(respgetpic));
        } else if (event is GetAuto) {
          respauto = await getauto();
          emit(GetAutoSuccess(respauto));
        } else if (event is AddBlocPIC) {
          reqadd = await addresponse(event.req);
          emit(AddSuccess(reqadd));
        }
      } catch (e) {
        emit(ErrorPIC(e.toString()));
      }
    });
  }

  response(RequestSuppicSearch req) async {
    ResponseSuppicSearch resp = ResponseSuppicSearch();
    resp = await api.SearchPIC(req.toJson());
    return resp;
  }

  downloadresp(DownloadRequestPic req) async {
    ResponsePicDownload picresp = ResponsePicDownload();
    picresp = await api.DownloadPIC(req.toJson());
    return picresp;
  }

  getpic(final int? req) async {
    ResponseGetPIC getpicresp = ResponseGetPIC();
    getpicresp = await api.GetPicData(req);
    return getpicresp;
  }

  getauto() async {
    ResponseGetAuto autofill = ResponseGetAuto();
    autofill = await api.GetAutoData();
    return autofill;
  }

  addresponse(RequestAddPic req) async {
    RequestAddPic respon = RequestAddPic();
    respon = await api.AddPicData(req.toJson());
    return respon;
  }
}
