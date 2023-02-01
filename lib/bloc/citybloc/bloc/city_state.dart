part of 'city_bloc.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityError extends CityState {
  final String error;
  CityError(this.error);
}

class SearchSuccess extends CityState {
  final ResponseCitySearch resp;
  SearchSuccess(this.resp);
}

class GetProvinceList extends CityState {
  final ResponseGetProvince resp;
  GetProvinceList(this.resp);
}

class AddSuccess extends CityState {
  final RequestAddCity resp;
  AddSuccess(this.resp);
}

class EditCitySuccess extends CityState {
  final RequestAddCity resp;
  EditCitySuccess(this.resp);
}

class DeleteSuccess extends CityState {
  final RequestDeleteCity resp;
  DeleteSuccess(this.resp);
}

class DownloadCitySuccess extends CityState {
  final ResponseDownloadCity resp;
  DownloadCitySuccess(this.resp);
}

class TemplateCitySuccess extends CityState {
  final ResponseTemplateCity resp;
  TemplateCitySuccess(this.resp);
}

class UploadCitySuccess extends CityState {
  final ResponseUploadCity upresp;
  UploadCitySuccess(this.upresp);
}
