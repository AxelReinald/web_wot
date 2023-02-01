import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/settingsbloc/bloc/setting_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/setting.dart';
import 'package:web_wot/screen/menu.dart';
// import 'package:bloc/bloc.dart';
// import 'package:web_wot/service/restapi.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> with SingleTickerProviderStateMixin {
  GlobalKey<FormFieldState> _keysettinggroup = GlobalKey<FormFieldState>();

  RequestSettings reqset = new RequestSettings();
  double _size = 250.0;
  late SettingBloc bloc;
  int? hal;
  int? total;
  String? dropdownValue;
  String? dropdownValuetype;
  String? dropdownValues;
  // bool _autovalidate = false;
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
    bloc.add(GetDataSettingGroupCode());
    bloc.add(GetDataSettingValueType());
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
  List<GetData> formgroupcode = [];
  DsetData downloaddoc = DsetData();
  ResponseGetSettingGroupCode resp = ResponseGetSettingGroupCode();
  DownloadTemplateData tempsetting = DownloadTemplateData();
  RequestAddSetting addsetting = RequestAddSetting();
  DeleteRequestSetting delsets = DeleteRequestSetting();
  DownloadRequestSettings downreq = DownloadRequestSettings();
  List<String> options = [];
  List<String> optionsvalue = [];
  final ScrollController _scrollgrid = ScrollController();
  final ScrollController _headtable = ScrollController();
  final ScrollController _tablescrolls = ScrollController();
  final ScrollController _mainscroll = ScrollController();
  final ScrollController _tablescroll = ScrollController();

  //text field controller
  TextEditingController _Settinggroupcd = TextEditingController();
  TextEditingController _Settingcode = TextEditingController();
  TextEditingController _Value = TextEditingController();
  // TextEditingController _SettingGroup = TextEditingController();
  TextEditingController _SettingCode = TextEditingController();
  TextEditingController _SettingDescription = TextEditingController();
  // TextEditingController _SettingValueType = TextEditingController();
  TextEditingController _SettingValue = TextEditingController();

  final _addKey = GlobalKey<FormState>();
  // final _editKey = GlobalKey<FormState>();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SettingBloc>(context);
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
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
            hal = ex.length;
            total = state.resp.countData;
          });
        }
        if (state is DownloadSettingSuccess) {
          setState(() {
            downloaddoc = state.resp.data!;
            writeFileWeb(downloaddoc.base64Data.toString(),
                downloaddoc.fileName.toString());
          });
        }
        if (state is AddSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Data berhasil disimpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
          bloc.add(Search(reqset));
        }
        if (state is DeleteSuccess) {
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
        if (state is EditSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Data berhasil disimpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
          bloc.add(Search(reqset));
        }
        if (state is InitSetsSuccess) {
          setState(() {
            ex.clear();
            ex = state.resp.data!;
          });
        }
        if (state is GetDataSettingGroupSuccess) {
          setState(() {
            // formgroupcode.clear();
            // options.add(state.resp.data.);
            for (int i = 0; i < state.resp.data!.length; i++) {
              options.add(state.resp.data![i].settingGroupCd.toString());
            }
          });
        }
        if (state is GetDataSettingValueTypeSuccess) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              optionsvalue.add(state.resp.data![i].paramCode.toString());
            }
          });
        }
        if (state is TemplateSuccess) {
          setState(() {
            tempsetting = state.resp.data!;
            writeFileWeb(tempsetting.base64Data.toString(),
                tempsetting.fileName.toString());
          });
        }
      },
      child: Scaffold(
        body: Row(
          children: [
            Menu(size: _size),
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
                            'Home / Master / Setting',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          scrollbarTheme: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(Colors.black),
                      )),
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Setting Group',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 250,
                                              height: 35,
                                              margin:
                                                  EdgeInsets.only(bottom: 17),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade400),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  key: _keysettinggroup,
                                                  decoration:
                                                      const InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 3.0,
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  value: dropdownValue != ""
                                                      ? dropdownValue
                                                      : null,
                                                  isExpanded: true,
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black),
                                                  items: options.map((val) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        val,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      value: val,
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    dropdownValue = val;
                                                    reqset.settingGroup =
                                                        dropdownValue;
                                                    bloc.add(Search(reqset));
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Textbox(
                                          text: 'Setting Code',
                                          controller: _Settingcode,
                                          length: 15,
                                          onChanged: (val) {
                                            reqset.settingCode = val;
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Textbox(
                                          text: 'Value',
                                          controller: _Value,
                                          length: 15,
                                          onChanged: (val) {
                                            reqset.value = val;
                                          },
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
                                              style: TextStyle(
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
                                              dropdownValue = null;
                                              _keysettinggroup.currentState!
                                                  .reset();
                                              _Settinggroupcd.clear();
                                              reqset.settingCode = '';
                                              _Settingcode.clear();
                                              reqset.settingGroup = '';
                                              _Value.clear();
                                              reqset.value = '';
                                              bloc.add(Search(reqset));
                                            },
                                            child: const Text('Clear'),
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 1.0,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            // width: 2000,
                            color: const Color(0xFFE7E7E7),
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  controller: _tablescrolls,
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
                                                    width: 1.0,
                                                    color: Colors.blue),
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
                                                DeleteSettings();
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
                                                    width: 1.0,
                                                    color: Colors.blue),
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
                                                    '/setting/import');
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
                                                    width: 1.0,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Card(
                                            child: Container(
                                              color: Colors.blue,
                                              height: 40,
                                              width: 120,
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  cardColor:
                                                      Colors.grey.shade600,
                                                ),
                                                child: PopupMenuButton(
                                                  offset: Offset(-3, 40),
                                                  tooltip: '',
                                                  child: const Center(
                                                    child: Text(
                                                      'Download',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            downreq.settingGroup =
                                                                reqset
                                                                    .settingGroup;
                                                            downreq.settingName =
                                                                _Settingcode
                                                                    .text;
                                                            downreq.value =
                                                                _Value.text;
                                                            downreq.extention =
                                                                'csv';
                                                            bloc.add(
                                                                DownloadFile(
                                                                    downreq));
                                                          },
                                                        );
                                                      },
                                                      value: () {},
                                                      child: const Text(
                                                        'CSV',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            downreq.settingGroup =
                                                                reqset
                                                                    .settingGroup;
                                                            downreq.settingName =
                                                                _Settingcode
                                                                    .text;
                                                            downreq.value =
                                                                _Value.text;
                                                            downreq.extention =
                                                                'xls';
                                                            bloc.add(
                                                                DownloadFile(
                                                                    downreq));
                                                          },
                                                        );
                                                      },
                                                      value:
                                                          () {}, //_exportToExcel,
                                                      child: const Text(
                                                        'XLS',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            downreq.settingGroup =
                                                                reqset
                                                                    .settingGroup;
                                                            downreq.settingName =
                                                                _Settingcode
                                                                    .text;
                                                            downreq.value =
                                                                _Value.text;
                                                            downreq.extention =
                                                                'xlsx';
                                                            bloc.add(
                                                                DownloadFile(
                                                                    downreq));
                                                          },
                                                        );
                                                      },
                                                      value: () {},
                                                      child: const Text(
                                                        'XLSX',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      ScrollConfiguration(
                                        behavior: MyCustomScrollBehavior(),
                                        child: SingleChildScrollView(
                                          controller: _tablescroll,
                                          scrollDirection: Axis.horizontal,
                                          child: Column(
                                            children: [
                                              Container(
                                                //table header
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: birulangit,
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
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            var i = 0;
                                                            if (ex[i]
                                                                    .isChecked ==
                                                                false) {
                                                              isChecked = true;
                                                              for (i = 0;
                                                                  i < ex.length;
                                                                  i++)
                                                                ex[i].isChecked =
                                                                    true;
                                                            } else if (ex[i]
                                                                    .isChecked ==
                                                                true) {
                                                              isChecked = false;
                                                              for (i = 0;
                                                                  i < ex.length;
                                                                  i++)
                                                                ex[i].isChecked =
                                                                    false;
                                                            }
                                                          });
                                                        },
                                                        side: const BorderSide(
                                                            color: Colors.grey),
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
                                                              0.07,
                                                      height: 50,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Setting Group',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Setting Code',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Description',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                              0.08,
                                                      height: 50,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          'Data Type',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          'Value',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Created By',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Created Date',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Changed By',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Changed Date',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              if (ex.length > 0 ||
                                                  ex.isNotEmpty)
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
                                                                Column(
                                                                    children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.03,
                                                                    child:
                                                                        Checkbox(
                                                                      checkColor:
                                                                          Colors
                                                                              .black,
                                                                      fillColor:
                                                                          MaterialStateProperty.resolveWith(
                                                                              getColor),
                                                                      value: ex[
                                                                              index]
                                                                          .isChecked,
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          ex[index].isChecked =
                                                                              value!;
                                                                        });
                                                                      },
                                                                      side: const BorderSide(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.07,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .settingGroupCode
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .settingCode
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .settingDesc
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.08,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .settingValueType
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .settingValue
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .createdBy
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .createdTime
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .updatedBy
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        ex[index]
                                                                            .updatedTime
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
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
                                        ),
                                      ),
                                    ],
                                  ),
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 5, 16, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Showing:',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      ('1 - ' + hal.toString() + ' of'),
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
                                    ),
                                    const SizedBox(
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
                                          // page = 1;
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
                                          //  page--;
                                          reqset.pageSize = 10;
                                          //  reqset.pageNumber = page - 1;

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
                                      width: 30,
                                      // color: Colors.blue,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: Colors.blue)),
                                      child: Center(
                                        child: Text(
                                          '1',
                                          //  page.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            // reqset.pageNumber = page;
                                            // page++;
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
                                            // page = 4;
                                            bloc.add(Search(reqset));
                                          });
                                        },
                                        icon: Icon(
                                          Icons.keyboard_double_arrow_right,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
    var check = [];
    for (int i = 0; i < ex.length; i++) {
      if (ex[i].isChecked == true) {
        check.add(ex[i].settingGroupCode.toString() +
            ";" +
            ex[i].settingCode.toString() +
            ";" +
            ex[i].settingDesc.toString() +
            ";" +
            ex[i].settingValueType.toString() +
            ";" +
            ex[i].settingValue.toString());
      }
    }
    if (check.length == 1) {
      var splitted = check[0].toString().split(";");
      String settingGroupCode = splitted[0];
      String settingCode = splitted[1];
      String settingDesc = splitted[2];
      String settingValueType = splitted[3];
      String settingValue = splitted[4];
      EditSettingDialog(settingGroupCode, settingCode, settingDesc,
          settingValueType, settingValue);
    } else {
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
              controller: _scrollgrid,
              scrollDirection: Axis.vertical,
              child: Container(
                height: 600,
                width: 550,
                child: Form(
                  key: _addKey,
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.065,
                        margin: EdgeInsets.only(bottom: 17),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            // key: _keysettinggroupadd,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 3.0,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValues != "" ? dropdownValues : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: options.map((vals) {
                              return DropdownMenuItem(
                                child: Text(
                                  vals,
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: vals,
                              );
                            }).toList(),
                            onChanged: (vals) {
                              dropdownValues = vals;
                              // reqset.settingGroup = dropdownValue;
                            },
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap diisi, Tidak boleh kosong';
                          }
                          return null;
                        },
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.065,
                        margin: EdgeInsets.only(bottom: 17),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            // key: _keysettingvalue,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 3.0,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownValuetype != ""
                                ? dropdownValuetype
                                : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: optionsvalue.map((valuetype) {
                              return DropdownMenuItem(
                                child: Text(
                                  valuetype,
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: valuetype,
                              );
                            }).toList(),
                            onChanged: (valuetype) {
                              dropdownValuetype = valuetype;
                              // reqset. = dropdownValue;
                            },
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
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
                              if (_addKey.currentState!.validate()) {
                                setState(() {
                                  addsetting.settingDesc =
                                      _SettingDescription.text;
                                  addsetting.settingCode = _SettingCode.text;
                                  addsetting.settingValue = _SettingValue.text;
                                  addsetting.settingGroupCode = dropdownValues;
                                  addsetting.settingValueType =
                                      dropdownValuetype;
                                  bloc.add(AddSetting(addsetting));
                                  //bloc.add(Add(addset));
                                });
                                Navigator.pop(context);
                              }
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
        ),
      );

  Future EditSettingDialog(
          String? settinggroupcd,
          String? settingcode,
          String? settingdesc,
          String? settingvaluetype,
          String? settingvalue) =>
      showDialog(
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
              controller: _headtable,
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.065,
                      margin: EdgeInsets.only(bottom: 17),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          // key: _keysettinggroupadd,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 3.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          dropdownColor: Colors.white,
                          value:
                              settinggroupcd, //dropdownValues != "" ? dropdownValues : null,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: options.map((vals) {
                            return DropdownMenuItem(
                              child: Text(
                                vals,
                                style: TextStyle(color: Colors.black),
                              ),
                              value: vals,
                            );
                          }).toList(),
                          onChanged: (vals) {
                            settinggroupcd = vals;
                            // reqset.settingGroup = dropdownValue;
                          },
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
                          initialValue: settingcode,
                          readOnly: true,
                          cursorColor: Colors.grey,
                          // controller: _SettingCode,
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
                      initialValue: settingdesc,
                      // controller: _SettingDescription,
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
                      onChanged: (value) {
                        addsetting.settingDesc = value;
                        settingdesc = addsetting.settingDesc;
                      },
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.065,
                      margin: EdgeInsets.only(bottom: 17),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          // key: _keysettingvalue,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 3.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          dropdownColor: Colors.white,
                          value: settingvaluetype,
                          // dropdownValuetype != ""
                          //     ? dropdownValuetype
                          //     : null,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: optionsvalue.map((valuetype) {
                            return DropdownMenuItem(
                              child: Text(
                                valuetype,
                                style: TextStyle(color: Colors.black),
                              ),
                              value: valuetype,
                            );
                          }).toList(),

                          onChanged: (valuetype) {
                            settingvaluetype = valuetype;
                            // reqset. = dropdownValue;
                          },
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
                      initialValue: settingvalue,
                      // controller: _SettingValue,
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
                      onChanged: (value) {
                        addsetting.settingValue = value;
                        settingvalue = addsetting.settingValue;
                      },
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
                            addsetting.settingGroupCode = settinggroupcd;
                            addsetting.settingCode = settingcode;
                            addsetting.settingDesc = settingdesc;
                            addsetting.settingValueType = settingvaluetype;
                            addsetting.settingValue = settingvalue;
                            bloc.add(EditSettings(addsetting));
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

  void DeleteSettings() {
    var check = [];
    List<DelListCode> holder_1 = [];
    DelListCode model = DelListCode();
    delsets.listCode = [];

    for (int i = 0; i < ex.length; i++) {
      if (ex[i].isChecked == true) {
        check.add(ex[i].settingCode.toString());
      }
    }

    if (check.length < 1) {
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
      for (var element in ex) {
        if (element.isChecked == true) {
          delsets.listCode!.add(DelListCode(code: element.settingCode));
        }
      }
      bloc.add(DeleteSetting(delsets));
    }
  }
}
