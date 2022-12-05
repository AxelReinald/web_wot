//import 'dart:html';

import 'package:bloc/bloc.dart';
//import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:web_wot/model/setting_group.dart';
import 'package:web_wot/service/restapi.dart';

part 'setting_group_event.dart';
part 'setting_group_state.dart';

class SettingGroupBloc extends Bloc<SettingGroupEvent, SettingGroupState> {
  //final UserRepostitory userRepository;
  RestApi api = RestApi();
  SettingGroupBloc() : super(SettingInitial()) {
    on<SettingGroupEvent>(
      (event, emit) async {
        try {
          emit(SettingLoading());
          if (event is Search) {
            List<responseSetting>? respset = await listdata(event.reqset);
            emit(SettingSuccess(respset));
          }
        } catch (e) {}
      },
    );
  }

//   @override
//   Stream<SettingGroupState> mapEventToState(SettingGroupState event) async* {
//     if(event is GetAll) {
//       yield* _getAllUsers();
//     }
//   }

//  Stream<SettingGroupState> _getAllUsers() async* {
//   try {
//     yield Loading();
//     List<requestSetting> reqset = await userRepository.fetchUsers();
//     yield SettingLoaded(reqset);
//   } catch (e) {
//     print(e);
//     yield ShowMessage(e.toString());
//   }
//  }

  // Future<String?> Search(requestSetting reqset) async {
  //   var response = await api.search(
  //     body: model.toMap,
  //   ) as Map<String, dynamic>;
  //   requestSetting reqset = requestSetting.map(response);
  //   return null;
  // }

  Future<List<responseSetting>> listdata(requestSetting reqset) async {
    List<responseSetting> listModel = [];
    dynamic response =
        await api.ListSetting(body: reqset.toJson()) as Map<String, dynamic>;
    var res = response["data"];
    var status = response["status"];
    if (status == "error") {
      throw (response["message"]);
    }
    List listData = res;
    for (var item in listData) {
      listModel.add(responseSetting.fromJson(item));
    }
    return listModel;
  }
}
