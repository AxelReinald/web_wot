import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/provincebloc/bloc/province_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/provincemodel.dart';
import 'package:web_wot/screen/menu.dart';

class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({Key? key}) : super(key: key);

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen>
    with SingleTickerProviderStateMixin {
  int? total;
  int? hal;
  int page = 1;
  double _size = 250.0;
  bool _large = true;
  late ProvinceBloc bloc;
  bool isChecked = false;
  List<ProData> pro = [];
  ProvinceRequestSearch reqpro = new ProvinceRequestSearch();
  ProvinceRequestAdd addpros = new ProvinceRequestAdd();
  ProvinceRequestEdit editpro = new ProvinceRequestEdit();
  ProvinceRequestDelete delpro = new ProvinceRequestDelete();
  DownloadRequestPro downreq = new DownloadRequestPro();
  ProDownData download = ProDownData();
  TemplateData temp = TemplateData();

  List<ProData> listpro = [ProData(isChecked: false)];

  final _proKey = GlobalKey<FormState>();

  final ScrollController _tableproscroll = ScrollController();

  TextEditingController _ProvinceCd = TextEditingController();
  TextEditingController _ProvinceName = TextEditingController();
  TextEditingController _ProvinceCode = TextEditingController();
  TextEditingController _ProvinceNames = TextEditingController();

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  void initState() {
    bloc = BlocProvider.of<ProvinceBloc>(context);
    reqpro.pageSize = 10;
    reqpro.pageNumber = 1;
    reqpro.provinceCd = '';
    reqpro.provinceName = '';

    pro.clear();
    bloc.add(SearchPro(reqpro));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProvinceBloc>(context);
    return BlocListener<ProvinceBloc, ProvinceState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ProvinceLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchSuccess) {
          setState(() {
            pro.clear();
            pro = state.resp.data!;
            total = state.resp.countData;
            hal = pro.length;
          });
        }
        if (state is DownloadProSuccess) {
          setState(() {
            download = state.resp.data!;
            writeFileWeb(
                download.base64Data.toString(), download.fileName.toString());
          });
        }
        if (state is AddProSuccess) {
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
          bloc.add(SearchPro(reqpro));
        }
        if (state is EditProSuccess) {
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
          bloc.add(SearchPro(reqpro));
        }
        if (state is DeleteProSuccess) {
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
          bloc.add(SearchPro(reqpro));
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
                          'Province',
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
                            'Home / Master / Province',
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
                                    text: 'Province Code',
                                    controller: _ProvinceCd,
                                    length: 15,
                                    onChanged: (val) {
                                      reqpro.provinceCd = val;
                                    },
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Textbox(
                                    text: 'Province Name',
                                    controller: _ProvinceName,
                                    length: 15,
                                    onChanged: (val) {
                                      reqpro.provinceName = val;
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
                                        bloc.add(SearchPro(reqpro));
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
                                        _ProvinceCd.clear();
                                        reqpro.provinceCd = '';
                                        _ProvinceName.clear();
                                        reqpro.provinceName = '';
                                        pro.clear();
                                        bloc.add(SearchPro(reqpro));
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
                              child: SingleChildScrollView(
                                // controller: tableScroll,
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
                                              AddProDialog();
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
                                              EditProSetting();
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
                                              DeletePros();
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
                                                  '/province/import');
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
                                                          downreq.provinceCd =
                                                              _ProvinceCd.text;
                                                          downreq.provinceName =
                                                              _ProvinceName
                                                                  .text;
                                                          downreq.extention =
                                                              'csv';
                                                          bloc.add(DownloadPro(
                                                              downreq));
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
                                                          downreq.provinceCd =
                                                              _ProvinceCd.text;
                                                          downreq.provinceName =
                                                              _ProvinceName
                                                                  .text;
                                                          downreq.extention =
                                                              'xls';
                                                          bloc.add(DownloadPro(
                                                              downreq));
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
                                                          downreq.provinceCd =
                                                              _ProvinceCd.text;
                                                          downreq.provinceName =
                                                              _ProvinceName
                                                                  .text;
                                                          downreq.extention =
                                                              'xlsx';
                                                          bloc.add(DownloadPro(
                                                              downreq));
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
                                        controller: _tableproscroll,
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
                                                          if (pro[i]
                                                                  .isChecked ==
                                                              false) {
                                                            isChecked = true;
                                                            for (i = 0;
                                                                i < pro.length;
                                                                i++)
                                                              pro[i].isChecked =
                                                                  true;
                                                          } else if (pro[i]
                                                                  .isChecked ==
                                                              true) {
                                                            isChecked = false;
                                                            for (i = 0;
                                                                i < pro.length;
                                                                i++)
                                                              pro[i].isChecked =
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
                                                        'Province Code',
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
                                                        'Province Name',
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
                                                            0.10,
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
                                            if (pro.length > 0 ||
                                                pro.isNotEmpty)
                                              BlocBuilder<ProvinceBloc,
                                                  ProvinceState>(
                                                builder: (context, state) {
                                                  return Container(
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
                                                      // controller: contentScroll,
                                                      itemCount: pro.length,
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
                                                                value: pro[
                                                                        index]
                                                                    .isChecked,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    pro[index]
                                                                            .isChecked =
                                                                        value!;
                                                                  });
                                                                },
                                                                side: const BorderSide(
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
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  pro[index]
                                                                      .provinceCd
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
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  pro[index]
                                                                      .provinceName
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
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  pro[index]
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
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  pro[index]
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
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  pro[index]
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
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  pro[index]
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
                              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                              child: BlocBuilder<ProvinceBloc, ProvinceState>(
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
                                          setState(() {
                                            reqpro.pageSize = 10;
                                            reqpro.pageNumber = 0;
                                            page = 1;
                                            bloc.add(SearchPro(reqpro));
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
                                            reqpro.pageSize = 10;
                                            reqpro.pageNumber = page - 1;

                                            bloc.add(SearchPro(reqpro));
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
                                            page.toString(),
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
                                              reqpro.pageSize = 10;
                                              reqpro.pageNumber = page;
                                              page++;
                                              bloc.add(SearchPro(reqpro));
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
                                              reqpro.pageSize = 10;
                                              reqpro.pageNumber = 3;
                                              page = 4;
                                              bloc.add(SearchPro(reqpro));
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
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future AddProDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Province - Add',
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
            child: Form(
              key: _proKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Province Code',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _ProvinceCode,
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
                    'Province Name',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _ProvinceNames,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap diisi, Tidak boleh kosong';
                      }
                      return null;
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
                          if (_proKey.currentState!.validate()) {
                            setState(() {
                              addpros.provinceCd = _ProvinceCode.text;
                              addpros.provinceName = _ProvinceNames.text;
                              bloc.add(AddPro(addpros));
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
      );

  void EditProSetting() {
    var holder_1 = [];
    var splited;
    for (int i = 0; i < pro.length; i++) {
      if (pro[i].isChecked == true) {
        holder_1.add(pro[i].provinceCd.toString() +
            ";" +
            pro[i].provinceName.toString());
      }
    }
    if (holder_1.length == 1) {
      splited = holder_1[0].toString().split(';');
      String ProCode = splited[0];
      String ProName = splited[1];
      EditProDialog(ProCode, ProName);
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

  Future EditProDialog(String ProCd, String ProNames) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Province - Edit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
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
              const Divider(
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
                  'Province Code',
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
                      initialValue: ProCd,
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
                  'Province Name',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  //controller: _EditGroupName,
                  initialValue: ProNames,
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
                    editpro.provinceName = value;
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
                        editpro.provinceCd = ProCd;
                        bloc.add(EditPro(editpro));
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

  void DeletePros() {
    var check = [];
    delpro.listCode = [];

    for (int i = 0; i < pro.length; i++) {
      if (pro[i].isChecked == true) {
        check.add(pro[i].provinceCd.toString());
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
      for (var element in pro) {
        if (element.isChecked == true) {
          delpro.listCode!.add(ListCode(code: element.provinceCd));
        }
      }
      bloc.add(DeletePro(delpro));
    }
  }
}
