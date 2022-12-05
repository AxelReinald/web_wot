part of 'setting_group_bloc.dart';

@immutable
abstract class SettingGroupState {}

// class SettingGroupInitial extends SettingGroupState {}

// class SettingLoading extends SettingGroupState {}

// class SettingSuccess extends SettingGroupState {
//   final String? id;
//   SettingSuccess(this.id);
// }

// class Initial implements SettingGroupEvent {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];

//   @override
//   // TODO: implement stringify
//   bool? get stringify => false;
// }

// class Loading implements SettingGroupState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();

//   @override
//   // TODO: implement stringify
//   bool? get stringify => throw UnimplementedError();
// }

// class SettingLoaded implements SettingGroupState {
//   final List<requestSetting> setting;

//   const SettingLoaded(this.setting);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [setting];

//   @override
//   // TODO: implement stringify
//   bool? get stringify => true;
// }

// class ShowMessage implements SettingGroupState{
//   final String message;

//   const ShowMessage(this.message);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [message];

//   @override
//   // TODO: implement stringify
//   bool? get stringify => false;

// }

class SettingLoading extends SettingGroupState {}

class SettingError extends SettingGroupState {
  final String error;
  SettingError(this.error);
}

class SettingInitial extends SettingGroupState {}

class SettingSuccess extends SettingGroupState {
  final List<responseSetting> respset;
  SettingSuccess(this.respset);
}
