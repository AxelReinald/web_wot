import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/settingsbloc/bloc/setting_bloc.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/model/setting.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:bloc/bloc.dart';
import 'package:web_wot/service/restapi.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> with SingleTickerProviderStateMixin {
  RequestSettings reqset = new RequestSettings();
  double _size = 250.0;
  late SettingBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<SettingBloc>(context);
    reqset.pageSize = 10;
    reqset.pageNumber = 0;
    reqset.settingCode = '';
    reqset.settingGroup = '';
    reqset.value = '';

    ex.clear();

    bloc.add(Search(reqset));
    super.initState();
  }

  bool _large = true;

  bool value = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  List<GData> ex = [];

  static const _birulangit = 0xFFF7FAFC;

  final ScrollController _scrollgrid = ScrollController();
  final ScrollController _mainscroll = ScrollController();

  //text field controller
  TextEditingController _Settinggroupcd = TextEditingController();
  TextEditingController _Settinggroupname = TextEditingController();
  TextEditingController _Value = TextEditingController();
  TextEditingController _SettingGroup = TextEditingController();
  TextEditingController _SettingCode = TextEditingController();
  TextEditingController _SettingDescription = TextEditingController();
  TextEditingController _SettingValueType = TextEditingController();
  TextEditingController _SettingValue = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SettingBloc>(context);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SettingsError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  duration: const Duration(seconds: 5),
                  content: Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red),
            );
        }
        if (state is SettingsSuccess) {
          setState(() {
            // arraysetting.clear();
            // arraysetting.addAll(state.resp);
            ex.clear();
            ex = state.resp.data!;
          });
        }
        if (state is InitSetsSuccess) {
          setState(() {
            ex.clear();
            ex = state.resp.data!;
          });
        }
      },
      child: Scaffold(
        body: Row(
          children: [
            AnimatedSize(
              curve: Curves.easeIn,
              vsync: this,
              duration: const Duration(milliseconds: 500),
              child: LeftDrawer(
                size: _size,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.black87),
                          onPressed: () {
                            _updateSize();
                          },
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(color: Colors.black87),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.notifications_none_outlined),
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Material(
                                elevation: 4.0,
                                shape: const CircleBorder(),
                                clipBehavior: Clip.hardEdge,
                                color: Colors.transparent,
                                child: Ink.image(
                                  image: const AssetImage('images/photo.png'),
                                  fit: BoxFit.fitHeight,
                                  width: 50.0,
                                  height: 50.0,
                                  child: InkWell(
                                    onTap: () {},
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Axel Reinald',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text('Admin',
                                      style: TextStyle(color: Colors.black))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const Text(
                            'Home / Admin / Setting',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      controller: _mainscroll,
                      children: [
                        Container(
                          height: 124,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Setting Group',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 55,
                                        width: 250,
                                        child: TextFormField(
                                          controller: _Settinggroupcd,
                                          decoration: new InputDecoration(
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),
                                          maxLength: 12,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          onChanged: (value) {
                                            reqset.settingGroup = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Setting Code',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 55,
                                        width: 250,
                                        child: TextFormField(
                                          controller: _Settinggroupname,
                                          decoration: new InputDecoration(
                                            // labelText: "Enter Email",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),
                                          maxLength: 12,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          onChanged: (value) {
                                            reqset.settingCode = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Value',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 55,
                                        width: 250,
                                        child: TextFormField(
                                          controller: _Value,
                                          decoration: new InputDecoration(
                                            // labelText: "Enter Email",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),
                                          maxLength: 12,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          onChanged: (value) {
                                            reqset.value = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: TextButton(
                                      onPressed: () {
                                        bloc.add(Search(reqset));
                                      },
                                      child: Text(
                                        'Search',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        _Settinggroupcd.clear();
                                        _Settinggroupname.clear();
                                      },
                                      child: const Text('Clear'),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1.0, color: Colors.blue),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: TextButton(
                                          onPressed: () {
                                            AddSettingDialog();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Add',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            EditSettingDialog();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.edit),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('Edit'),
                                            ],
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 1.0, color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.delete),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text('Delete'),
                                            ],
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 1.0, color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Import'),
                                            ],
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 1.0, color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Download',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              //table header
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Color(_birulangit),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                    child: Checkbox(
                                                        checkColor:
                                                            Colors.black,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    getColor),
                                                        value: isChecked,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isChecked =
                                                                !isChecked;
                                                          });
                                                        },
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Setting Group',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Setting Code',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Description',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: Text(
                                                        'Data Type',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: Text(
                                                        'Value',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Created By',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Created Date',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Changed By',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Changed Date',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            if (ex.length > 0 || ex.isNotEmpty)
                                              BlocBuilder<SettingBloc,
                                                  SettingState>(
                                                builder: (context, state) {
                                                  return Container(
                                                    //isi table
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.4,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ListView.builder(
                                                      itemCount: ex.length,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Column(children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                              child: Checkbox(
                                                                checkColor:
                                                                    Colors
                                                                        .black,
                                                                fillColor: MaterialStateProperty
                                                                    .resolveWith(
                                                                        getColor),
                                                                value:
                                                                    isChecked,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    isChecked =
                                                                        !isChecked;
                                                                  });
                                                                },
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .settingGroupName
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .settingGroupCode
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .settingDesc
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .settingValueType
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .settingValue
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .createdBy
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .createdTime
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .updatedBy
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  ex[index]
                                                                      .updatedTime
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                    ),
                                                  );
                                                },
                                              )
                                            else
                                              Container(
                                                height: 20,
                                                // color: Colors.grey,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  children: const [
                                                    Center(
                                                      child: Text(
                                                        'No Data Found',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //Paging
                          height: 60,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                              child: Row(
                                children: const [
                                  Text(
                                    'Showing:',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future AddSettingDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Setting - Add',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context, true),
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.blue,
              )
            ],
          ),
          content: Container(
            height: 800,
            width: 550,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 600,
                width: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Setting Group',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingGroup,
                      maxLength: 20,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Setting Code',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingCode,
                      maxLength: 20,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingDescription,
                      maxLines: 5, // <-- SEE HERE
                      minLines: 1,
                      maxLength: 150,
                      // maxLength: 150,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Setting Value Type',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingValueType,
                      maxLength: 20,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Setting Value',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingValue,
                      maxLines: 5, // <-- SEE HERE
                      minLines: 1,
                      maxLength: 150,
                      // maxLength: 150,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(
                                color: Colors.blue, width: 1), //<-- SEE HERE
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              // addset.groupCd = _SettingGroupCode.text;
                              // addset.groupDesc = _SettingGroupName.text;
                              // addset.groupName = _Description.text;
                              //bloc.add(Add(addset));
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future EditSettingDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Setting - Edit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context, true),
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.blue,
              )
            ],
          ),
          content: Container(
            height: 800,
            width: 550,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 600,
                width: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Setting Group',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingGroup,
                      maxLength: 20,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Setting Code',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        child: TextFormField(
                          readOnly: true,
                          cursorColor: Colors.grey,
                          controller: _SettingCode,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  width: 1.0, color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingDescription,
                      maxLines: 5, // <-- SEE HERE
                      minLines: 1,
                      maxLength: 150,
                      // maxLength: 150,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Setting Value Type',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingValueType,
                      maxLength: 20,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Setting Value',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _SettingValue,
                      maxLines: 5, // <-- SEE HERE
                      minLines: 1,
                      maxLength: 150,
                      // maxLength: 150,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            side: BorderSide(
                                color: Colors.blue, width: 1), //<-- SEE HERE
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              // addset.groupCd = _SettingGroupCode.text;
                              // addset.groupDesc = _SettingGroupName.text;
                              // addset.groupName = _Description.text;
                              //bloc.add(Add(addset));
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
