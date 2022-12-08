import 'package:bloc/bloc.dart';
import 'package:web_wot/model/setting.dart';
import 'package:web_wot/service/restapi.dart';
part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  RestApi api = RestApi();
  RequestSettings reqsetting = RequestSettings();
  ResponseSettings respsetting = ResponseSettings();
  SettingBloc() : super(SettingsInitial()) {
    on<SettingEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(SettingsLoading());
        if (event is InitialScreen) {
          respsetting = await response(event.reqsetting);
          emit(InitSetsSuccess(respsetting));
        } else if (event is Search) {
          respsetting = await response(event.reqsetting);
          emit(SettingsSuccess(respsetting));
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
}
