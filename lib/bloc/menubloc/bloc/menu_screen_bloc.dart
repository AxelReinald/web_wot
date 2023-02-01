import 'package:bloc/bloc.dart';
import 'package:web_wot/model/menumodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/service/restapi.dart';

part 'menu_screen_event.dart';
part 'menu_screen_state.dart';

class MenuScreenBloc extends Bloc<MenuScreenEvent, MenuScreenState> {
  RestApi api = RestApi();
  ResponseMenuSearch respsearch = ResponseMenuSearch();
  RequestMenuAdd reqadd = RequestMenuAdd();
  ResponseGetParent respparent = ResponseGetParent();
  DownloadResponse downresp = DownloadResponse();
  DownloadTemplateResp downtemp = DownloadTemplateResp();
  RequestMenuDel reqdel = RequestMenuDel();
  ResponseUploadMenu respmenu = ResponseUploadMenu();
  MenuScreenBloc() : super(MenuScreenInitial()) {
    on<MenuScreenEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(MenuLoading());
        if (event is Search) {
          respsearch = await searchresponse(event.reqmenu);
          emit(SearchSuccess(respsearch));
        } else if (event is AddMenu) {
          reqadd = await addresponse(event.reqadd);
          emit(AddSuccess(reqadd));
        } else if (event is GetParent) {
          respparent = await getparent();
          emit(GetParentSuccess(respparent));
        } else if (event is DownloadMenu) {
          downresp = await getdownload(event.down);
          emit(DownloadMenuSuccess(downresp));
        } else if (event is DownloadTemplate) {
          downtemp = await downloadtemp();
          emit(TemplateSuccess(downtemp));
        } else if (event is DeleteMenu) {
          reqdel = await deleteresp(event.delreq);
          emit(DeleteMenuSuccess(reqdel));
        } else if (event is UploadMenu) {
          respmenu = await uploadres(event.req);
          emit(UploadMenuSuccess(respmenu));
        } else if (event is EditMenu) {
          reqadd = await editrespon(event.reqedit);
          emit(EditMenuSuccess(reqadd));
        }
      } catch (e) {
        emit(MenuError(e.toString()));
      }
    });
  }

  searchresponse(RequestMenuSearch req) async {
    ResponseMenuSearch resppon = ResponseMenuSearch();
    resppon = await api.SearchMenuData(req.toJson());
    return resppon;
  }

  addresponse(RequestMenuAdd reqadd) async {
    RequestMenuAdd addmenu = RequestMenuAdd();
    addmenu = await api.AddMenuData(reqadd.toJson());
    return addmenu;
  }

  getparent() async {
    ResponseGetParent getparent = ResponseGetParent();
    getparent = await api.GetParentData();
    return getparent;
  }

  getdownload(DownloadReq req) async {
    DownloadResponse downresp = DownloadResponse();
    downresp = await api.DownloadMenuData(req.toJson());
    return downresp;
  }

  downloadtemp() async {
    DownloadTemplateResp resp = DownloadTemplateResp();
    resp = await api.DownloadTemplateMenu();
    return resp;
  }

  deleteresp(RequestMenuDel req) async {
    RequestMenuDel delreq = RequestMenuDel();
    delreq = await api.DeleteMenuData(req.toJson());
    return delreq;
  }

  uploadres(File_Data_Model req) async {
    ResponseUploadMenu upresp = ResponseUploadMenu();
    upresp = await api.UploadMenuData(req);
    return upresp;
  }

  editrespon(RequestMenuAdd edit) async {
    RequestMenuAdd editreq = RequestMenuAdd();
    editreq = await api.EditMenuData(edit.toJson());
    return editreq;
  }
}
