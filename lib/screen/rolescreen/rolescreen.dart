import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/rolebloc/bloc/role_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/rolemodel.dart';
import 'package:web_wot/screen/menu.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen>
    with SingleTickerProviderStateMixin {
  late RoleBloc bloc;
  double _size = 250.0;
  bool _large = true;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  String? _type;
  void _handleGenderChange(String value) {
    setState(() {
      _type = value;
    });
  }

  List<String> options = [];
  String? dropdownValues;
  final _roleaddKey = GlobalKey<FormState>();
  final ScrollController _scrollgrid = ScrollController();
  RequestRoleSearch reqrole = RequestRoleSearch();
  RequestRoleAdd addrole = RequestRoleAdd();
  RequestRoleDelete delreq = RequestRoleDelete();
  ResponseRoleSearch respons = ResponseRoleSearch();
  TextEditingController _RoleAddCode = TextEditingController();
  TextEditingController _RoleAddName = TextEditingController();
  TextEditingController _Description = TextEditingController();
  List<RespData> ex = [];
  bool isChecked = false;
  TextEditingController _Rolecode = TextEditingController();
  TextEditingController _Rolename = TextEditingController();
  DownloadReq downreq = DownloadReq();
  DownData downdata = DownData();
  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<RoleBloc>(context);
    reqrole.pageNumber = 1;
    reqrole.pageSize = 10;
    reqrole.roleCode = "";
    reqrole.roleName = "";
    bloc.add(SearchRole(reqrole));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<RoleBloc>(context);
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

    return BlocListener<RoleBloc, RoleState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is RoleLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EditRoleSuccess) {
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
          bloc.add(SearchRole(reqrole));
        }
        if (state is DownloadRoleSuccess) {
          setState(() {
            downdata = state.resp.data!;
            writeFileWeb(
                downdata.base64Data.toString(), downdata.fileName.toString());
          });
        }
        if (state is RoleError) {
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
        if (state is DeleteRoleSuccess) {
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
          bloc.add(SearchRole(reqrole));
        }
        if (state is SearchSuccess) {
          setState(() {
            ex.clear();
            ex = state.resp.data!;
            respons = state.resp;
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
          bloc.add(SearchRole(reqrole));
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
                          'Role',
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
                            'Home / User Access / Role',
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
                                        Textbox(
                                          text: 'Role Code',
                                          controller: _Rolecode,
                                          length: 15,
                                          onChanged: (val) {
                                            reqrole.roleCode = val;
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Textbox(
                                          text: 'Role Name',
                                          controller: _Rolename,
                                          length: 15,
                                          onChanged: (val) {
                                            reqrole.roleName = val;
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
                                              bloc.add(SearchRole(reqrole));
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
                                              // dropdownValue = null;
                                              // _keysettinggroup.currentState!.reset();
                                              _Rolecode.clear();
                                              reqrole.roleCode = '';
                                              _Rolename.clear();
                                              reqrole.roleName = '';
                                              // _Value.clear();
                                              // reqset.value = '';
                                              bloc.add(SearchRole(reqrole));
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
                                                AddRoleDialog();
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
                                                DeleteRoleAction();
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
                                                Navigator.of(context)
                                                    .pushNamed('/role/import');
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
                                                            downreq.roleCode =
                                                                reqrole
                                                                    .roleCode;
                                                            downreq.roleName =
                                                                reqrole
                                                                    .roleName;
                                                            downreq.extention =
                                                                'csv';
                                                            bloc.add(
                                                                DownloadRole(
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
                                                            downreq.roleCode =
                                                                reqrole
                                                                    .roleCode;
                                                            downreq.roleName =
                                                                reqrole
                                                                    .roleName;
                                                            downreq.extention =
                                                                'xls';
                                                            bloc.add(
                                                                DownloadRole(
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
                                                            downreq.roleCode =
                                                                reqrole
                                                                    .roleCode;
                                                            downreq.roleName =
                                                                reqrole
                                                                    .roleName;
                                                            downreq.extention =
                                                                'xlsx';
                                                            bloc.add(
                                                                DownloadRole(
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
                                                          'Role Code',
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
                                                          'Role Name',
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
                                                          'Type',
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
                                                          'Description',
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
                                                BlocBuilder<RoleBloc,
                                                    RoleState>(
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
                                                                            .roleCode
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
                                                                            .roleName
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
                                                                            .roleType
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
                                                                            .roleDesc
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
                                      ('1 - ' +
                                          respons.totalDataInPage.toString() +
                                          ' of'),
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      (respons.totalData.toString() + ' data'),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          reqrole.pageSize = 10;
                                          reqrole.pageNumber = 1;
                                          bloc.add(SearchRole(reqrole));
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
                                          reqrole.pageSize = 10;
                                          reqrole.pageNumber =
                                              respons.pageNo! - 1;
                                          bloc.add(SearchRole(reqrole));
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
                                          respons.pageNo.toString(),
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
                                            reqrole.pageSize = 10;
                                            reqrole.pageNumber =
                                                respons.pageNo! + 1;
                                            bloc.add(SearchRole(reqrole));
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
                                            reqrole.pageSize = 10;
                                            reqrole.pageNumber =
                                                respons.totalPages;
                                            bloc.add(SearchRole(reqrole));
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

  Future AddRoleDialog() => showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Role - Add',
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
                      key: _roleaddKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Role Code',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _RoleAddCode,
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
                          const Text(
                            'Role Name',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _RoleAddName,
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
                                    value: "Internal",
                                    groupValue: _type,
                                    onChanged: (val) {
                                      setState(() {
                                        _type = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Internal',
                                    style: new TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                  Radio<String>(
                                    hoverColor: Colors.grey.shade300,
                                    activeColor: Colors.black,
                                    value: "External",
                                    groupValue: _type,
                                    onChanged: (val) {
                                      setState(() {
                                        _type = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    'External',
                                    style: new TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                ]);
                          }),
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
                            controller: _Description,
                            maxLength: 20,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 10),
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
                            maxLines: 5,
                            minLines: 3,
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
                                  if (_roleaddKey.currentState!.validate()) {
                                    setState(() {
                                      addrole.roleCode = _RoleAddCode.text;
                                      addrole.roleName = _RoleAddName.text;
                                      addrole.roleType = _type.toString();
                                      addrole.roleDesc = _Description.text;
                                      bloc.add(AddRole(addrole));
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

  Future EditRoleDialog(
          String? rolecd, String? rolename, String? _type, String? desc) =>
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Role - Edit',
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
                      key: _roleaddKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Role Code',
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
                              initialValue: rolecd,
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
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Role Name',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            initialValue: rolename,
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
                            onChanged: (value) {
                              addrole.roleName = value;
                              rolename = addrole.roleName;
                            },
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
                                    value: "INTERNAL",
                                    groupValue: _type,
                                    onChanged: (val) {
                                      setState(() {
                                        _type = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Internal',
                                    style: new TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                  Radio<String>(
                                    hoverColor: Colors.grey.shade300,
                                    activeColor: Colors.black,
                                    value: "EXTERNAL",
                                    groupValue: _type,
                                    onChanged: (val) {
                                      setState(() {
                                        _type = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    'External',
                                    style: new TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                ]);
                          }),
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
                            initialValue: desc,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 10),
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
                            onChanged: (value) {
                              addrole.roleDesc = value;
                              desc = addrole.roleDesc;
                            },
                            maxLines: 5,
                            minLines: 3,
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
                                    addrole.roleCode = rolecd;
                                    addrole.roleName = rolename;
                                    addrole.roleType = _type.toString();
                                    addrole.roleDesc = desc;
                                    bloc.add(EditRole(addrole));
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
            )),
      );

  void EditAction() {
    var check = [];
    for (int i = 0; i < ex.length; i++) {
      if (ex[i].isChecked == true) {
        check.add(ex[i].roleCode.toString() +
            ";" +
            ex[i].roleName.toString() +
            ";" +
            ex[i].roleType.toString().toUpperCase() +
            ";" +
            ex[i].roleDesc.toString());
      }
    }
    if (check.length == 1) {
      var splitted = check[0].toString().split(";");
      String Rolecd = splitted[0];
      String Rolename = splitted[1];
      String Type = splitted[2];
      String Desc = splitted[3];
      print(Type);
      EditRoleDialog(Rolecd, Rolename, Type, Desc);
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

  void DeleteRoleAction() {
    var check = [];
    delreq.listCode = [];

    for (int i = 0; i < ex.length; i++) {
      if (ex[i].isChecked == true) {
        check.add(ex[i].roleCode.toString());
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
          delreq.listCode!.add(DelListCode(code: element.roleCode));
        }
      }
      bloc.add(DeleteRole(delreq));
    }
  }
}
