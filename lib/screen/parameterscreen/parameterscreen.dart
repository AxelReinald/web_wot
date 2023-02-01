import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/parameterbloc/bloc/parameter_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/parametermodel.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:web_wot/screen/parameterscreen/addparameter.dart';

class ParameterScreen extends StatefulWidget {
  const ParameterScreen(
      {Key? key, required String groupCd, required String groupName})
      : super(key: key);

  @override
  State<ParameterScreen> createState() => _ParameterScreenState();
}

class _ParameterScreenState extends State<ParameterScreen>
    with SingleTickerProviderStateMixin {
  bool _large = true;
  RequestParameterSearch req = new RequestParameterSearch();
  TextEditingController _ParameterCd = TextEditingController();
  TextEditingController _Parametername = TextEditingController();
  TextEditingController _ParameterDtl = TextEditingController();
  late ParameterBloc bloc;
  int? hal;
  int? total;
  bool isChecked = false;

  @override
  void initState() {
    bloc = BlocProvider.of<ParameterBloc>(context);
    req.pageSize = 10;
    req.pageNumber = 1;
    req.paramGroupCode = '';
    req.paramGroupName = '';
    req.param = '';

    param.clear();
    bloc.add(SearchParam(req));
    super.initState();
  }

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  DownloadRequestParam downreqs = DownloadRequestParam();
  RequestParameterDelete delpar = RequestParameterDelete();
  List<ParamData> param = [];
  ParamData params = ParamData();
  DownParamData doc = DownParamData();

  double _size = 250.0;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ParameterBloc>(context);
    return BlocListener<ParameterBloc, ParameterState>(
      listener: (context, state) {
        if (state is ParamError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  duration: const Duration(seconds: 3),
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
            param.clear();
            param = state.resp.data!;
            hal = param.length;
            total = state.resp.countData;
          });
        }
        if (state is DownloadSuccess) {
          setState(() {
            doc = state.resp.data!;
            writeFileWeb(doc.base64Data.toString(), doc.fileName.toString());
          });
        }
        if (state is DeleteSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text(
                    'Delete Success',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
          bloc.add(SearchParam(req));
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
                          'Parameter',
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
                            'Home / Master / Parameter',
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
                      children: [
                        Container(
                          //search box
                          height: 124,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: Row(
                                children: [
                                  Textbox(
                                      text: 'Parameter Code',
                                      controller: _ParameterCd,
                                      length: 12,
                                      onChanged: (val) {
                                        req.paramGroupCode = val;
                                      }),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Textbox(
                                      text: 'Parameter Name',
                                      controller: _Parametername,
                                      length: 15,
                                      onChanged: (val) {
                                        req.paramGroupName = val;
                                      }),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Textbox(
                                    text: 'Parameter Detail',
                                    controller: _ParameterDtl,
                                    length: 15,
                                    onChanged: (val) {
                                      req.param = val;
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
                                        bloc.add(SearchParam(req));
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
                                        _ParameterCd.clear();
                                        _Parametername.clear();
                                        _ParameterDtl.clear();
                                        req.paramGroupCode = '';
                                        req.paramGroupName = '';
                                        req.param = '';
                                        param.clear();
                                        bloc.add(SearchParam(req));
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
                          //isi table
                          height: MediaQuery.of(context).size.height * 0.6,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 120,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed('/parameter/add');
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
                                              EditParameter();
                                              // var cekbox = [];
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
                                              DeleteParameter();
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
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Card(
                                          child: Container(
                                            color: Colors.blue,
                                            height: 40,
                                            width: 120,
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                cardColor: Colors.grey.shade600,
                                              ),
                                              child: PopupMenuButton(
                                                offset: const Offset(-3, 40),
                                                tooltip: '',
                                                child: const Center(
                                                  child: Text(
                                                    'Download',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          downreqs.paramGroupCd =
                                                              _ParameterCd.text;
                                                          downreqs.paramGroupName =
                                                              _Parametername
                                                                  .text;
                                                          downreqs.paramName =
                                                              _ParameterDtl
                                                                  .text;
                                                          downreqs.extention =
                                                              'csv';
                                                          bloc.add(
                                                              DownloadParam(
                                                                  downreqs));
                                                        },
                                                      );
                                                    },
                                                    value: () {},
                                                    child: Text('CSV',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          downreqs.paramGroupCd =
                                                              _ParameterCd.text;
                                                          downreqs.paramGroupName =
                                                              _Parametername
                                                                  .text;
                                                          downreqs.paramName =
                                                              _ParameterDtl
                                                                  .text;
                                                          downreqs.extention =
                                                              'xls';
                                                          // // print('masuk xls');
                                                          bloc.add(
                                                              DownloadParam(
                                                                  downreqs));
                                                        },
                                                      );
                                                    },
                                                    value:
                                                        () {}, //_exportToExcel,
                                                    child: Text('XLS',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          downreqs.paramGroupCd =
                                                              _ParameterCd.text;
                                                          downreqs.paramGroupName =
                                                              _Parametername
                                                                  .text;
                                                          downreqs.paramName =
                                                              _ParameterDtl
                                                                  .text;
                                                          downreqs.extention =
                                                              'xlsx';
                                                          // // print('masuk xlsx');
                                                          bloc.add(
                                                              DownloadParam(
                                                                  downreqs));
                                                        },
                                                      );
                                                    },
                                                    value: () {},
                                                    child: Text('XLSX',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
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
                                                      checkColor: Colors.black,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith(
                                                                  getColor),
                                                      value: isChecked,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          var i = 0;
                                                          if (param[i]
                                                                  .isChecked ==
                                                              false) {
                                                            isChecked = true;
                                                            for (i = 0;
                                                                i <
                                                                    param
                                                                        .length;
                                                                i++)
                                                              param[i].isChecked =
                                                                  true;
                                                          } else if (param[i]
                                                                  .isChecked ==
                                                              true) {
                                                            isChecked = false;
                                                            for (i = 0;
                                                                i <
                                                                    param
                                                                        .length;
                                                                i++)
                                                              param[i].isChecked =
                                                                  false;
                                                          }
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Text(
                                                        'Parameter Code',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Text(
                                                        'Parameter Name',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                            0.25,
                                                    height: 50,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Text(
                                                        'Parameter Detail',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Text(
                                                        'Created By',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Text(
                                                        'Created Date',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                            0.08,
                                                    height: 50,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Text(
                                                        'Change By',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Text(
                                                        'Change Date',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                            if (param.length > 0 ||
                                                param.isNotEmpty)
                                              BlocBuilder<ParameterBloc,
                                                      ParameterState>(
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
                                                    itemCount: param.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Column(
                                                      children: [
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
                                                                value: param[
                                                                        index]
                                                                    .isChecked,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    param[index]
                                                                            .isChecked =
                                                                        value!;
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
                                                                  param[index]
                                                                      .paramGroupCode
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
                                                                  param[index]
                                                                      .paramGroupName
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
                                                                  0.25,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  param[index]
                                                                      .paramName
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
                                                                  param[index]
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
                                                                  param[index]
                                                                      .createdTime
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
                                                                  0.08,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  param[index]
                                                                      .updatedBy
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
                                                                  0.08,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  param[index]
                                                                      .updatedTime
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
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
                                    )
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
                              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                              child: BlocBuilder<ParameterBloc, ParameterState>(
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        ('1 - ' + hal.toString() + ' of'),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16),
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
                                          // setState(() {
                                          //   reqset.pageSize = 10;
                                          //   reqset.pageNumber = 0;
                                          //   page = 1;
                                          //   bloc.add(Search(reqset));
                                          // });
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
                                          // setState(() {
                                          //   page--;
                                          //   reqset.pageSize = 10;
                                          //   reqset.pageNumber = page - 1;

                                          //   bloc.add(Search(reqset));
                                          // });
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
                                            //page.toString(),
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
                                            // setState(() {
                                            //   reqset.pageSize = 10;
                                            //   reqset.pageNumber = page;
                                            //   page++;
                                            //   bloc.add(Search(reqset));
                                            // });
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
                                            // setState(() {
                                            //   reqset.pageSize = 10;
                                            //   reqset.pageNumber = 3;
                                            //   page = 4;
                                            //   bloc.add(Search(reqset));
                                            // });
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
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void EditParameter() {
    String groupcode;
    String groupname;
    List<ListParameter> listpar = [];
    params.listParameter = [];
    var cekbox = [];
    for (int x = 0; x < param.length; x++) {
      if (param[x].isChecked == true) {
        for (int y = 0; y < param[x].listParameter!.length; y++) {
          ListParameter model = ListParameter();
          model.paramCode = param[x].listParameter![y].paramCode.toString();
          model.paramDesc = param[x].listParameter![y].paramDesc.toString();
          model.paramName = param[x].listParameter![y].paramName.toString();
          listpar.add(model);
        }
        groupcode = param[x].paramGroupCode.toString();
        groupname = param[x].paramGroupName.toString();
        print(
          param[x].paramGroupCode.toString(),
        );
        // print(listpar);
        // print(listpar[0].paramName.toString() +
        //     " " +
        //     listpar[1].paramName.toString() +
        //     " " +
        //     listpar[2].paramName.toString());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ParameterBloc(),
              child: AddParameter(
                  groupcode: groupcode, groupname: groupname, listpar: listpar),
            ),
          ),
        );
        // Navigator.pop(
        //   context,
        //   param[x].paramGroupCode.toString(),
        // );
        // Navigator.of(context).pushNamed('/parameter/edit',
        //     arguments: AddParameter(
        //       groupcode: groupcode,
        //       groupname: param[x].paramGroupName.toString(),
        //     ));
        // Navigator.of(context).pushNamed('/parameter/edit', arguments: groupcode,listpar, );
        // cekbox.add(param[x].paramGroupCode.toString() +
        //     ";" +
        //     param[x].paramGroupName.toString() +
        //     ";" +
        //    listpar

        //     );

      }
    }
    if (listpar.length > 0) {
      print('masuk sini 1');
      // var split = cekbox[0].toString().split(";");
      // String groupcode = split[0];
      // String groupname = split[1];
      // print(paramDesc);
      // print(paramName);
      // print(groupcode);
      // print(groupname);
      //  Navigator.of(context).pushNamed('/parameter/add', arguments: groupname);
      // EditParamDialog(groupcode, groupname);
    } else {
      print('message');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 3),
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

  void DeleteParameter() {
    var check = [];
    List<DelParamListCode> ceklist = [];
    DelParamListCode models = DelParamListCode();
    delpar.listCode = [];

    for (int i = 0; i < param.length; i++) {
      if (param[i].isChecked == true) {
        check.add(param[i].paramGroupCode.toString());
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
      for (var element in param) {
        if (element.isChecked == true) {
          delpar.listCode!.add(DelParamListCode(code: element.paramGroupCode));
          print(element);
        }
      }
      // print(delset);
      bloc.add(DeleteParam(delpar));
    }
  }
}
