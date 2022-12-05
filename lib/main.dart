import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/settingbloc/setting_group_bloc.dart';

import 'screen/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47)),
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      home: BlocProvider<SettingGroupBloc>(
        create: (context) => SettingGroupBloc(),
        child: MyWidget(),
      ),
      // ),
    );
  }
}
