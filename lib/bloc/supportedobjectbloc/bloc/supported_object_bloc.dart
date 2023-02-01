import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_wot/model/supportedobjectmodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/service/restapi.dart';

part 'supported_object_event.dart';
part 'supported_object_state.dart';

class SupportedObjectBloc
    extends Bloc<SupportedObjectEvent, SupportedObjectState> {
  RestApi api = RestApi();
  ResponseSearchSO respso = ResponseSearchSO();
  RequestSOAdd reqadd = RequestSOAdd();
  ResponseSOGetType gettype = ResponseSOGetType();
  ResponseSOGetCom getcom = ResponseSOGetCom();
  RequestDeleteSO reqdel = RequestDeleteSO();
  ResponseTempData resptemp = ResponseTempData();
  ResponseDownloadSO respdownso = ResponseDownloadSO();
  ResponseUploadSO respup = ResponseUploadSO();
  SupportedObjectBloc() : super(SupportedObjectInitial()) {
    on<SupportedObjectEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(LoadingSO());
        if (event is SearchSO) {
          respso = await searchresp(event.reqso);
          emit(SearchSOSuccess(respso));
        } else if (event is AddSO) {
          reqadd = await addresp(event.reqadd);
          emit(AddSOSuccess(reqadd));
        } else if (event is GetObjectType) {
          gettype = await getobjtype();
          emit(GetTypeSuccess(gettype));
        } else if (event is GetCom) {
          getcom = await getcomdata();
          emit(GetComSuccess(getcom));
        } else if (event is EditSOData) {
          reqadd = await editresp(event.editreq);
          emit(EditSOSuccess(reqadd));
        } else if (event is DeleteSOData) {
          reqdel = await deleteresp(event.delreq);
          emit(DeleteSOSuccess(reqdel));
        } else if (event is DownloadTemplateSO) {
          resptemp = await downtempresp();
          emit(TemplateSuccess(resptemp));
        } else if (event is DownloadFileSO) {
          respdownso = await downloadresp(event.downfile);
          emit(DownloadSOSuccess(respdownso));
        } else if (event is UploadSOFile) {
          respup = await uploadresp(event.req);
          emit(UploadSOSuccess(respup));
        }
      } catch (e) {
        emit(ErrorSO(e.toString()));
      }
    });
  }

  searchresp(RequestSearchSO req) async {
    ResponseSearchSO resp = ResponseSearchSO();
    resp = await api.Searchso(req.toJson());
    return resp;
  }

  addresp(RequestSOAdd add) async {
    RequestSOAdd reqadds = RequestSOAdd();
    reqadds = await api.Addso(add.toJson());
    return reqadds;
  }

  getobjtype() async {
    ResponseSOGetType gettype = ResponseSOGetType();
    gettype = await api.Getso();
    return gettype;
  }

  getcomdata() async {
    ResponseSOGetCom getcoms = ResponseSOGetCom();
    getcoms = await api.GetsoComp();
    return getcoms;
  }

  editresp(RequestSOAdd edit) async {
    RequestSOAdd editreq = RequestSOAdd();
    editreq = await api.Editso(edit.toJson());
    return editreq;
  }

  deleteresp(RequestDeleteSO req) async {
    RequestDeleteSO delreq = RequestDeleteSO();
    delreq = await api.Deleteso(req.toJson());
    return delreq;
  }

  downtempresp() async {
    ResponseTempData resp = ResponseTempData();
    resp = await api.DownloadTemplateSO();
    return resp;
  }

  downloadresp(DownloadRequestSO req) async {
    ResponseDownloadSO down = ResponseDownloadSO();
    down = await api.DownloadSOData(req.toJson());
    return down;
  }

  uploadresp(File_Data_Model req) async {
    ResponseUploadSO upresp = ResponseUploadSO();
    upresp = await api.UploadDataSO(req);
    return upresp;
  }
}
