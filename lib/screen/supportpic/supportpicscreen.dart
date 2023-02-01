import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/bloc/supportpicbloc/bloc/support_pic_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/supportpicmodel.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:web_wot/screen/supportpic/addpic.dart';
import 'package:web_wot/Theme/colors.dart';

class Supportpic extends StatefulWidget {
  const Supportpic({Key? key}) : super(key: key);

  @override
  State<Supportpic> createState() => _SupportpicState();
}

class _SupportpicState extends State<Supportpic>
    with SingleTickerProviderStateMixin {
  RequestSuppicSearch req = new RequestSuppicSearch();
  DownloadRequestPic downpic = DownloadRequestPic();
  late SupportPicBloc bloc;
  int? id;
  DownloadPicData downdoc = new DownloadPicData();
  double _size = 250.0;
  bool isChecked = false;
  bool _large = true;
  int? hal;
  int? total;
  GetRespPICData resppic = GetRespPICData();
  List<String> details = [];
  List<PICData> pic = [];
  TextEditingController _PICCom = TextEditingController();
  TextEditingController _PICName = TextEditingController();
  TextEditingController _PICEmail = TextEditingController();
  CountData count = CountData();
  int? nextpage = 1;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<SupportPicBloc>(context);
    req.pageSize = 10;
    req.pageNumber = 1;
    req.company = '';
    req.picEmail = '';
    req.picName = '';
    pic.clear();
    bloc.add(SearchPIC(req));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SupportPicBloc>(context);
    return BlocListener<SupportPicBloc, SupportPicState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SupportpicLoad) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorPIC) {
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
        if (state is SearchpicSuccess) {
          setState(() {
            pic.clear();
            pic = state.resp.data!;
            count = state.resp.countData!;
            hal = pic.length;
            total = state.resp.data!.length;
          });
        }
        if (state is DownloadPicSuccess) {
          setState(() {
            downdoc = state.resp.data!;
            writeFileWeb(
                downdoc.base64Data.toString(), downdoc.fileName.toString());
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
                          'Support PIC',
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
                            'Home / Master / Support PIC',
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
                            //Search Box
                            height: 124,
                            color: const Color(0xFFE7E7E7),
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
                                child: Row(
                                  children: [
                                    Textbox(
                                      text: 'Company',
                                      controller: _PICCom,
                                      length: 20,
                                      onChanged: (val) {
                                        req.company = val;
                                      },
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Textbox(
                                      text: 'PIC Name',
                                      controller: _PICName,
                                      length: 20,
                                      onChanged: (val) {
                                        req.picName = val;
                                      },
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Textbox(
                                      text: 'PIC Email',
                                      controller: _PICEmail,
                                      length: 20,
                                      onChanged: (val) {
                                        req.picEmail = val;
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
                                          bloc.add(SearchPIC(req));
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
                                          _PICCom.clear();
                                          _PICEmail.clear();
                                          _PICName.clear();
                                          req.company = '';
                                          req.picName = '';
                                          req.picEmail = '';
                                          bloc.add(SearchPIC(req));
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
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
                                                resppic.companyId = id;
                                                print(id.toString() +
                                                    "  di screen pic bloc get pic");
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                      create: (context) =>
                                                          SupportPicBloc(),
                                                      child: Addpic(
                                                        ids: id,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }, //=> AddDialog.showMyDialog(context),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Assign',
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
                                                data:
                                                    Theme.of(context).copyWith(
                                                  cardColor:
                                                      Colors.grey.shade600,
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
                                                      (BuildContext context) =>
                                                          [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            downpic.company =
                                                                _PICCom.text;
                                                            downpic.picEmail =
                                                                _PICEmail.text;
                                                            downpic.picName =
                                                                _PICName.text;
                                                            downpic.extension =
                                                                'csv';
                                                            bloc.add(
                                                                DownloadPic(
                                                                    downpic));
                                                          },
                                                        );
                                                      },
                                                      value: () {},
                                                      child: Text('CSV',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            downpic.company =
                                                                _PICCom.text;
                                                            downpic.picEmail =
                                                                _PICEmail.text;
                                                            downpic.picName =
                                                                _PICName.text;
                                                            downpic.extension =
                                                                'xls';
                                                            // // // print('masuk xls');
                                                            bloc.add(
                                                                DownloadPic(
                                                                    downpic));
                                                          },
                                                        );
                                                      },
                                                      value:
                                                          () {}, //_exportToExcel,
                                                      child: Text('XLS',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            downpic.company =
                                                                _PICCom.text;
                                                            downpic.picEmail =
                                                                _PICEmail.text;
                                                            downpic.picName =
                                                                _PICName.text;
                                                            downpic.extension =
                                                                'xlsx';
                                                            // // // print('masuk xlsx');
                                                            bloc.add(
                                                                DownloadPic(
                                                                    downpic));
                                                          },
                                                        );
                                                      },
                                                      value: () {},
                                                      child: Text('XLSX',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
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
                                                            if (pic[i]
                                                                    .isChecked ==
                                                                false) {
                                                              isChecked = true;
                                                              for (i = 0;
                                                                  i <
                                                                      pic
                                                                          .length;
                                                                  i++)
                                                                pic[i].isChecked =
                                                                    true;
                                                            } else if (pic[i]
                                                                    .isChecked ==
                                                                true) {
                                                              isChecked = false;
                                                              for (i = 0;
                                                                  i <
                                                                      pic
                                                                          .length;
                                                                  i++)
                                                                pic[i].isChecked =
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          'Company Code',
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
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          'Company Name',
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
                                                              0.30,
                                                      height: 50,
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          'PIC (Name, Phone No, Email)',
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
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
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
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
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
                                                              0.08,
                                                      height: 50,
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          'Change By',
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
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          'Change Date',
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
                                              if (pic.length > 0 ||
                                                  pic.isNotEmpty)
                                                BlocBuilder<SupportPicBloc,
                                                        SupportPicState>(
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
                                                      itemCount: pic.length,
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
                                                                  value: pic[
                                                                          index]
                                                                      .isChecked,
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      pic[index]
                                                                              .isChecked =
                                                                          value!;
                                                                      id = pic[
                                                                              index]
                                                                          .companyId;
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
                                                                height: 65,
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
                                                                    pic[index]
                                                                        .companyCode
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
                                                                height: 65,
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
                                                                    pic[index]
                                                                        .companyName
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
                                                                height: 65,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.30,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          15),
                                                                  child: Text(
                                                                    pic[index]
                                                                        .pic
                                                                        .toString()
                                                                        .replaceAll(
                                                                            '[',
                                                                            '')
                                                                        .replaceAll(
                                                                            ']',
                                                                            ''),
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
                                                                height: 65,
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
                                                                    pic[index]
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
                                                                height: 65,
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
                                                                    pic[index]
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
                                                                height: 65,
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
                                                                    pic[index]
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
                                                                height: 65,
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
                                                                    pic[index]
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 5, 16, 5),
                                child: BlocBuilder<SupportPicBloc,
                                    SupportPicState>(
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
                                          (count.totalData.toString() +
                                              ' data'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              req.pageSize = 10;
                                              req.pageNumber = 1;
                                              bloc.add(SearchPIC(req));
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
                                              req.pageNumber =
                                                  count.pageNumber! - 1;
                                              bloc.add(SearchPIC(req));
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
                                              border: Border.all(
                                                  color: Colors.blue)),
                                          child: Center(
                                            child: Text(
                                              count.pageNumber.toString(),
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
                                                req.pageNumber =
                                                    count.pageNumber! + 1;
                                                bloc.add(SearchPIC(req));
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
}
