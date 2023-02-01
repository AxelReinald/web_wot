import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/citybloc/bloc/city_bloc.dart';
import 'package:web_wot/bloc/companybloc/bloc/company_bloc.dart';
import 'package:web_wot/bloc/menubloc/bloc/menu_screen_bloc.dart';
import 'package:web_wot/bloc/provincebloc/bloc/province_bloc.dart';
import 'package:web_wot/bloc/rolebloc/bloc/role_bloc.dart';
import 'package:web_wot/bloc/settinggroupbloc/setting_group_bloc.dart';
import 'package:web_wot/bloc/supportpicbloc/bloc/support_pic_bloc.dart';
import 'package:web_wot/bloc/userbloc/bloc/user_bloc.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/screen/cityscreen/cityscreen.dart';
import 'package:web_wot/screen/cityscreen/uploadcity.dart';
import 'package:web_wot/screen/company/companyscreen.dart';
import 'package:web_wot/screen/company/uploadcompany.dart';
import 'package:web_wot/screen/menuscreen/menuscreen.dart';
import 'package:web_wot/screen/menuscreen/uploadmenu.dart';
// import 'package:web_wot/screen/menu.dart';
import 'package:web_wot/screen/parameterscreen/parameterscreen.dart';
import 'package:web_wot/screen/provincescreen/provincescreen.dart';
import 'package:web_wot/screen/rolescreen/rolescreen.dart';
import 'package:web_wot/screen/rolescreen/uploadrole.dart';
// import 'package:web_wot/screen/screentry.dart';
import 'package:web_wot/screen/settinggroup/upload.dart';
import 'package:web_wot/screen/settingscreen/uploadsetting.dart';
import 'package:web_wot/screen/supportedobject/uploadso.dart';
import 'package:web_wot/screen/supportpic/supportpicscreen.dart';
import 'package:web_wot/screen/userscreen/uploaduser.dart';
import 'package:web_wot/screen/userscreen/userscreen.dart';

import 'bloc/parameterbloc/bloc/parameter_bloc.dart';
import 'bloc/settingsbloc/bloc/setting_bloc.dart';
import 'bloc/supportedobjectbloc/bloc/supported_object_bloc.dart';
import 'screen/parameterscreen/addparameter.dart';
import 'screen/provincescreen/uploadprovince.dart';
import 'screen/settinggroup/settinggroupscreen.dart';
import 'screen/settingscreen/settingscreen.dart';
import 'screen/supportedobject/supportedobjectscreen.dart';
import 'screen/supportpic/addpic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  double _size = 250.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor:
              const Color(0xFFE7E7E7), //const Color.fromARGB(255, 18, 32, 47),
          scrollbarTheme: ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(Colors.red[500]),
          )),

      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      home: BlocProvider<SettingGroupBloc>(
        create: (context) => SettingGroupBloc(),
        child: MyWidget(),
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     elevation: 0,
      //     toolbarHeight: 70,
      //     leadingWidth: 270,
      //     backgroundColor: Colors.white,
      //     leading: Padding(
      //       padding: const EdgeInsets.only(left: 20),
      //       child: Image(
      //         width: 500,
      //         height: 300,
      //         fit: BoxFit.contain,
      //         image: AssetImage('images/logo.jpeg'),
      //       ),
      //     ),
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.only(right: 30),
      //         child: Row(
      //           children: [
      //             IconButton(
      //               onPressed: () {},
      //               icon: const Icon(Icons.notifications_none_outlined),
      //               color: Colors.black,
      //             ),
      //             const SizedBox(
      //               width: 15,
      //             ),
      //             Material(
      //               elevation: 4.0,
      //               shape: const CircleBorder(),
      //               clipBehavior: Clip.hardEdge,
      //               color: Colors.transparent,
      //               child: Ink.image(
      //                 image: const AssetImage('images/photo.png'),
      //                 fit: BoxFit.fitHeight,
      //                 width: 50.0,
      //                 height: 50.0,
      //                 child: InkWell(
      //                     // onTap: () {},
      //                     ),
      //               ),
      //             ),
      //             const SizedBox(
      //               width: 15,
      //             ),
      //             Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: const [
      //                 Text(
      //                   'Axel Reinald',
      //                   style: TextStyle(
      //                       color: Colors.black, fontWeight: FontWeight.w600),
      //                 ),
      //                 SizedBox(
      //                   height: 5,
      //                 ),
      //                 Text('Admin', style: TextStyle(color: Colors.black))
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      //   // body: Row(
      //   //   children: [
      //   //     LeftDrawer(size: _size),
      //   //     Expanded(flex: 4, child: ScreenTry())
      //   //   ],
      //   // ),
      // ),
      //   // body:
      //   // Row(
      //   //   children: [
      //   //     AnimatedSize(
      //   //       curve: Curves.easeIn,
      //   //       // vsync: this,
      //   //       duration: const Duration(milliseconds: 500),
      //   //       child: LeftDrawer(
      //   //         size: _size,
      //   //       ),
      //   //     ),
      //   //   ],
      //   // ),
      // ),
      routes: {
        '/settinggroup/import': (context) => BlocProvider<SettingGroupBloc>(
              create: (context) => SettingGroupBloc(),
              child: Import(
                onDroppedFile: (File_Data_Model value) {},
              ),
            ),
        '/settinggroup': (context) => BlocProvider<SettingGroupBloc>(
              create: (context) => SettingGroupBloc(),
              child: MyWidget(),
            ),
        '/setting': (context) => BlocProvider<SettingBloc>(
              create: (context) => SettingBloc(),
              child: Setting(),
            ),
        '/setting/import': (context) => BlocProvider<SettingBloc>(
              create: (context) => SettingBloc(),
              child: ImportSetting(),
            ),
        '/parameter': (context) => BlocProvider<ParameterBloc>(
              create: (context) => ParameterBloc(),
              child: ParameterScreen(
                groupCd: '',
                groupName: '',
              ),
            ),
        '/parameter/add': (context) => BlocProvider<ParameterBloc>(
              create: (context) => ParameterBloc(),
              child: AddParameter(
                groupcode: '',
                groupname: '',
                listpar: [],
              ),
            ),
        '/province': (context) => BlocProvider<ProvinceBloc>(
              create: (context) => ProvinceBloc(),
              child: ProvinceScreen(),
            ),
        '/province/import': (context) => BlocProvider<ProvinceBloc>(
              create: (context) => ProvinceBloc(),
              child: UploadPro(),
            ),
        '/city': (context) => BlocProvider<CityBloc>(
              create: (context) => CityBloc(),
              child: CityScreen(),
            ),
        '/city/import': (context) => BlocProvider<CityBloc>(
              create: (context) => CityBloc(),
              child: UploadCity(),
            ),
        '/company': (context) => BlocProvider<CompanyBloc>(
              create: (context) => CompanyBloc(),
              child: CompanyScreen(),
            ),
        '/company/import': (context) => BlocProvider<CompanyBloc>(
              create: (context) => CompanyBloc(),
              child: UploadCom(),
            ),
        '/supportedobject': (context) => BlocProvider<SupportedObjectBloc>(
              create: (context) => SupportedObjectBloc(),
              child: SupportedObject(),
            ),
        '/supportedobject/import': (context) =>
            BlocProvider<SupportedObjectBloc>(
              create: (context) => SupportedObjectBloc(),
              child: UploadSO(),
            ),
        '/supportpic': (context) => BlocProvider<SupportPicBloc>(
              create: (context) => SupportPicBloc(),
              child: Supportpic(),
            ),
        '/supportpic/assign': (context) => BlocProvider<SupportPicBloc>(
              create: (context) => SupportPicBloc(),
              child: Addpic(
                // listpic: [],
                ids: null,
              ),
            ),
        '/menuscreen': (context) => BlocProvider<MenuScreenBloc>(
              create: (context) => MenuScreenBloc(),
              child: MainScreen(),
            ),
        '/menuscreen/import': (context) => BlocProvider<MenuScreenBloc>(
              create: (context) => MenuScreenBloc(),
              child: ImportMenu(),
            ),
        '/role': (context) => BlocProvider<RoleBloc>(
              create: (context) => RoleBloc(),
              child: RoleScreen(),
            ),
        '/role/import': (context) => BlocProvider<RoleBloc>(
              create: (context) => RoleBloc(),
              child: ImportRole(),
            ),
        '/user': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(),
              child: Userscreen(),
            ),
        '/user/import': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(),
              child: UploadUser(),
            ),
      },
    );
  }
}
