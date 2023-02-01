import 'package:bloc/bloc.dart';
import 'package:web_wot/model/setting.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/service/restapi.dart';
part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  RestApi api = RestApi();
  RequestSettings reqsetting = RequestSettings();
  RequestAddSetting reqadds = RequestAddSetting();
  ResponseSettings respsetting = ResponseSettings();
  DownloadResponseSetting downresp = DownloadResponseSetting();
  ResponseDownloadTemplate tempresp = ResponseDownloadTemplate();
  UploadSettingresponse upresp = UploadSettingresponse();
  DeleteRequestSetting delreqs = DeleteRequestSetting();
  ResponseGetSettingGroupCode getsettinggroupcode =
      ResponseGetSettingGroupCode();
  ResponseGetSettingValueType getsettingvaluetype =
      ResponseGetSettingValueType();
  SettingBloc() : super(SettingsInitial()) {
    on<SettingEvent>((event, emit) async {
      try {
        emit(SettingsLoading());
        if (event is InitialScreen) {
          respsetting = await response(event.reqsetting);
          emit(InitSetsSuccess(respsetting));
        } else if (event is Search) {
          respsetting = await response(event.reqsetting);
          emit(SettingsSuccess(respsetting));
        } else if (event is GetDataSettingGroupCode) {
          getsettinggroupcode = await getsettingcode();
          emit(GetDataSettingGroupSuccess(getsettinggroupcode));
        } else if (event is GetDataSettingValueType) {
          getsettingvaluetype = await getvaluetype();
          emit(GetDataSettingValueTypeSuccess(getsettingvaluetype));
        } else if (event is DownloadTemplates) {
          tempresp = await downtemplateresponse();
          emit(TemplateSuccess(tempresp));
        } else if (event is AddSetting) {
          reqadds = await addresponse(event.reqadds);
          emit(AddSuccess(reqadds));
        } else if (event is DownloadFile) {
          downresp = await downloadresponse(event.downfile);
          emit(DownloadSettingSuccess(downresp));
        } else if (event is EditSettings) {
          reqadds = await editresponse(event.editreq);
          emit(EditSuccess(reqadds));
        } else if (event is DeleteSetting) {
          delreqs = await deleteresponse(event.delreq);
          emit(DeleteSuccess(delreqs));
        } else if (event is UploadSettingFile) {
          upresp = await uploadsetresponse(event.req);
          emit(UploadSettingSuccess(upresp));
        }
      } catch (e) {
        emit(SettingsError(e.toString()));
      }
    });
  }

  response(RequestSettings req) async {
    ResponseSettings respek = ResponseSettings();

    respek = await api.searchsetData(req.toJson());

    return respek;
  }

  getsettingcode() async {
    ResponseGetSettingGroupCode getsetting = ResponseGetSettingGroupCode();

    getsetting = await api.GetSettingGroupCode();

    return getsetting;
  }

  getvaluetype() async {
    ResponseGetSettingValueType getvalue = ResponseGetSettingValueType();

    getvalue = await api.GetSettingValueType();

    return getvalue;
  }

  downtemplateresponse() async {
    ResponseDownloadTemplate gettemp = ResponseDownloadTemplate();

    gettemp = await api.DownloadTemplateSetting();

    return gettemp;
  }

  addresponse(RequestAddSetting reqadd) async {
    RequestAddSetting reqad = RequestAddSetting();

    reqad = await api.AddSettingData(reqadd.toJson());

    return reqad;
  }

  downloadresponse(DownloadRequestSettings req) async {
    DownloadResponseSetting downresp = DownloadResponseSetting();
    downresp = await api.DownloadSetting(req.toJson());

    return downresp;
  }

  editresponse(RequestAddSetting editreq) async {
    RequestAddSetting editreqs = RequestAddSetting();

    editreqs = await api.EditSettingData(editreq.toJson());

    return editreqs;
  }

  deleteresponse(DeleteRequestSetting req) async {
    DeleteRequestSetting delresult = DeleteRequestSetting();

    delresult = await api.DeleteSettingData(req.toJson());

    return delresult;
  }

  uploadsetresponse(File_Data_Model req) async {
    UploadSettingresponse up = UploadSettingresponse();
    up = await api.UploadSetting(req);
    return up;
  }
}
