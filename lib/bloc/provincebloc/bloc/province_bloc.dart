import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_wot/bloc/settinggroupbloc/setting_group_bloc.dart';
import 'package:web_wot/model/provincemodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/service/restapi.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  RestApi api = RestApi();
  ProvinceRequestSearch searchreq = ProvinceRequestSearch();
  ProvinceResponseSearch resp = ProvinceResponseSearch();
  ProvinceRequestAdd addreq = ProvinceRequestAdd();
  ProvinceRequestEdit editreq = ProvinceRequestEdit();
  ProvinceRequestDelete delreq = ProvinceRequestDelete();
  ProvinceRespDownload downrespon = ProvinceRespDownload();
  ProvinceRespTemplate tempresp = ProvinceRespTemplate();
  UploadProResponse upresp = UploadProResponse();

  ProvinceBloc() : super(ProvinceInitial()) {
    on<ProvinceEvent>(
      (event, emit) async {
        try {
          emit(ProvinceLoading());
          if (event is SearchPro) {
            resp = await response(event.reqpro);
            emit(SearchSuccess(resp));
          } else if (event is AddPro) {
            addreq = await addresponse(event.addpro);
            emit(AddProSuccess(addreq));
          } else if (event is EditPro) {
            editreq = await editresponse(event.editpro);
            emit(EditProSuccess(editreq));
          } else if (event is DeletePro) {
            delreq = await deleteresponse(event.reqdel);
            emit(DeleteProSuccess(delreq));
          } else if (event is DownloadPro) {
            downrespon = await downloadresponse(event.downpro);
            emit(DownloadProSuccess(downrespon));
          } else if (event is DownloadProTemplate) {
            tempresp = await templateresponse();
            emit(TemplateProSuccess(tempresp));
          } else if (event is UploadProFile) {
            upresp = await uploadproresponse(event.req);
            emit(UploadProSuccess(upresp));
          }
        } catch (e) {
          emit(ProvinceError(e.toString()));
        }
      },
    );
  }

  response(ProvinceRequestSearch req) async {
    ProvinceResponseSearch proresp = ProvinceResponseSearch();
    proresp = await api.searchproData(req.toJson());
    return proresp;
  }

  addresponse(ProvinceRequestAdd req) async {
    ProvinceRequestAdd responadd = ProvinceRequestAdd();

    responadd = await api.AddProvinceData(req.toJson());
    return responadd;
  }

  editresponse(ProvinceRequestEdit req) async {
    ProvinceRequestEdit responedit = ProvinceRequestEdit();

    responedit = await api.EditProvinceData(req.toJson());

    return responedit;
  }

  deleteresponse(ProvinceRequestDelete req) async {
    ProvinceRequestDelete resultdel = ProvinceRequestDelete();
    resultdel = await api.DeleteProData(req.toJson());
    return resultdel;
  }

  downloadresponse(DownloadRequestPro req) async {
    ProvinceRespDownload dowreq = ProvinceRespDownload();

    dowreq = await api.DownloadPro(req.toJson());
    return dowreq;
  }

  templateresponse() async {
    ProvinceRespTemplate temp = ProvinceRespTemplate();

    temp = await api.TemplatePro();

    return temp;
  }

  uploadproresponse(File_Data_Model req) async {
    UploadProResponse upload = UploadProResponse();
    upload = await api.UploadPro(req);
    return upload;
  }
}
