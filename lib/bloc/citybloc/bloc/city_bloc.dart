import 'package:bloc/bloc.dart';
import 'package:web_wot/model/citymodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/screen/cityscreen/uploadcity.dart';
import 'package:web_wot/service/restapi.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  RestApi api = RestApi();
  ResponseCitySearch respcity = ResponseCitySearch();
  ResponseGetProvince getresp = ResponseGetProvince();
  RequestAddCity reqadd = RequestAddCity();
  RequestDeleteCity delreqs = RequestDeleteCity();
  ResponseDownloadCity downresp = ResponseDownloadCity();
  ResponseTemplateCity tempresp = ResponseTemplateCity();
  ResponseUploadCity upload = ResponseUploadCity();

  CityBloc() : super(CityInitial()) {
    on<CityEvent>((event, emit) async {
      try {
        emit(CityLoading());
        if (event is SearchCity) {
          respcity = await response(event.reqcity);
          emit(SearchSuccess(respcity));
        } else if (event is GetProvince) {
          getresp = await getpro();
          emit(GetProvinceList(getresp));
        } else if (event is AddCity) {
          reqadd = await addresponse(event.reqadd);
          emit(AddSuccess(reqadd));
        } else if (event is DeleteCity) {
          delreqs = await deleteresponse(event.delreq);
          emit(DeleteSuccess(delreqs));
        } else if (event is EditCity) {
          reqadd = await editresponse(event.editreq);
          emit(EditCitySuccess(reqadd));
        } else if (event is DeleteCity) {
          delreqs = await deleteresponse(event.delreq);
          emit(DeleteSuccess(delreqs));
        } else if (event is DownloadFileCity) {
          downresp = await downloadresponse(event.downcity);
          emit(DownloadCitySuccess(downresp));
        } else if (event is DownloadTemplateCity) {
          tempresp = await templateresponse();
          emit(TemplateCitySuccess(tempresp));
        } else if (event is UploadCityFile) {
          upload = await uploadcityresponse(event.req);
          emit(UploadCitySuccess(upload));
        }
      } catch (e) {
        emit(CityError(e.toString()));
      }
    });
  }

  response(RequestCitySearch req) async {
    ResponseCitySearch respsearch = ResponseCitySearch();
    respsearch = await api.searchCityData(req.toJson());
    return respsearch;
  }

  getpro() async {
    ResponseGetProvince getlist = ResponseGetProvince();

    getlist = await api.GetProvinceData();

    return getlist;
  }

  addresponse(RequestAddCity req) async {
    RequestAddCity add = RequestAddCity();
    add = await api.AddCityData(req.toJson());
    return add;
  }

  deleteresponse(RequestDeleteCity req) async {
    RequestDeleteCity delres = RequestDeleteCity();
    delres = await api.DeleteCityData(req.toJson());
    return delres;
  }

  editresponse(RequestAddCity editreq) async {
    RequestAddCity edit = RequestAddCity();
    edit = await api.EditCityData(editreq.toJson());
    return edit;
  }

  downloadresponse(DownloadRequestCity req) async {
    ResponseDownloadCity downresp = ResponseDownloadCity();
    downresp = await api.DownloadCityData(req.toJson());
    return downresp;
  }

  templateresponse() async {
    ResponseTemplateCity resptemp = ResponseTemplateCity();
    resptemp = await api.DownloadTemplateData();
    return resptemp;
  }

  uploadcityresponse(File_Data_Model req) async {
    ResponseUploadCity upresp = ResponseUploadCity();
    upresp = await api.UploadCity(req);
    return upresp;
  }
}
