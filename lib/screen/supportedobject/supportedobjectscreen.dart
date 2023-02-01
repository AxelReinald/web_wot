import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/supportedobjectbloc/bloc/supported_object_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/supportedobjectmodel.dart';
import 'package:web_wot/screen/menu.dart';

class SupportedObject extends StatefulWidget {
  const SupportedObject({Key? key}) : super(key: key);

  @override
  State<SupportedObject> createState() => _SupportedObjectState();
}

class _SupportedObjectState extends State<SupportedObject>
    with SingleTickerProviderStateMixin {
  double _size = 250.0;
  bool _large = true;
  late SupportedObjectBloc bloc;
  bool value = false;
  String? dropdownobj;
  List<String> comobj = [];
  List<String> compadd = [];
  List<DataSO> so = [];
  int? hal;
  int? total;
  RequestDeleteSO delreq = RequestDeleteSO();
  String? dropdownot;
  TextEditingController _Comp = TextEditingController();
  TextEditingController _ObjName = TextEditingController();
  TextEditingController _ObjectCode = TextEditingController();
  TextEditingController _ObjectName = TextEditingController();
  TextEditingController _Desc = TextEditingController();
  RequestSearchSO reqso = RequestSearchSO();
  RequestSOAdd reqsoadd = RequestSOAdd();
  DownloadRequestSO reqdown = DownloadRequestSO();
  DownDataSO downs = DownDataSO();
  bool isChecked = false;
  final _soadd = GlobalKey<FormState>();
  List<GetSOData> comobjtype = [];
  List<ComData> cmbcomp = [];
  List<String> soedittype = [];
  List<String> soeditcom = [];
  String? dropdowncomp;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    bloc = BlocProvider.of<SupportedObjectBloc>(context);
    reqso.pageNumber = 1;
    reqso.pageSize = 10;
    reqso.companyName = '';
    reqso.objectName = '';
    reqso.objectType = '';

    so.clear();
    bloc.add(SearchSO(reqso));
    bloc.add(GetObjectType());
    bloc.add(GetCom());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SupportedObjectBloc>(context);
    return BlocListener<SupportedObjectBloc, SupportedObjectState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadingSO) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorSO) {
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
        if (state is SearchSOSuccess) {
          setState(() {
            so.clear();
            so = state.resp.data!;
            total = state.resp.countData;
            hal = so.length;
          });
        }
        if (state is AddSOSuccess) {
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
          bloc.add(SearchSO(reqso));
        }
        if (state is GetTypeSuccess) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              comobj.add(state.resp.data![i].objectTypeCode.toString() +
                  " - " +
                  state.resp.data![i].objectTypeName.toString());
              GetSOData type = new GetSOData();
              type.objectTypeCode =
                  state.resp.data![i].objectTypeCode.toString();
              type.objectTypeName =
                  state.resp.data![i].objectTypeName.toString();
              comobjtype.add(type);
              soedittype.add(state.resp.data![i].objectTypeName.toString());
              // comobjtype.add(type);
            }
          });
        }
        if (state is GetComSuccess) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              compadd.add(state.resp.data![i].companyId.toString() +
                  " - " +
                  state.resp.data![i].companyName.toString());
              ComData comp = new ComData();
              comp.companyId = state.resp.data![i].companyId.toString();
              comp.companyName = state.resp.data![i].companyName.toString();
              cmbcomp.add(comp);
              soeditcom.add(state.resp.data![i].companyName.toString());
            }
          });
        }
        if (state is EditSOSuccess) {
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
          bloc.add(SearchSO(reqso));
        }
        if (state is DeleteSOSuccess) {
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
          bloc.add(SearchSO(reqso));
        }
        if (state is DownloadSOSuccess) {
          setState(() {
            downs = state.resp.data!;
            writeFileWeb(
                downs.base64Data.toString(), downs.fileName.toString());
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
                          'Supported Object',
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
                            'Home / Master / Supported Object',
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
                        ),
                      ),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        //controller: _mainscroll,
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
                                              'Object Type',
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
                                                  // key: _keycompany,
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
                                                  value: dropdownobj != ""
                                                      ? dropdownobj
                                                      : null,
                                                  isExpanded: true,
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black),
                                                  items: comobj.map((val) {
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
                                                    dropdownobj = val;
                                                    reqso.objectType =
                                                        val!.split(" - ")[1];
                                                    ;
                                                    //  provincelist.
                                                    // dropdownValue = val;
                                                    // comp.business =
                                                    //     val!.split(" - ")[0];
                                                    // dropdownValue =
                                                    //     cityreq.provinceId;
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
                                          text: 'Object Name',
                                          controller: _ObjName,
                                          length: 15,
                                          onChanged: (val) {
                                            reqso.objectName = val;
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Textbox(
                                          text: 'Company',
                                          controller: _Comp,
                                          length: 15,
                                          onChanged: (val) {
                                            reqso.companyName = val;
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
                                              bloc.add(SearchSO(reqso));
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
                                              // dropdownbus = null;
                                              // _keycompany.currentState!.reset();
                                              _ObjName.clear();
                                              _Comp.clear();
                                              reqso.companyName = '';
                                              reqso.objectName = '';
                                              reqso.objectType = '';
                                              bloc.add(SearchSO(reqso));
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
                                  //  controller: _tablescrolls,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 120,
                                            child: TextButton(
                                              onPressed: () {
                                                AddSODialog();
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
                                                EditSODialog();
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
                                                DeleteAction();
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
                                                    '/supportedobject/import');
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
                                                            reqdown.companyName =
                                                                reqso
                                                                    .companyName;
                                                            reqdown.objectName =
                                                                reqso
                                                                    .objectName;
                                                            reqdown.objectType =
                                                                reqso
                                                                    .objectType;
                                                            reqdown.extention =
                                                                'csv';
                                                            bloc.add(
                                                                DownloadFileSO(
                                                                    reqdown));
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
                                                            reqdown.companyName =
                                                                reqso
                                                                    .companyName;
                                                            reqdown.objectName =
                                                                reqso
                                                                    .objectName;
                                                            reqdown.objectType =
                                                                reqso
                                                                    .objectType;
                                                            reqdown.extention =
                                                                'xls';
                                                            bloc.add(
                                                                DownloadFileSO(
                                                                    reqdown));
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
                                                            reqdown.companyName =
                                                                reqso
                                                                    .companyName;
                                                            reqdown.objectName =
                                                                reqso
                                                                    .objectName;
                                                            reqdown.objectType =
                                                                reqso
                                                                    .objectType;
                                                            reqdown.extention =
                                                                'xlsx';
                                                            bloc.add(
                                                                DownloadFileSO(
                                                                    reqdown));
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
                                                            if (so[i]
                                                                    .isChecked ==
                                                                false) {
                                                              isChecked = true;
                                                              for (i = 0;
                                                                  i < so.length;
                                                                  i++)
                                                                so[i].isChecked =
                                                                    true;
                                                            } else if (so[i]
                                                                    .isChecked ==
                                                                true) {
                                                              isChecked = false;
                                                              for (i = 0;
                                                                  i < so.length;
                                                                  i++)
                                                                so[i].isChecked =
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
                                                              0.10,
                                                      height: 50,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Object Code',
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
                                                          'Object Name',
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
                                                          'Object Type',
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
                                                              0.11,
                                                      height: 50,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Company',
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
                                              if (so.length > 0 ||
                                                  so.isNotEmpty)
                                                BlocBuilder<SupportedObjectBloc,
                                                    SupportedObjectState>(
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
                                                        itemCount: so.length,
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
                                                                      value: so[
                                                                              index]
                                                                          .isChecked,
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          so[index].isChecked =
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
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        so[index]
                                                                            .objectCode
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
                                                                        so[index]
                                                                            .objectName
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
                                                                        so[index]
                                                                            .objectTypeName
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
                                                                        so[index]
                                                                            .description
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
                                                                        0.11,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        so[index]
                                                                            .companyName
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
                                                                        so[index]
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
                                                                        so[index]
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
                                                                        so[index]
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
                                                                        so[index]
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
                                          reqso.pageNumber = 1;
                                          reqso.pageSize = 10;
                                          // cityreq.pageSize = 10;
                                          // cityreq.pageNumber = 0;
                                          // page = 1;
                                          // bloc.add(Search(reqset));
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
                                          reqso.pageSize = 10;
                                          //  page--;
                                          // cityreq.pageSize = 10;
                                          //  reqset.pageNumber = page - 1;

                                          //  bloc.add(Search(reqset));
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
                                            reqso.pageSize = 10;
                                            // reqset.pageNumber = page;
                                            // page++;
                                            //  bloc.add(Search(reqset));
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
                                            reqso.pageSize = 10;
                                            reqso.pageNumber = 3;
                                            // page = 4;
                                            // bloc.add(Search(reqset));
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

  Future AddSODialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Supported Object - Add',
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
                height: MediaQuery.of(context).size.height * 0.78,
                width: 550,
                child: Form(
                  key: _soadd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Object Code',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _ObjectCode,
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
                        'Object Name',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _ObjectName,
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
                        'Object Type',
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
                            value: dropdownot != "" ? dropdownot : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: comobj.map((vals) {
                              return DropdownMenuItem(
                                child: Text(
                                  vals.split(" - ")[1],
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: vals,
                              );
                            }).toList(),
                            onChanged: (vals) {
                              reqsoadd.objectType = vals!.split(" - ")[0];
                              // reqset.settingGroup = dropdownValue;
                            },
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
                        controller: _Desc,
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
                        'Company',
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
                            value: dropdowncomp != "" ? dropdowncomp : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: compadd.map((vale) {
                              return DropdownMenuItem(
                                child: Text(
                                  vale.split(" - ")[1],
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: vale,
                              );
                            }).toList(),
                            onChanged: (vale) {
                              reqsoadd.companyId = vale!.split(" - ")[0];
                              // reqset.settingGroup = dropdownValue;
                            },
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
                              if (_soadd.currentState!.validate()) {
                                setState(() {
                                  reqsoadd.objectCode = _ObjectCode.text;
                                  reqsoadd.objectName = _ObjectName.text;
                                  reqsoadd.description = _Desc.text;
                                  bloc.add(AddSO(reqsoadd));
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

  void EditSODialog() {
    var check = [];
    var cSOObjType;
    var cSOComp;

    for (int i = 0; i < so.length; i++) {
      if (so[i].isChecked == true) {
        cSOObjType = cekcSOObjType(comobjtype, so[i].objectTypeCode!);
        cSOComp = cekcSOComp(cmbcomp, so[i].companyId!);
        check.add(so[i].objectCode.toString() +
            ";" +
            so[i].objectName.toString() +
            ";" +
            cSOObjType.toString() +
            ";" +
            so[i].description.toString() +
            ";" +
            cSOComp.toString());
      }
    }
    if (check.length == 1) {
      var splitted = check[0].toString().split(";");
      String Objcd = splitted[0];
      String Objname = splitted[1];
      String Objtype = splitted[2];
      String Objdesc = splitted[3];
      String Comp = splitted[4];
      EditSO(Objcd, Objname, Objtype, Objdesc, Comp);
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

  String? cekcSOObjType(List<GetSOData> comtype, String objCd) {
    String result;
    for (int i = 0; i < comtype.length; i++) {
      if (comtype[i].objectTypeCode == objCd) {
        result = comtype[i].objectTypeName.toString();
        return result;
      } else {
        continue;
      }
    }
    return null;
  }

  String? cekcSOComp(List<ComData> comp, String compid) {
    String result;
    for (int i = 0; i < comp.length; i++) {
      if (comp[i].companyId == compid) {
        result = comp[i].companyName.toString();
        return result;
      } else {
        continue;
      }
    }
    return null;
  }

  Future EditSO(String? objcd, String? objname, String? objtype,
          String? objdesc, String? comp) =>
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
                    'Supported Object - Edit',
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
              //controller: _edittable,
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Object Code',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      //controller: _ObjectCode,
                      initialValue: objcd,
                      readOnly: true,
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
                    Text(
                      'Object Name',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      // controller: _ObjectName,
                      initialValue: objname,
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
                        reqsoadd.objectName = value;
                        objname = reqsoadd.objectName;
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
                    Text(
                      'Object Type',
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
                          value: objtype,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: soedittype.map((vals) {
                            return DropdownMenuItem(
                              child: Text(
                                vals, //.split(" - ")[1],
                                style: TextStyle(color: Colors.black),
                              ),
                              value: vals,
                            );
                          }).toList(),
                          onChanged: (vals) {
                            objtype = vals;
                          },
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
                      // controller: _ObjectName,
                      initialValue: objdesc,
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
                        reqsoadd.description = value;
                        objdesc = reqsoadd.description;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Company',
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
                          value: comp,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: soeditcom.map((vals) {
                            return DropdownMenuItem(
                              child: Text(
                                vals, //.split(" - ")[1],
                                style: TextStyle(color: Colors.black),
                              ),
                              value: vals,
                            );
                          }).toList(),
                          onChanged: (vals) {
                            comp = vals;
                          },
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
                            // if (_comadd.currentState!.validate()) {
                            setState(() {
                              for (int i = 0; i < comobjtype.length; i++) {
                                if (objtype == comobjtype[i].objectTypeName) {
                                  objtype =
                                      comobjtype[i].objectTypeCode.toString();
                                }
                              }
                              for (int i = 0; i < cmbcomp.length; i++) {
                                if (comp == cmbcomp[i].companyName) {
                                  comp = cmbcomp[i].companyId.toString();
                                }
                              }
                              reqsoadd.objectType = objtype;
                              reqsoadd.companyId = comp;
                              reqsoadd.objectCode = objcd;
                              reqsoadd.description = objdesc;
                              reqsoadd.objectName = objname;
                              bloc.add(EditSOData(reqsoadd));
                            });
                            Navigator.pop(context);
                            // }
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

  void DeleteAction() {
    var check = [];
    delreq.listCode = [];

    for (int i = 0; i < so.length; i++) {
      if (so[i].isChecked == true) {
        check.add(so[i].objectCode.toString());
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
      for (var element in so) {
        if (element.isChecked == true) {
          delreq.listCode!.add(DelListCode(code: element.objectCode));
        }
      }
      bloc.add(DeleteSOData(delreq));
    }
  }
}
