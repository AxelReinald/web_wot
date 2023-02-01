import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/supportpicbloc/bloc/support_pic_bloc.dart';
import 'package:web_wot/common/dropdownauto.dart';
import 'package:web_wot/common/dropdownautoemail.dart';
import 'package:web_wot/common/dropdownautophone.dart';
import 'package:web_wot/model/supportpicmodel.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:web_wot/screen/supportpic/pic_form.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:web_wot/service/restapi.dart';

class Addpic extends StatefulWidget {
  final int? ids;
  // List<AutoData> listpic = [AutoData(isChecked: false)];
  Addpic(
      {required this.ids,
      //  required this.listpic,
      Key? key})
      : super(key: key);

  @override
  State<Addpic> createState() => _AddpicState();
}

class _AddpicState extends State<Addpic> with SingleTickerProviderStateMixin {
  SuggestionsBoxController controllertypename = new SuggestionsBoxController();
  double _size = 250.0;
  bool _large = true;
  TextEditingController _CompanyCode = TextEditingController();
  TextEditingController _CompanyName = TextEditingController();
  TextEditingController _textEditController = TextEditingController();
  SuggestionsBoxController controller = new SuggestionsBoxController();
  RestApi api = new RestApi();
  bool expanded = false;
  bool checkAll = false;
  bool? onChecked = false;
  late SupportPicBloc bloc;
  Pic model = Pic();
  List<Pic> pics = [];
  List<String> namefill = [];
  List<TextEditingController> _textField = [];
  List<AutoData>? fill = [];
  List<String> comname = [];
  List<String> comphone = [];
  List<String> comemail = [];
  AutoData auto = new AutoData();
  ResponseGetAuto autos = ResponseGetAuto();
  TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  bool? temperatureField = false;
  List<FocusNode> focusList = [FocusNode(), FocusNode(), FocusNode()];
  RequestAddPic addpic = RequestAddPic();
  List<AddNewPic>? pic = [];
  final bool? enableds = false;
  late final Function(AutoData) onsubmit;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  get temperatureItemTypes => null;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  void initState() {
    bloc = BlocProvider.of<SupportPicBloc>(context);
    // TODO: implement initState
    bloc.add(GetAuto());
    bloc.add(GetPic(widget.ids));

    super.initState();
  }

  final _picadd = GlobalKey<FormState>();
  GetRespPICData respget = new GetRespPICData();
  List<AddPIC> listDtl = [
    AddPIC(isChecked: false),
  ];

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SupportPicBloc>(context);
    checkAll = listDtl.every((element) => element.isChecked == true) &&
        listDtl.isNotEmpty;
    return BlocListener<SupportPicBloc, SupportPicState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetPicSuccess) {
          setState(() {
            respget = state.resp.data!;
            _CompanyCode.text = respget.companyCode.toString();
            _CompanyName.text = respget.companyName.toString();
            // _textEditController.text = respget.companyName.toString();
            pics.addAll(state.resp.data!.pic!.toList());
          });
        }
        if (state is GetAutoSuccess) {
          setState(() {
            // fill.clear();
            // fill.addAll(state.resp.data!.toList());

            fill = state.resp.data;
            // fieldTextEditingController.text = state.resp.data;
            for (int i = 0; i < state.resp.data!.length; i++) {
              comname.add(state.resp.data![i].fullName.toString());
            }
            for (int i = 0; i < state.resp.data!.length; i++) {
              comphone.add(state.resp.data![i].mobileNo.toString());
            }
            for (int i = 0; i < state.resp.data!.length; i++) {
              comemail.add(state.resp.data![i].email.toString());
            }
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
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
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
                          'Assign',
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
                            'Home / Master / Support PIC / Assign',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.grey.shade300,
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.white,
                              // height: MediaQuery.of(context).size.height*,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Form(
                                  key: _picadd,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Company',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Company Code',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 350,
                                                height: 40,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    // initialValue:
                                                    //     respget.companyCode,
                                                    //     widget.groupcode,
                                                    //     widget.groupcode,
                                                    controller: _CompanyCode,
                                                    //maxLength: 20,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 8,
                                                              left: 8),
                                                      fillColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide: BorderSide(
                                                            width: 1.0,
                                                            color: Colors
                                                                .grey.shade400),
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Harap diisi, Tidak boleh kosong';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Company Name',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 350,
                                                height: 40,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextFormField(
                                                    // initialValue:
                                                    //     widget.groupname,
                                                    controller: _CompanyName,
                                                    readOnly: true,
                                                    //maxLength: 20,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 8,
                                                              left: 8),
                                                      fillColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide: BorderSide(
                                                            width: 1.0,
                                                            color: Colors
                                                                .grey.shade400),
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Harap diisi, Tidak boleh kosong';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'PIC',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 120, height: 40),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    listDtl.add(AddPIC(
                                                        isChecked: false));
                                                    pics.add(
                                                        Pic(isChecked: false));
                                                  });
                                                },
                                                child: Text('Add')),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 120, height: 40),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // setState(() {
                                                //   .removeWhere(
                                                //       (element) =>
                                                //           element.isChecked ==
                                                //           true);
                                                //   checkAll = false;
                                                // });
                                                setState(() {
                                                  listDtl.removeWhere(
                                                      (element) =>
                                                          element.isChecked ==
                                                          true);
                                                  checkAll = false;
                                                });
                                                setState(() {
                                                  pics.removeWhere((element) =>
                                                      element.isChecked ==
                                                      true);
                                                  checkAll = false;
                                                });
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              style: ButtonStyle(
                                                overlayColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                  (states) {
                                                    return states.contains(
                                                            MaterialState
                                                                .pressed)
                                                        ? Colors.grey
                                                        : null;
                                                  },
                                                ),
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.grey),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                    side: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        color: Color(0xFFFAF5FF),
                                        padding: const EdgeInsets.only(
                                          // top: 12,
                                          // bottom: 12,
                                          // right: 12,
                                          left: 20,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //!
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 4),
                                              child: SizedBox(
                                                height: 20,
                                                width: 50,
                                                child: Checkbox(
                                                  value: checkAll,
                                                  side: const BorderSide(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                  splashRadius: 1,
                                                  onChanged: (val) {
                                                    // if (widget.listpic.length !=
                                                    //     0) {
                                                    setState(() {
                                                      checkAll = false;
                                                      if (pics.isNotEmpty) {
                                                        for (var item in pics) {
                                                          item.isChecked = val;
                                                        }
                                                      }
                                                    });
                                                    //} else {
                                                    setState(() {
                                                      checkAll = false;
                                                      if (listDtl.isNotEmpty) {
                                                        for (var item
                                                            in listDtl) {
                                                          item.isChecked = val;
                                                        }
                                                      }
                                                    });
                                                    //  }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 4),
                                                child: Text(
                                                  "Name",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 4),
                                                child: Text(
                                                  "Phone No.",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 4),
                                                child: Text(
                                                  "Email",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // if (pics.length == 0)
                                      //   ListView.builder(
                                      //     itemCount: listDtl.isNotEmpty
                                      //         ? listDtl.length
                                      //         : 1,
                                      //     shrinkWrap: true,
                                      //     physics:
                                      //         const NeverScrollableScrollPhysics(),
                                      //     itemBuilder: (ctx, i) {
                                      //       if (listDtl.isNotEmpty) {
                                      //         return PICFormItem(
                                      //           model: listDtl[i],
                                      //           isLast: i == listDtl.length - 1,
                                      //           onCheckedChanged: (val) {
                                      //             setState(() {
                                      //               listDtl[i].isChecked = val;
                                      //             });
                                      //           },
                                      //           onNameChanged: (val) {
                                      //             listDtl[i].name = val;
                                      //             // a = listDtl[i].detailCd;
                                      //           },
                                      //           onPhoneChanged: (val) {
                                      //             listDtl[i].mobileNo = val;
                                      //             //  b = listDtl[i].detailName;
                                      //           },
                                      //           onEmailChanged: (val) {
                                      //             listDtl[i].email = val;
                                      //             // c = listDtl[i].detailDesc;
                                      //           },
                                      //         );
                                      //       } else {
                                      //         return const SizedBox();
                                      //       }
                                      //     },
                                      //   )
                                      // else
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: pics.length,
                                        itemBuilder: (context, index) {
                                          return Form(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(
                                                left: 22,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12,
                                                        horizontal: 4),
                                                    child: SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: Checkbox(
                                                        tristate: false,
                                                        side: const BorderSide(
                                                          color: Colors.blue,
                                                          width: 2,
                                                        ),
                                                        value: pics[index]
                                                                .isChecked ??
                                                            false,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            pics[index]
                                                                    .isChecked =
                                                                val;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    height: 45,
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0) //                 <--- border radius here
                                                              ),
                                                      border: Border.all(
                                                          width: 1.5,
                                                          color: Colors.grey),
                                                    ),
                                                    child: TypeAheadFormField(
                                                      textFieldConfiguration:
                                                          TextFieldConfiguration(
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        onTap: () {
                                                          setState(() {
                                                            (!expanded)
                                                                ? expanded =
                                                                    true
                                                                : expanded =
                                                                    false;
                                                            (expanded)
                                                                ? controller
                                                                    .open()
                                                                : controller
                                                                    .close();
                                                          });
                                                        },
                                                        controller:
                                                            TextEditingController(
                                                                text:
                                                                    pics[index]
                                                                        .name),
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon: (!expanded)
                                                              ? Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  color: Colors
                                                                      .black)
                                                              : Icon(
                                                                  Icons
                                                                      .arrow_drop_up,
                                                                  color: Colors
                                                                      .black),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          enabled:
                                                              enableds ?? true,
                                                          hintText: 'Name',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                          labelStyle: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                          filled: true,
                                                          fillColor: (enableds ==
                                                                  null)
                                                              ? Colors.white
                                                              : true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black38)),
                                                          disabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  width: 0.0)),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          0.5)),
                                                          errorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          0.5)),
                                                          focusedErrorBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red,
                                                                      width:
                                                                          0.5)),
                                                        ),
                                                      ),
                                                      suggestionsCallback:
                                                          (pattern) async {
                                                        return await getSuggestions(
                                                            pattern);
                                                      },
                                                      debounceDuration:
                                                          Duration(seconds: 0),
                                                      itemBuilder: (context,
                                                          suggestion) {
                                                        AutoData data =
                                                            suggestion
                                                                as AutoData;
                                                        return ListTile(
                                                          title: Text(
                                                            data.fullName!,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        );
                                                      },
                                                      suggestionsBoxVerticalOffset:
                                                          0,
                                                      transitionBuilder: (context,
                                                              suggestionsBox,
                                                              animationController) =>
                                                          FadeTransition(
                                                        child: suggestionsBox,
                                                        opacity: CurvedAnimation(
                                                            parent:
                                                                animationController
                                                                    as Animation<
                                                                        double>,
                                                            curve: Curves
                                                                .fastOutSlowIn),
                                                      ),
                                                      suggestionsBoxDecoration:
                                                          SuggestionsBoxDecoration(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: 300),
                                                      ),
                                                      onSuggestionSelected:
                                                          (suggestion) {
                                                        setState(() {
                                                          AutoData data =
                                                              suggestion
                                                                  as AutoData;
                                                          pics[index].name =
                                                              data.fullName!;
                                                          // pic![index].name =
                                                          //     data.fullName!;
                                                          // addpic.pic![index]
                                                          //         .name =
                                                          //     pic![index].name;
                                                          expanded = false;
                                                          onsubmit(data);
                                                          //     data);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                      height: 45,
                                                      width: 350,
                                                      // padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0) //                 <--- border radius here
                                                                ),
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                      ),
                                                      child: TypeAheadFormField(
                                                        textFieldConfiguration:
                                                            TextFieldConfiguration(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          onTap: () {
                                                            setState(() {
                                                              (!expanded)
                                                                  ? expanded =
                                                                      true
                                                                  : expanded =
                                                                      false;
                                                              (expanded)
                                                                  ? controller
                                                                      .open()
                                                                  : controller
                                                                      .close();
                                                            });
                                                          },
                                                          controller:
                                                              TextEditingController(
                                                                  text: pics[
                                                                          index]
                                                                      .mobileNo),
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon: (!expanded)
                                                                ? Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .black)
                                                                : Icon(
                                                                    Icons
                                                                        .arrow_drop_up,
                                                                    color: Colors
                                                                        .black),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            enabled: enableds ??
                                                                true,
                                                            hintText:
                                                                'Mobile Phone',
                                                            hintStyle: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                            labelStyle:
                                                                TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            filled: true,
                                                            fillColor: (enableds ==
                                                                    null)
                                                                ? Colors.white
                                                                : true
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black38)),
                                                            disabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    width:
                                                                        0.0)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        0.5)),
                                                            errorBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        0.5)),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        0.5)),
                                                          ),
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) async {
                                                          return await getSuggestionsphone(
                                                              pattern);
                                                        },
                                                        itemBuilder: (context,
                                                            suggestion) {
                                                          AutoData data =
                                                              suggestion
                                                                  as AutoData;
                                                          return ListTile(
                                                            title: Text(
                                                              data.mobileNo!,
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          );
                                                        },
                                                        onSuggestionSelected:
                                                            (suggestion) {
                                                          setState(() {
                                                            AutoData data =
                                                                suggestion
                                                                    as AutoData;
                                                            pics[index]
                                                                    .mobileNo =
                                                                data.mobileNo!;
                                                            // pic![index]
                                                            //         .mobileNo =
                                                            //     data.mobileNo!;
                                                            // addpic.pic![index]
                                                            //         .mobileNo =
                                                            //     pic![index]
                                                            //         .mobileNo;
                                                            expanded = false;
                                                            // widget.onSubmit!(
                                                            //     data);
                                                          });
                                                        },
                                                      )),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Container(
                                                      height: 45,
                                                      width: 350,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0) //                 <--- border radius here
                                                                ),
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: Colors.grey),
                                                      ),
                                                      child: TypeAheadFormField(
                                                        textFieldConfiguration:
                                                            TextFieldConfiguration(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          onTap: () {
                                                            setState(() {
                                                              (!expanded)
                                                                  ? expanded =
                                                                      true
                                                                  : expanded =
                                                                      false;
                                                              (expanded)
                                                                  ? controller
                                                                      .open()
                                                                  : controller
                                                                      .close();
                                                            });
                                                          },
                                                          controller:
                                                              TextEditingController(
                                                                  text: pics[
                                                                          index]
                                                                      .email),
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon: (!expanded)
                                                                ? Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .black)
                                                                : Icon(
                                                                    Icons
                                                                        .arrow_drop_up,
                                                                    color: Colors
                                                                        .black),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .always,
                                                            enabled: enableds ??
                                                                true,
                                                            hintText: 'Email',
                                                            hintStyle: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                            labelStyle:
                                                                TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            filled: true,
                                                            fillColor: (enableds ==
                                                                    null)
                                                                ? Colors.white
                                                                : true
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black38)),
                                                            disabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    width:
                                                                        0.0)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        0.5)),
                                                            errorBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        0.5)),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width:
                                                                        0.5)),
                                                          ),
                                                        ),
                                                        suggestionsCallback:
                                                            (pattern) async {
                                                          return await getSuggestionsemail(
                                                              pattern);
                                                        },
                                                        itemBuilder: (context,
                                                            suggestion) {
                                                          AutoData data =
                                                              suggestion
                                                                  as AutoData;
                                                          return ListTile(
                                                            title: Text(
                                                              data.email!,
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          );
                                                        },
                                                        onSuggestionSelected:
                                                            (suggestion) {
                                                          setState(() {
                                                            AutoData data =
                                                                suggestion
                                                                    as AutoData;
                                                            pics[index].email =
                                                                data.email!;
                                                            // pic![index].email =
                                                            //     data.email!;
                                                            // addpic.pic![index]
                                                            //         .email =
                                                            //     pic![index]
                                                            //         .email;
                                                            expanded = false;
                                                            // widget.onSubmit!(
                                                            //     data);
                                                          });
                                                        },
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 120, height: 40),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed('/supportpic');
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              style: ButtonStyle(
                                                  overlayColor: MaterialStateProperty
                                                      .resolveWith(
                                                    (states) {
                                                      return states.contains(
                                                              MaterialState
                                                                  .pressed)
                                                          ? Colors.grey
                                                          : null;
                                                    },
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          Colors.grey),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.zero,
                                                          side: BorderSide(
                                                              color: Colors.blue)))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 120, height: 40),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (_picadd.currentState!
                                                      .validate()) {
                                                    // if (pics.length != 0) {
                                                    setState(() {
                                                      addpic.companyId =
                                                          widget.ids;
                                                      addpic.pic = [];
                                                      for (int dtl = 0;
                                                          dtl < pics.length;
                                                          dtl++) {
                                                        addpic.pic!.add(
                                                          AddNewPic(
                                                              email: pics[dtl]
                                                                  .email,
                                                              mobileNo:
                                                                  pics[dtl]
                                                                      .mobileNo,
                                                              name: pics[dtl]
                                                                  .name,
                                                              picId: fill![dtl]
                                                                  .picId),
                                                        );
                                                      }
                                                      bloc.add(
                                                          AddBlocPIC(addpic));
                                                    });
                                                    // } else if (pics.length ==
                                                    //     0) {
                                                    //   setState(() {
                                                    //     addpic.companyId =
                                                    //         widget.ids;
                                                    //     addpic.pic = [];
                                                    //     for (int param = 0;
                                                    //         param <
                                                    //             listDtl.length;
                                                    //         param++) {
                                                    //       addpic.pic!.add(AddNewPic(
                                                    //           email:
                                                    //               listDtl[param]
                                                    //                   .email,
                                                    //           mobileNo:
                                                    //               listDtl[param]
                                                    //                   .mobileNo,
                                                    //           name:
                                                    //               listDtl[param]
                                                    //                   .name,
                                                    //           picId:
                                                    //               widget.ids));
                                                    //     }
                                                    //     ;
                                                    //     print('masuk null');
                                                    //     print(addpic);
                                                    //     bloc.add(
                                                    //         AddBlocPIC(addpic));
                                                    //   });
                                                    // }
                                                    // Navigator.pop(context);
                                                  }
                                                },
                                                child: Text('Submit')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List> getSuggestions(String pattern) async {
    ResponseGetAuto result = new ResponseGetAuto();
    result = await api.GetAutoData();
    List<AutoData> matches = [];
    matches.addAll(result.data!);
    matches.retainWhere(
      (element) => element.fullName!.toLowerCase().contains(
            pattern.toLowerCase(),
          ),
    );

    return matches;
  }

  Future<List> getSuggestionsphone(String pattern) async {
    ResponseGetAuto result = new ResponseGetAuto();
    result = await api.GetAutoData();
    List<AutoData> matches = [];
    matches.addAll(result.data!);
    matches.retainWhere(
      (element) => element.mobileNo!.toLowerCase().contains(
            pattern.toLowerCase(),
          ),
    );

    return matches;
  }

  Future<List> getSuggestionsemail(String pattern) async {
    ResponseGetAuto result = new ResponseGetAuto();
    result = await api.GetAutoData();
    List<AutoData> matches = [];
    matches.addAll(result.data!);
    matches.retainWhere(
      (element) => element.email!.toLowerCase().contains(
            pattern.toLowerCase(),
          ),
    );

    return matches;
  }
}
