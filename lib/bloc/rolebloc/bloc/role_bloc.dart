import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_wot/model/rolemodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/service/restapi.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RestApi api = RestApi();
  ResponseRoleSearch resprole = ResponseRoleSearch();
  RequestRoleAdd reqadd = RequestRoleAdd();
  RequestRoleDelete reqdel = RequestRoleDelete();
  ResponseDownload respdown = ResponseDownload();
  ResponseRoleTemp downtemp = ResponseRoleTemp();
  ResponseUploadRole respup = ResponseUploadRole();
  RoleBloc() : super(RoleInitial()) {
    on<RoleEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(RoleLoading());
        if (event is SearchRole) {
          resprole = await searchresp(event.req);
          emit(SearchSuccess(resprole));
        } else if (event is AddRole) {
          reqadd = await addresp(event.reqadd);
          emit(AddSuccess(reqadd));
        } else if (event is DeleteRole) {
          reqdel = await deleteresp(event.delreq);
          emit(DeleteRoleSuccess(reqdel));
        } else if (event is DownloadRole) {
          respdown = await downloadrole(event.down);
          emit(DownloadRoleSuccess(respdown));
        } else if (event is DownloadTempRole) {
          downtemp = await downloadtemp();
          emit(TemplateSuccess(downtemp));
        } else if (event is UploadRole) {
          respup = await uploadresp(event.req);
          emit(UploadRoleSuccess(respup));
        } else if (event is EditRole) {
          reqadd = await editresp(event.editadd);
          emit(EditRoleSuccess(reqadd));
        }
      } catch (e) {
        emit(RoleError(e.toString()));
      }
    });
  }

  searchresp(RequestRoleSearch req) async {
    ResponseRoleSearch respon = ResponseRoleSearch();
    respon = await api.SearchRoleData(req.toJson());
    return respon;
  }

  addresp(RequestRoleAdd reqadd) async {
    RequestRoleAdd addrole = RequestRoleAdd();
    addrole = await api.AddRoleData(reqadd.toJson());
    return addrole;
  }

  deleteresp(RequestRoleDelete req) async {
    RequestRoleDelete delreq = RequestRoleDelete();
    delreq = await api.DeleteRoleData(req.toJson());
    return delreq;
  }

  downloadrole(DownloadReq req) async {
    ResponseDownload downresp = ResponseDownload();
    downresp = await api.DownloadRoleData(req.toJson());
    return downresp;
  }

  downloadtemp() async {
    ResponseRoleTemp resp = ResponseRoleTemp();
    resp = await api.DownloadTempRole();
    return resp;
  }

  uploadresp(File_Data_Model req) async {
    ResponseUploadRole upresp = ResponseUploadRole();
    upresp = await api.UploadRoleData(req);
    return upresp;
  }

  editresp(RequestRoleAdd edit) async {
    RequestRoleAdd editreq = RequestRoleAdd();
    editreq = await api.EditRoleData(edit.toJson());
    return editreq;
  }
}
