part of 'setting_group_bloc.dart';

@immutable
abstract class SettingGroupEvent {}

// class ReqUser extends SettingGroupEvent {
//   final requestSetting model;
//   final responseSetting models;
//   ReqUser(this.model, this.models);
// }

// class GetAll implements SettingGroupEvent {
//   @override
//   List<Object> get props => [];

//   @override
//   bool get stringify => false;
// }

class Search extends SettingGroupEvent {
  final requestSetting reqset;
  Search(this.reqset);
}
