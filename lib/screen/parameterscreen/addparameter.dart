import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/parameterbloc/bloc/parameter_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/model/parametermodel.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:web_wot/screen/parameterscreen/param_form.dart';
// import 'package:web_wot/screen/parameterscreen/parameterscreen.dart';

class AddParameter extends StatefulWidget {
  final String groupcode;
  final String groupname;
  List<ListParameter> listpar = [ListParameter(isChecked: false)];

  // final List<ListParameter> listpar;
  AddParameter({
    Key? key,
    required this.groupcode,
    required this.groupname,
    required this.listpar,
    // required this.listpar
  }) : super(key: key);

  @override
  State<AddParameter> createState() => _AddParameterState();
}

class _AddParameterState extends State<AddParameter>
    with SingleTickerProviderStateMixin {
  bool checkAll = false;
  TextEditingController _ParamHeaderCode = TextEditingController();
  TextEditingController _ParamHeaderName = TextEditingController();
  // TextEditingController _ParameterDummy = TextEditingController();
  List<ListParameter> respadd = [];
  ListParameter modeladd = ListParameter();
  RequestParameterAdd addparam = RequestParameterAdd();
  RequestParameterSearch req = new RequestParameterSearch();
  ResponseParameterSearch addreq = ResponseParameterSearch();
  late ParameterBloc bloc;
  List<ParamList> listparam = [];
  ParamList listparams = ParamList();
  List<ListParameter> listpart = [];
  bool? onChecked = false;
  // String? b;

  @override
  void initState() {
    req.pageSize = 10;
    req.pageNumber = 1;
    req.paramGroupCode = '';
    req.paramGroupName = '';
    req.param = '';
    print(widget.listpar);
    // dtlCodeCo.text =
    // for (int i = 0; i < widget.listpar.length; i++) {
    //   // _ParameterDummy.text = widget.listpar[i].paramCode.toString();
    //   _ParameterDummy1.text = widget.listpar[i].paramDesc.toString();
    //   _ParameterDummy2.text = widget.listpar[i].paramName.toString();
    // }
    _ParamHeaderCode.text = widget.groupcode;
    _ParamHeaderName.text = widget.groupname;
    // b = widget.groupcode;
    print(widget.groupcode + 'addparameter');
    super.initState();
  }

  // addparam.paramList = [];

  final _paramadd = GlobalKey<FormState>();
  List<AddDtl> listDtl = [
    AddDtl(isChecked: false),
  ];
  List<ListParameter> listprm = [
    ListParameter(isChecked: false),
  ];
  double _size = 250.0;
  bool _large = true;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ParameterBloc>(context);
    checkAll = listDtl.every((element) => element.isChecked == true) &&
        listDtl.isNotEmpty;
    return BlocListener<ParameterBloc, ParameterState>(
      listener: (context, state) {
        if (state is AddParamSuccess) {
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
          print('screenadd');
          bloc.add(SearchParam(req));
        }
        if (state is SearchSuccess) {
          setState(() {
            print('masuk search2add');
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
                        const Text(
                          'Add',
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
                            'Home / Master / Parameter / Add',
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
                                    key: _paramadd,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Parameter Header',
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
                                                  'Parameter Code',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 350,
                                                  height: 55,
                                                  child: TextFormField(
                                                    // initialValue:
                                                    //     widget.groupcode,
                                                    //     widget.groupcode,
                                                    controller:
                                                        _ParamHeaderCode,
                                                    maxLength: 20,
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
                                                  'Parameter Name',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: 350,
                                                  height: 55,
                                                  child: TextFormField(
                                                    // initialValue:
                                                    //     widget.groupname,
                                                    controller:
                                                        _ParamHeaderName,
                                                    maxLength: 20,
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
                                              'Parameter Detail',
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
                                                      listDtl.add(AddDtl(
                                                          isChecked: false));
                                                    });
                                                    setState(() {
                                                      widget.listpar.add(
                                                          ListParameter(
                                                              isChecked:
                                                                  false));
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
                                                  setState(() {
                                                    widget.listpar.removeWhere(
                                                        (element) =>
                                                            element.isChecked ==
                                                            true);
                                                    checkAll = false;
                                                  });
                                                  setState(() {
                                                    listDtl.removeWhere(
                                                        (element) =>
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
                                                        MaterialStateProperty.all<Color>(
                                                            Colors.white),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(color: Colors.blue)))),
                                              ),
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
                                                      // if (widget
                                                      //         .listpar.length !=
                                                      //     0) {
                                                      setState(() {
                                                        checkAll = false;
                                                        if (widget.listpar
                                                            .isNotEmpty) {
                                                          for (var item
                                                              in widget
                                                                  .listpar) {
                                                            item.isChecked =
                                                                val;
                                                          }
                                                        }
                                                      });
                                                      // }
                                                      // else {
                                                      setState(() {
                                                        checkAll = false;
                                                        if (listDtl
                                                            .isNotEmpty) {
                                                          for (var item
                                                              in listDtl) {
                                                            item.isChecked =
                                                                val;
                                                          }
                                                        }
                                                      });
                                                      // }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 4),
                                                  child: Text(
                                                    "Parameter Detail Code",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 4),
                                                  child: Text(
                                                    "Parameter Detail Name",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12,
                                                      horizontal: 4),
                                                  child: Text(
                                                    "Description",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (widget.listpar.length == 0)
                                          ListView.builder(
                                            itemCount: listDtl.isNotEmpty
                                                ? listDtl.length
                                                : 1,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (ctx, i) {
                                              if (listDtl.isNotEmpty) {
                                                return ParamFormItem(
                                                  model: listDtl[i],
                                                  isLast:
                                                      i == listDtl.length - 1,
                                                  onCheckedChanged: (val) {
                                                    setState(() {
                                                      listDtl[i].isChecked =
                                                          val;
                                                    });
                                                  },
                                                  onCodeChanged: (val) {
                                                    listDtl[i].detailCd = val;
                                                    // a = listDtl[i].detailCd;
                                                  },
                                                  onNameChanged: (val) {
                                                    listDtl[i].detailName = val;
                                                    //  b = listDtl[i].detailName;
                                                  },
                                                  onDescChanged: (val) {
                                                    listDtl[i].detailDesc = val;
                                                    // c = listDtl[i].detailDesc;
                                                  },
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            },
                                          )
                                        else
                                          ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: widget.listpar.length,
                                            itemBuilder: (context, index) {
                                              // _ParameterDummy.add(
                                              //     new TextEditingController());
                                              return Container(
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
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.blue,
                                                            width: 2,
                                                          ),
                                                          value: widget
                                                                  .listpar[
                                                                      index]
                                                                  .isChecked ??
                                                              false,
                                                          onChanged: (val) {
                                                            setState(() {
                                                              widget
                                                                      .listpar[
                                                                          index]
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
                                                      height: 55,
                                                      width: 250,
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                          // labelText: "Enter Email",
                                                          fillColor:
                                                              Colors.white,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400),
                                                          ),
                                                        ),
                                                        controller:
                                                            TextEditingController(
                                                          text: widget
                                                              .listpar[index]
                                                              .paramCode
                                                              .toString(),
                                                        ),
                                                        onChanged: (value) {
                                                          widget.listpar[index]
                                                                  .paramCode =
                                                              value;
                                                          listparam[index]
                                                                  .paramCode =
                                                              value;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      height: 55,
                                                      width: 350,
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                          // labelText: "Enter Email",
                                                          fillColor:
                                                              Colors.white,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400),
                                                          ),
                                                        ),
                                                        controller:
                                                            TextEditingController(
                                                          text: widget
                                                              .listpar[index]
                                                              .paramDesc
                                                              .toString(),
                                                        ),
                                                        onChanged: (value) {
                                                          widget.listpar[index]
                                                                  .paramDesc =
                                                              value;
                                                          listparam[index]
                                                                  .paramDesc =
                                                              value;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Container(
                                                      height: 55,
                                                      width: 350,
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          8),
                                                          // labelText: "Enter Email",
                                                          fillColor:
                                                              Colors.white,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide:
                                                                const BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide: BorderSide(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400),
                                                          ),
                                                        ),
                                                        controller:
                                                            TextEditingController(
                                                          text: widget
                                                              .listpar[index]
                                                              .paramName
                                                              .toString(),
                                                        ),
                                                        onChanged: (value) {
                                                          widget.listpar[index]
                                                                  .paramName =
                                                              value;
                                                          listparam[index]
                                                                  .paramName =
                                                              value;
                                                        },
                                                      ),
                                                    ),
                                                  ],
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
                                                      .pushNamed('/parameter');
                                                },
                                                child: Text(
                                                  'Cancel',
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
                                                        MaterialStateProperty.all<Color>(
                                                            Colors.white),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            side: BorderSide(color: Colors.blue)))),
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
                                                    if (_paramadd.currentState!
                                                        .validate()) {
                                                      if (widget
                                                              .listpar.length !=
                                                          0) {
                                                        setState(() {
                                                          addparam.paramGroupCd =
                                                              _ParamHeaderCode
                                                                  .text;
                                                          addparam.paramGroupName =
                                                              _ParamHeaderName
                                                                  .text;
                                                          addparam.paramList =
                                                              [];
                                                          for (int dtl = 0;
                                                              dtl <
                                                                  widget.listpar
                                                                      .length;
                                                              dtl++) {
                                                            addparam.paramList!.add(ParamList(
                                                                paramCode: widget
                                                                    .listpar[
                                                                        dtl]
                                                                    .paramCode,
                                                                paramDesc: widget
                                                                    .listpar[
                                                                        dtl]
                                                                    .paramDesc,
                                                                paramName: widget
                                                                    .listpar[
                                                                        dtl]
                                                                    .paramName));
                                                          }
                                                          bloc.add(AddParam(
                                                              addparam));
                                                        });
                                                      } else if (widget
                                                              .listpar.length ==
                                                          0) {
                                                        setState(() {
                                                          addparam.paramGroupCd =
                                                              _ParamHeaderCode
                                                                  .text;
                                                          addparam.paramGroupName =
                                                              _ParamHeaderName
                                                                  .text;
                                                          addparam.paramList =
                                                              [];
                                                          for (int param = 0;
                                                              param <
                                                                  listDtl
                                                                      .length;
                                                              param++) {
                                                            addparam.paramList!.add(ParamList(
                                                                paramCode: listDtl[
                                                                        param]
                                                                    .detailCd,
                                                                paramDesc: listDtl[
                                                                        param]
                                                                    .detailDesc,
                                                                paramName: listDtl[
                                                                        param]
                                                                    .detailName));
                                                          }
                                                          ;
                                                          print(addparam);
                                                          bloc.add(AddParam(
                                                              addparam));
                                                        });
                                                      }
                                                      // Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Text('Submit')),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
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
          ],
        ),
      ),
    );
  }
}
