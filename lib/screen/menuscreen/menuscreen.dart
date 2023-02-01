import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/menubloc/bloc/menu_screen_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/menumodel.dart';
import 'package:web_wot/screen/menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late MenuScreenBloc bloc;
  bool _large = true;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  DownloadReq downreq = DownloadReq();
  List<ParentData> parentfield = [];
  GlobalKey<FormFieldState> _keymenu = GlobalKey<FormFieldState>();
  RequestMenuSearch req = RequestMenuSearch();
  ResponseMenuSearch respon = ResponseMenuSearch();
  GlobalKey<FormFieldState> _keyaddmenu = GlobalKey<FormFieldState>();
  final _menuaddKey = GlobalKey<FormState>();
  final ScrollController _scrollgrid = ScrollController();
  List<RespSearchData> ex = [];
  bool isChecked = false;
  RequestMenuDel delreq = RequestMenuDel();
  String? dropdownValue;
  int id = 1;
  String? dropdownValues;
  String? dropdownedit;
  List<DelListCode> menudel = [];
  TextEditingController _Menucode = TextEditingController();
  TextEditingController _Menuname = TextEditingController();
  TextEditingController _MenuCode = TextEditingController();
  TextEditingController _MenuName = TextEditingController();
  TextEditingController _AddMenuCode = TextEditingController();
  TextEditingController _AddMenuName = TextEditingController();
  TextEditingController _AddURL = TextEditingController();
  RequestMenuAdd addmenu = RequestMenuAdd();
  TextEditingController _URL = TextEditingController();
  List<String> options = [];
  List<String> optionsedit = [];
  DownData downdata = DownData();

  // Group Value for Radio Button.
  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<MenuScreenBloc>(context);
    req.menuCd = "";
    req.menuName = "";
    req.parent = "";
    req.pageNumber = 1;
    req.pageSize = 10;
    bloc.add(Search(req));
    bloc.add(GetParent());
    super.initState();
  }

  String? _character;
  void _handleGenderChange(String value) {
    setState(() {
      _character = value;
    });
  }

  int? hal;
  int? total;
  double _size = 250.0;
  RequestMenuSearch reqmenu = RequestMenuSearch();

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MenuScreenBloc>(context);
    return BlocListener<MenuScreenBloc, MenuScreenState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is MenuLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MenuError) {
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
        if (state is SearchSuccess) {
          setState(() {
            ex.clear();
            ex = state.resp.data!;
            respon = state.resp;
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
          bloc.add(Search(req));
        }
        if (state is DeleteMenuSuccess) {
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
          bloc.add(Search(req));
        }
        if (state is EditMenuSuccess) {
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
          bloc.add(Search(req));
        }
        if (state is GetParentSuccess) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              options.add(state.resp.data![i].menuId.toString() +
                  " - " +
                  state.resp.data![i].menuName.toString());
              ParentData pd = new ParentData();
              pd.menuId = state.resp.data![i].menuId.toString();
              pd.menuName = state.resp.data![i].menuName.toString();
              parentfield.add(pd);
              optionsedit.add(state.resp.data![i].menuName.toString());
            }
          });
        }
        if (state is DownloadMenuSuccess) {
          setState(() {
            downdata = state.resp.data!;
            writeFileWeb(
                downdata.base64Data.toString(), downdata.fileName.toString());
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
                        const Text(
                          'Menu',
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
                            'Home / User Access / Menu',
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
                                              'Parent',
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
                                                  key: _keymenu,
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
                                                        val.split(" - ")[1],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      value: val,
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    dropdownValue = val;
                                                    req.parent =
                                                        val!.split(" - ")[0];
                                                    // reqset.settingGroup = dropdownValue;
                                                    // bloc.add(Search(reqset));
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
                                          text: 'Menu Code',
                                          controller: _Menucode,
                                          length: 15,
                                          onChanged: (val) {
                                            req.menuCd = val;
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Textbox(
                                          text: 'Menu Name',
                                          controller: _Menuname,
                                          length: 15,
                                          onChanged: (val) {
                                            req.menuName = val;
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
                                              bloc.add(Search(req));
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
                                              _keymenu.currentState!.reset();
                                              _Menucode.clear();
                                              req.menuCd = '';
                                              req.menuName = '';
                                              req.parent = '';
                                              _Menuname.clear();
                                              bloc.add(Search(req));
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
                                  // controller: _tablescrolls,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 120,
                                            child: TextButton(
                                              onPressed: () {
                                                AddMenuDialog();
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
                                                EditAction();
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
                                                DeleteMenuAction();
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
                                                    '/menuscreen/import');
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
                                                            downreq.menuCd =
                                                                req.menuCd;
                                                            downreq.menuName =
                                                                req.menuName;
                                                            downreq.parent =
                                                                req.parent;
                                                            downreq.extention =
                                                                'csv';
                                                            bloc.add(
                                                                DownloadMenu(
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
                                                            downreq.menuCd =
                                                                req.menuCd;
                                                            downreq.menuName =
                                                                req.menuName;
                                                            downreq.parent =
                                                                req.parent;
                                                            downreq.extention =
                                                                'xls';
                                                            bloc.add(
                                                                DownloadMenu(
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
                                                            downreq.menuCd =
                                                                req.menuCd;
                                                            downreq.menuName =
                                                                req.menuName;
                                                            downreq.parent =
                                                                req.parent;
                                                            downreq.extention =
                                                                'xlsx';
                                                            bloc.add(
                                                                DownloadMenu(
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
                                          // controller: _tablescroll,
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
                                                          'Menu Code',
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
                                                          'Menu Name',
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
                                                          'Parent',
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
                                                          'Type',
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
                                                          'URL',
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
                                                BlocBuilder<MenuScreenBloc,
                                                    MenuScreenState>(
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
                                                                            .menuCd
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
                                                                            .menuName
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
                                                                            .parent
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
                                                                            .type
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
                                                                            .url
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
                                                ),
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
                                      ('1 - ' +
                                          respon.totalDataInPage.toString() +
                                          ' of'),
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      (respon.totalData.toString() + ' data'),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          req.pageSize = 10;
                                          req.pageNumber = 1;
                                          bloc.add(Search(req));
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
                                          req.pageSize = 10;
                                          req.pageNumber = respon.pageNo! - 1;
                                          bloc.add(Search(req));
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
                                          respon.pageNo.toString(),
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
                                            req.pageSize = 10;
                                            req.pageNumber = respon.pageNo! + 1;
                                            bloc.add(Search(req));
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
                                            req.pageSize = 10;
                                            req.pageNumber = respon.totalPages;
                                            bloc.add(Search(req));
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

  Future AddMenuDialog() => showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Menu - Add',
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
                      key: _menuaddKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Menu Code',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _AddMenuCode,
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
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Harap diisi, Tidak boleh kosong';
                            //   }
                            //   return null;
                            // },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Menu Name',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _AddMenuName,
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
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Harap diisi, Tidak boleh kosong';
                            //   }
                            //   return null;
                            // },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Parent',
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
                                key: _keyaddmenu,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 3.0,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                dropdownColor: Colors.white,
                                value: dropdownValues != ""
                                    ? dropdownValues
                                    : null,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                                items: options.map((vals) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      vals.split(" - ")[1],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    value: vals,
                                  );
                                }).toList(),
                                onChanged: (vals) {
                                  addmenu.parent = vals!.split(" - ")[0];
                                  // reqset.settingGroup = dropdownValue;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(bottom: 8, top: 8, right: 10),
                              child: Text('Type',
                                  style: TextStyle(color: Colors.black))),
                          StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio<String>(
                                    hoverColor: Colors.grey.shade300,
                                    activeColor: Colors.black,
                                    value: "FOLDER",
                                    groupValue: _character,
                                    onChanged: (val) {
                                      setState(() {
                                        _character = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Folder',
                                    style: new TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                  Radio<String>(
                                    hoverColor: Colors.grey.shade300,
                                    activeColor: Colors.black,
                                    value: "MENU",
                                    groupValue: _character,
                                    onChanged: (val) {
                                      setState(() {
                                        _character = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Menu',
                                    style: new TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                ]);
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'URL',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _AddURL,
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
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Harap diisi, Tidak boleh kosong';
                            //   }
                            //   return null;
                            // },
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
                                      color: Colors.blue,
                                      width: 1), //<-- SEE HERE
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_menuaddKey.currentState!.validate()) {
                                    setState(() {
                                      addmenu.menuCd = _AddMenuCode.text;
                                      addmenu.menuName = _AddMenuName.text;
                                      addmenu.type = _character.toString();
                                      // addmenu.parent = dropdownValues;
                                      addmenu.url = _AddURL.text;
                                      bloc.add(AddMenu(addmenu));
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
            )),
      );
  Future EditMenuDialog(String? menucode, String? menuname, String? _character,
          String? parents, String? url) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Menu - Edit',
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
                ]),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Menu Code',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300),
                              child: TextFormField(
                                initialValue: menucode,
                                readOnly: true,
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
                                        width: 1.0,
                                        color: Colors.grey.shade400),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Menu Name',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              initialValue: menuname,
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
                              onChanged: (value) {
                                addmenu.menuName = value;
                                menuname = addmenu.menuName;
                              },
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Harap diisi, Tidak boleh kosong';
                              //   }
                              //   return null;
                              // },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Parent',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
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
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 3.0,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  dropdownColor: Colors.white,
                                  value: parents,
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  items: optionsedit.map((valse) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        valse,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      value: valse,
                                    );
                                  }).toList(),
                                  onChanged: (valse) {
                                    parents = valse;
                                    addmenu.parent = valse;
                                    // if (valse == options) parents = valse;
                                    // addmenu.parent = parents;
                                    // reqset.settingGroup = dropdownValue;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8, top: 8, right: 10),
                                child: Text('Type',
                                    style: TextStyle(color: Colors.black))),
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio<String>(
                                      hoverColor: Colors.grey.shade300,
                                      activeColor: Colors.black,
                                      value: "FOLDER",
                                      groupValue: _character,
                                      onChanged: (val) {
                                        setState(() {
                                          _character = val;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Folder',
                                      style: new TextStyle(
                                          fontSize: 17.0, color: Colors.black),
                                    ),
                                    Radio<String>(
                                      hoverColor: Colors.grey.shade300,
                                      activeColor: Colors.black,
                                      value: "MENU",
                                      groupValue: _character,
                                      onChanged: (val) {
                                        setState(() {
                                          _character = val;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Menu',
                                      style: new TextStyle(
                                          fontSize: 17.0, color: Colors.black),
                                    ),
                                  ]);
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'URL',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              initialValue: url,
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
                              onChanged: (value) {
                                addmenu.url = value;
                                url = addmenu.url;
                              },
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Harap diisi, Tidak boleh kosong';
                              //   }
                              //   return null;
                              // },
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
                                        color: Colors.blue,
                                        width: 1), //<-- SEE HERE
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      for (int i = 0;
                                          i < parentfield.length;
                                          i++) {
                                        if (parents ==
                                            parentfield[i].menuName) {
                                          parents =
                                              parentfield[i].menuId.toString();
                                          addmenu.parent = parents;
                                        }
                                      }
                                      addmenu.menuCd = menucode;
                                      addmenu.menuName = menuname;
                                      addmenu.url = url;
                                      addmenu.type = _character.toString();
                                      bloc.add(EditMenu(addmenu));
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
              ));

  void EditAction() {
    var check = [];
    var parentedit;

    for (int i = 0; i < ex.length; i++) {
      if (ex[i].isChecked == true) {
        parentedit = cekparent(parentfield, ex[i].parent!);
        check.add(ex[i].menuCd.toString() +
            ";" +
            ex[i].menuName.toString() +
            ";" +
            ex[i].type.toString().toUpperCase() +
            ";" +
            ex[i].parent.toString() +
            ";" +
            ex[i].url.toString());
      }
    }
    if (check.length == 1) {
      var splitted = check[0].toString().split(";");
      String Menucd = splitted[0];
      String Menuname = splitted[1];
      String Type = splitted[2];
      String Parentname = splitted[3];
      String Url = splitted[4];
      EditMenuDialog(Menucd, Menuname, Type, Parentname, Url);
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

  String? cekparent(List<ParentData> comps, String menuid) {
    String result;
    for (int i = 0; i < comps.length; i++) {
      if (comps[i].menuId == menuid) {
        result = comps[i].menuName.toString();
        return result;
      } else {
        continue;
      }
    }
    return null;
  }

  void DeleteMenuAction() {
    var check = [];
    delreq.listCode = [];

    for (int i = 0; i < ex.length; i++) {
      if (ex[i].isChecked == true) {
        check.add(ex[i].menuCd.toString());
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
          delreq.listCode!.add(DelListCode(code: element.menuCd));
        }
      }
      bloc.add(DeleteMenu(delreq));
    }
  }
}
