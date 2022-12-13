import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/settingbloc/setting_group_bloc.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/model/setting_group.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:bloc/bloc.dart';
import 'package:web_wot/service/restapi.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  List<ResponseSetting> arraysetting = [];
  int? total;
  int? hal;
  int page = 1;
  List<RData> halo = [];
  List<ListCode> del = [];

  RequestSetting reqset = new RequestSetting();
  AddRequestSettings addset = new AddRequestSettings();
  DeleteRequestSettings delset = new DeleteRequestSettings();
  ListCode code = new ListCode();
  DownloadRequestSettings dowreq = new DownloadRequestSettings();
  //late final requestSetting reqset;
  late SettingGroupBloc bloc;
  double _size = 250.0;
  bool isChecked = false;

  @override
  void initState() {
    bloc = BlocProvider.of<SettingGroupBloc>(context);
    reqset.pageSize = 10;
    reqset.pageNumber = 0;
    reqset.groupCd = '';
    reqset.groupName = '';
    halo.clear();
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

  var splited;

  static const _birulangit = 0xFFF7FAFC;

  final ScrollController _scrollgrid = ScrollController();
  final ScrollController _mainscroll = ScrollController();
  final ScrollController _mainscrolls = ScrollController();
  final ScrollController TableScroll = ScrollController();
  final ScrollController _horizontalscroll = ScrollController();

  //text field controller
  TextEditingController _Settinggroupcd = TextEditingController();
  TextEditingController _Settinggroupname = TextEditingController();
  TextEditingController _SettingGroupCode = TextEditingController();
  TextEditingController _SettingGroupName = TextEditingController();
  TextEditingController _Description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (page < 1) {
      page = 1;
    } else if (page > 4) {
      page = 4;
    }
    bloc = BlocProvider.of<SettingGroupBloc>(context);
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

    return BlocListener<SettingGroupBloc, SettingGroupState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SettingLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SettingError) {
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
        if (state is SettingSuccess) {
          setState(() {
            halo.clear();
            halo = state.resp.data!;
            total = state.resp.countData;
            hal = halo.length;
            // print(halo.length);
          });
        }
        if (state is InitSetSuccess) {
          setState(() {
            halo.clear();
            halo = state.resp.data!;
          });
        }
        if (state is AddSettingSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Data berhasil disimpan',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
          bloc.add(Search(reqset));
        }
        if (state is EditSettingSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Data berhasil diEdit',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.yellow),
            );
          bloc.add(Search(reqset));
        }
        if (state is DeleteSettingSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Delete Success',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
          bloc.add(Search(reqset));
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
                        const Text(
                          'Setting Group',
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
                                      // onTap: () {},
                                      ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Axel Reinald',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Admin',
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
                        children: const [
                          Text(
                            'Home / Admin / SettingGroup',
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
                                        'Setting Group Code',
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
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
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
                                            reqset.groupCd = value;
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
                                        'Setting Group Name',
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
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
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
                                            reqset.groupName = value;
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
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                        reqset.groupCd = '';
                                        _Settinggroupname.clear();
                                        reqset.groupName = '';
                                        halo.clear();
                                        bloc.add(Search(reqset));
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
                          //container table
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
                                            AddDialog();
                                          }, //=> AddDialog.showMyDialog(context),
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
                                            EditSetting();
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
                                          onPressed: () {
                                            DeleteSetting();
                                          },
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
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                '/settinggroup/import');
                                          },
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
                                      InkWell(
                                        onTap: () {
                                          dowreq.groupName;
                                          dowreq.groupCd;
                                          print('masuk download');
                                          bloc.add(Download(dowreq));
                                        },
                                        child: Card(
                                          child: Container(
                                            color: Colors.blue,
                                            height: 40,
                                            width: 120,
                                            child: Center(
                                              child: Text(
                                                'Download',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SingleChildScrollView(
                                    controller: _horizontalscroll,
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      children: [
                                        Container(
                                          //table header
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Color(_birulangit),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                                child: Checkbox(
                                                  checkColor: Colors.black,
                                                  fillColor:
                                                      MaterialStateProperty
                                                          .resolveWith(
                                                              getColor),
                                                  value: isChecked,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isChecked = !isChecked;
                                                    });
                                                  },
                                                  side: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                height: 50,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Setting Group Code',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                height: 50,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Setting Group Name',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                height: 50,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Description',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                height: 50,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Created By',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                height: 50,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Created Date',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                height: 50,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Change By',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                height: 50,
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 15),
                                                  child: Text(
                                                    'Change Date',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (halo.length > 0 || halo.isNotEmpty)
                                          BlocBuilder<SettingGroupBloc,
                                              SettingGroupState>(
                                            builder: (context, state) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView.builder(
                                                  controller: TableScroll,
                                                  itemCount: halo.length,
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
                                                                Colors.black,
                                                            fillColor:
                                                                MaterialStateProperty
                                                                    .resolveWith(
                                                                        getColor),
                                                            value: halo[index]
                                                                .isChecked,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                halo[index]
                                                                        .isChecked =
                                                                    value!;
                                                              });
                                                            },
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                        const SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              halo[index]
                                                                  .settingGroupCode
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              halo[index]
                                                                  .settingGroupName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              halo[index]
                                                                  .settingGroupDesc
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              halo[index]
                                                                  .createdBy
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              halo[index]
                                                                  .createdTime
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              halo[index]
                                                                  .updatedBy
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              halo[index]
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
                                                    Divider(
                                                      height: 0.2,
                                                      thickness: 0.8,
                                                      color: Colors.grey,
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
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
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
                              child: BlocBuilder<SettingGroupBloc,
                                  SettingGroupState>(
                                builder: (context, state) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Showing: ',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        ('1 - ' + hal.toString() + ' of'),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        (total.toString() + ' data'),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            reqset.pageSize = 10;
                                            reqset.pageNumber = 0;
                                            page = 1;
                                            bloc.add(Search(reqset));
                                          });
                                        },
                                        icon: Icon(
                                          Icons.keyboard_double_arrow_left,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            page--;
                                            reqset.pageSize = 10;
                                            reqset.pageNumber = page - 1;

                                            bloc.add(Search(reqset));
                                          });
                                        },
                                        icon: Icon(
                                          Icons.keyboard_arrow_left,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Center(
                                          child: Text(
                                            page.toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              reqset.pageSize = 10;
                                              reqset.pageNumber = page;
                                              page++;
                                              bloc.add(Search(reqset));
                                            });
                                          },
                                          icon: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.black,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              reqset.pageSize = 10;
                                              reqset.pageNumber = 3;
                                              page = 4;
                                              bloc.add(Search(reqset));
                                            });
                                          },
                                          icon: Icon(
                                            Icons.keyboard_double_arrow_right,
                                            color: Colors.black,
                                          )),
                                    ],
                                  );
                                },
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

  void EditSetting() {
    var holder_1 = [];
    for (int i = 0; i < halo.length; i++) {
      if (halo[i].isChecked == true) {
        holder_1.add(halo[i].settingGroupCode.toString() +
            ";" +
            halo[i].settingGroupName.toString() +
            ";" +
            halo[i].settingGroupDesc.toString());
      }
    }
    if (holder_1.length == 1) {
      print(holder_1.length);
      splited = holder_1[0].toString().split(';');
      String settingGroupCode = splited[0];
      String settingGroupName = splited[1];
      String settingGroupDesc = splited[2];
      EditDialog1(settingGroupCode, settingGroupName, settingGroupDesc);
    } else {
      print(holder_1.length);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 5),
              content: Text(
                'Pilih Satu Data!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red),
        );
    }
  }

  Future AddDialog() => showDialog(
        //fungsi add dialog
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Setting Group - Add',
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
                      ))
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.blue,
              )
            ],
          ),
          content: Container(
            height: 400,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Setting Group Code',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _SettingGroupCode,
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
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.grey.shade400),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Setting Group Name',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _SettingGroupName,
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
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.grey.shade400),
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
                  controller: _Description,
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
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.grey.shade400),
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
                          addset.groupCd = _SettingGroupCode.text;
                          addset.groupDesc = _SettingGroupName.text;
                          addset.groupName = _Description.text;
                          bloc.add(Add(addset));
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Future EditDialog1(
          String settingCd, String settingName, String settingdesc) =>
      showDialog(
        //fungsi edit dialog
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Setting Group - Edit',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 25,
                  ))
            ],
          ),
          content: Container(
            height: 400,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Setting Group Code',
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
                    // color: Colors.blue.shade100,
                    child: TextFormField(
                      initialValue: settingCd,
                      readOnly: true,
                      // maxLength: 20,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Setting Group Name',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  //controller: _EditGroupName,
                  initialValue: settingName,
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
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.grey.shade400),
                    ),
                  ),
                  onChanged: (value) {
                    addset.groupName = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Description',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: settingdesc,
                  //controller: _EditDescription,
                  maxLines: 5, // <-- SEE HERE
                  minLines: 1,
                  maxLength: 150,
                  // maxLength: 150,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.grey.shade400),
                    ),
                  ),
                  onChanged: (value) {
                    addset.groupDesc = value;
                  },
                ),
                const Spacer(),
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
                        addset.groupCd = settingCd;
                        // addset.groupDesc = _EditGroupName.text;
                        // addset.groupName = _EditDescription.text;
                        bloc.add(Edit(addset));
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  void DeleteSetting() {
    var check = [];
    List<ListCode> holder_1 = [];
    ListCode model = ListCode();
    delset.listCode = [];
    // print(check.length);

    for (int i = 0; i < halo.length; i++) {
      if (halo[i].isChecked == true) {
        check.add(halo[i].settingGroupCode.toString());
      }
    }

    // print(check.length);

    if (check.length < 1) {
      // print("sini : " + check.length.toString());
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 5),
              content: Text(
                'Pilih minimal 1 data untuk dihapus',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red),
        );
      return null;
    } else if (check.length >= 1) {
      for (var element in halo) {
        if (element.isChecked == true) {
          //model.code = element.settingGroupCode;
          delset.listCode!.add(ListCode(code: element.settingGroupCode));
          print(element);
        }
      }
      print(delset);
      bloc.add(Delete(delset));
    }

    // for (var element in halo) {
    //   if (element.isChecked == true) {
    //     //model.code = element.settingGroupCode;
    //     delset.listCode!.add(ListCode(code: element.settingGroupCode));
    //     print(element);
    //   }
    // }
    // print(delset);
    // bloc.add(Delete(delset));

    // bloc.add(Delete(delset));
    // if (holder_1.length >= 1) {
    //   print("total checkbnx = " + holder_1.length.toString());
    //   splited = holder_1[0].toString().split(';');
    //   String settingGroupCode = splited[0];
    //   ListCode code = new ListCode();
    //   List<ListCode> listcode = [];
    //   code.code = settingGroupCode;
    //   listcode.addAll(listcode);
    //   delset.listCode = listcode;
    //   bloc.add(Delete(delset));
    // } else

    // List<String> lisDeletReq = [];
    // lisDeletReq.addAll(respSearch.rem);
  }
}
