import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_wot/model/setting_group.dart';
import 'package:web_wot/service/restapi.dart';

part 'setting_group_event.dart';
part 'setting_group_state.dart';

class SettingGroupBloc extends Bloc<SettingGroupEvent, SettingGroupState> {
  RestApi api = RestApi();
  RequestSetting modreq = RequestSetting();
  ResponseSetting resp = ResponseSetting();
  AddRequestSettings addreq = AddRequestSettings();
  DeleteRequestSettings delreq = DeleteRequestSettings();

  SettingGroupBloc() : super(SettingInitial()) {
    on<SettingGroupEvent>(
      (event, emit) async {
        try {
          emit(SettingLoading());
          if (event is InitialScreen) {
            //   modreq = event.reqset;
            resp = await response(event.reqset);
            emit(InitSetSuccess(resp));
          } else if (event is Search) {
            resp = await response(event.reqset);
            emit(SettingSuccess(resp));
          } else if (event is Add) {
            addreq = await addresponse(event.addset);
            emit(AddSettingSuccess(addreq));
          } else if (event is Edit) {
            addreq = await editresponse(event.addset);
            emit(EditSettingSuccess(addreq));
          } else if (event is Delete) {
            delreq = await deleteresponse(event.delset);
            emit(DeleteSettingSuccess(delreq));
          }
        } catch (e) {
          emit(SettingError(e.toString()));
        }
      },
    );
  }

  Future<List<ResponseSetting>> listdata(RequestSetting reqset) async {
    List<ResponseSetting> listModel = [];
    dynamic response =
        await api.ListSetting(body: reqset.toJson()) as Map<String, dynamic>;
    var res = response["data"];
    var status = response["status"];
    if (status == "error") {
      throw (response["message"]);
    }
    List listData = res;
    for (var item in listData) {
      listModel.add(ResponseSetting.fromJson(item));
    }
    return listModel;
  }

  response(RequestSetting req) async {
    ResponseSetting respee = ResponseSetting();

    respee = await api.searchData(req.toJson());

    return respee;
  }

  addresponse(AddRequestSettings req) async {
    AddRequestSettings respee = AddRequestSettings();

    respee = await api.AddSettingGroupData(req.toJson());

    return respee;
  }

  editresponse(AddRequestSettings req) async {
    AddRequestSettings resultrep = AddRequestSettings();

    resultrep = await api.EditSettingGroupData(req.toJson());

    return resultrep;
  }

  deleteresponse(DeleteRequestSettings req) async {
    DeleteRequestSettings resultdel = DeleteRequestSettings();

    resultdel = await api.DeleteSettingGroupData(req.toJson());

    return resultdel;
  }
}
