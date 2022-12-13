import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/settingbloc/setting_group_bloc.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:web_wot/screen/upload.dart';

import 'bloc/settingsbloc/bloc/setting_bloc.dart';
import 'screen/settinggroupscreen.dart';
import 'screen/settingscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  double _size = 250.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
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
      //     toolbarHeight: 70,
      //     leadingWidth: 200,
      //     backgroundColor: Colors.white,
      //     leading: Image(
      //       width: 500,
      //       height: 300,
      //       fit: BoxFit.fill,
      //       image: AssetImage('images/logo.jpeg'),
      //     ),
      //   ),
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
              child: Import(),
            ),
        '/settinggroup': (context) => BlocProvider<SettingGroupBloc>(
              create: (context) => SettingGroupBloc(),
              child: MyWidget(),
            ),
        '/setting': (context) => BlocProvider<SettingBloc>(
              create: (context) => SettingBloc(),
              child: Setting(),
            ),
      },
    );
  }
}
