part of 'city_bloc.dart';

abstract class CityEvent {}

class SearchCity extends CityEvent {
  final RequestCitySearch reqcity;
  SearchCity(this.reqcity);
}

class GetProvince extends CityEvent {
  GetProvince();
}

class AddCity extends CityEvent {
  final RequestAddCity reqadd;
  AddCity(this.reqadd);
}

class EditCity extends CityEvent {
  final RequestAddCity editreq;
  EditCity(this.editreq);
}

class DeleteCity extends CityEvent {
  final RequestDeleteCity delreq;
  DeleteCity(this.delreq);
}

class DownloadFileCity extends CityEvent {
  final DownloadRequestCity downcity;
  DownloadFileCity(this.downcity);
}

class DownloadTemplateCity extends CityEvent {
  DownloadTemplateCity();
}

class UploadCityFile extends CityEvent {
  final File_Data_Model req;
  UploadCityFile(this.req);
}
