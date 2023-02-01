import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/userbloc/bloc/user_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/screen/menu.dart';

class Userscreen extends StatefulWidget {
  const Userscreen({Key? key}) : super(key: key);

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen>
    with SingleTickerProviderStateMixin {
  double _size = 250.0;
  String? dropdownValue;
  List<String> options = [];
  PlatformFile? objFile = null;
  String? dropdownValues;
  String pesan = '';
  late DropzoneViewController controller;
  bool isChecked = false;
  bool addChecked = false;
  TextEditingController _Usercode = TextEditingController();
  TextEditingController _Name = TextEditingController();
  TextEditingController _AddUserCode = TextEditingController();
  TextEditingController _AddEmail = TextEditingController();
  TextEditingController _AddFullName = TextEditingController();
  bool _large = true;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  String? imagePath;
  Image? images;
  File? _photo;
  File? imgs;
  Uint8List webimg = Uint8List(8);
  var f;
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media, StateSetter setState) async {
    image = await picker.pickImage(source: media);
    f = await image!.readAsBytes();
    setState(() {
      webimg = f;
    });
  }

  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
        print(objFile!.name);
      });
    }
  }

  Future dropzoneresult(ev) async {
    setState(() {
      pesan = '${ev.name} dropped';
    });
    final byte = await controller.getFileData(ev);
    final name = ev.name;
    final mime = await controller.getFileMIME(ev);
    final size = await controller.getFileSize(ev);
    final url = await controller.createFileUrl(ev);
    // print(bytes.sublist(0, 20));
    final droppedFile = File_Data_Model(
        name: name, mime: mime, bytes: byte, url: url, sizes: size);

    // bloc.add(UploadSOFile(droppedFile));
  }

  late UserBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<UserBloc>(context);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        // TODO: implement listener
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
                          'User',
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
                            'Home / User Access / User',
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
                        child: ListView(scrollDirection: Axis.vertical,
                            // controller: _mainscroll,
                            children: [
                              Container(
                                height: 124,
                                color: const Color(0xFFE7E7E7),
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
                                child: Card(
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 10, 16, 0),
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
                                                  'Company',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: 250,
                                                  height: 35,
                                                  margin: EdgeInsets.only(
                                                      bottom: 17),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors
                                                              .grey.shade400),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      // key: _keysettinggroup,
                                                      decoration:
                                                          const InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 3.0,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      dropdownColor:
                                                          Colors.white,
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
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          value: val,
                                                        );
                                                      }).toList(),
                                                      onChanged: (val) {
                                                        dropdownValue = val;
                                                        // reqset.settingGroup =
                                                        dropdownValue;
                                                        // bloc.add(
                                                        //     Search(reqset));
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
                                              text: 'User Code',
                                              controller: _Usercode,
                                              length: 15,
                                              onChanged: (val) {
                                                // reqset.settingCode = val;
                                              },
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Textbox(
                                              text: 'Name',
                                              controller: _Name,
                                              length: 15,
                                              onChanged: (val) {
                                                // reqset.value = val;
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
                                                  // bloc.add(Search(reqset));
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
                                                  // _keysettinggroup.currentState!
                                                  //     .reset();
                                                  // _Settinggroupcd.clear();
                                                  // reqset.settingCode = '';
                                                  // _Settingcode.clear();
                                                  // reqset.settingGroup = '';
                                                  // _Value.clear();
                                                  // reqset.value = '';
                                                  // bloc.add(Search(reqset));
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
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                // width: 2000,
                                color: const Color(0xFFE7E7E7),
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Card(
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 10, 16, 0),
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
                                                    AddUserDialog(context);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.blue),
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
                                                    EditUserAction();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons.edit),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const Text('Edit'),
                                                    ],
                                                  ),
                                                  style:
                                                      OutlinedButton.styleFrom(
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
                                                width: 170,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    OverrideAction();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                          'Override Password'),
                                                    ],
                                                  ),
                                                  style:
                                                      OutlinedButton.styleFrom(
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
                                                    // DeleteSettings();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(Icons.delete),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const Text('Delete'),
                                                    ],
                                                  ),
                                                  style:
                                                      OutlinedButton.styleFrom(
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
                                                        .pushNamed(
                                                            '/user/import');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text('Import'),
                                                    ],
                                                  ),
                                                  style:
                                                      OutlinedButton.styleFrom(
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
                                                    data: Theme.of(context)
                                                        .copyWith(
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      itemBuilder: (BuildContext
                                                              context) =>
                                                          [
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            // setState(
                                                            //   () {
                                                            //     downreq.settingGroup =
                                                            //         reqset
                                                            //             .settingGroup;
                                                            //     downreq.settingName =
                                                            //         _Settingcode
                                                            //             .text;
                                                            //     downreq.value =
                                                            //         _Value.text;
                                                            //     downreq.extention =
                                                            //         'csv';
                                                            //     bloc.add(
                                                            //         DownloadFile(
                                                            //             downreq));
                                                            //   },
                                                            // );
                                                          },
                                                          value: () {},
                                                          child: const Text(
                                                            'CSV',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            // setState(
                                                            //   () {
                                                            //     downreq.settingGroup =
                                                            //         reqset
                                                            //             .settingGroup;
                                                            //     downreq.settingName =
                                                            //         _Settingcode
                                                            //             .text;
                                                            //     downreq.value =
                                                            //         _Value.text;
                                                            //     downreq.extention =
                                                            //         'xls';
                                                            //     bloc.add(
                                                            //         DownloadFile(
                                                            //             downreq));
                                                            //   },
                                                            // );
                                                          },
                                                          value:
                                                              () {}, //_exportToExcel,
                                                          child: const Text(
                                                            'XLS',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            // setState(
                                                            //   () {
                                                            //     downreq.settingGroup =
                                                            //         reqset
                                                            //             .settingGroup;
                                                            //     downreq.settingName =
                                                            //         _Settingcode
                                                            //             .text;
                                                            //     downreq.value =
                                                            //         _Value.text;
                                                            //     downreq.extention =
                                                            //         'xlsx';
                                                            //     bloc.add(
                                                            //         DownloadFile(
                                                            //             downreq));
                                                            //   },
                                                            // );
                                                          },
                                                          value: () {},
                                                          child: const Text(
                                                            'XLSX',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: birulangit,
                                                    child: Row(
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
                                                            value: isChecked,
                                                            onChanged:
                                                                (bool? value) {
                                                              // setState(() {
                                                              //   var i = 0;
                                                              //   if (ex[i]
                                                              //           .isChecked ==
                                                              //       false) {
                                                              //     isChecked =
                                                              //         true;
                                                              //     for (i = 0;
                                                              //         i <
                                                              //             ex
                                                              //                 .length;
                                                              //         i++)
                                                              //       ex[i].isChecked =
                                                              //           true;
                                                              //   } else if (ex[i]
                                                              //           .isChecked ==
                                                              //       true) {
                                                              //     isChecked =
                                                              //         false;
                                                              //     for (i = 0;
                                                              //         i <
                                                              //             ex
                                                              //                 .length;
                                                              //         i++)
                                                              //       ex[i].isChecked =
                                                              //           false;
                                                              //   }
                                                              // });
                                                            },
                                                            side:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.07,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: const Text(
                                                              'User Code',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.10,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: const Text(
                                                              'Email Address',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.10,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: const Text(
                                                              'Name',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              'Role',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.10,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                              'Company',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.10,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: const Text(
                                                              'Created By',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.10,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: const Text(
                                                              'Created Date',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.10,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: const Text(
                                                              'Changed By',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.10,
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                            child: const Text(
                                                              'Changed Date',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
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
                                                  // if (ex.length > 0 ||
                                                  //     ex.isNotEmpty)
                                                  //   BlocBuilder<UserBloc,
                                                  //       UserState>(
                                                  //     builder:
                                                  //         (context, state) {
                                                  //       return Container(
                                                  //         //isi table
                                                  //         height: MediaQuery.of(
                                                  //                     context)
                                                  //                 .size
                                                  //                 .height *
                                                  //             0.4,
                                                  //         width: MediaQuery.of(
                                                  //                 context)
                                                  //             .size
                                                  //             .width,
                                                  //         child:
                                                  //             ListView.builder(
                                                  //           itemCount:
                                                  //               ex.length,
                                                  //           itemBuilder: (context,
                                                  //                   index) =>
                                                  //               Column(
                                                  //                   children: [
                                                  //                 Row(
                                                  //                   children: [
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.03,
                                                  //                       child:
                                                  //                           Checkbox(
                                                  //                         checkColor:
                                                  //                             Colors.black,
                                                  //                         fillColor:
                                                  //                             MaterialStateProperty.resolveWith(getColor),
                                                  //                         value:
                                                  //                             ex[index].isChecked,
                                                  //                         onChanged:
                                                  //                             (bool? value) {
                                                  //                           setState(() {
                                                  //                             ex[index].isChecked = value!;
                                                  //                           });
                                                  //                         },
                                                  //                         side:
                                                  //                             const BorderSide(color: Colors.grey),
                                                  //                       ),
                                                  //                     ),
                                                  //                     SizedBox(
                                                  //                       width:
                                                  //                           10,
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.07,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].settingGroupCode.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     SizedBox(
                                                  //                       width:
                                                  //                           10,
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.10,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].settingCode.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     SizedBox(
                                                  //                       width:
                                                  //                           10,
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.10,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].settingDesc.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     SizedBox(
                                                  //                       width:
                                                  //                           10,
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.08,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].settingValueType.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     SizedBox(
                                                  //                       width:
                                                  //                           10,
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.10,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].settingValue.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     SizedBox(
                                                  //                       width:
                                                  //                           10,
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.10,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].createdBy.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     SizedBox(
                                                  //                       width:
                                                  //                           10,
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.10,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].createdTime.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.10,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].updatedBy.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                     Container(
                                                  //                       height:
                                                  //                           50,
                                                  //                       width: MediaQuery.of(context).size.width *
                                                  //                           0.10,
                                                  //                       child:
                                                  //                           Padding(
                                                  //                         padding:
                                                  //                             const EdgeInsets.symmetric(vertical: 15),
                                                  //                         child:
                                                  //                             Text(
                                                  //                           ex[index].updatedTime.toString(),
                                                  //                           style:
                                                  //                               TextStyle(color: Colors.black),
                                                  //                         ),
                                                  //                       ),
                                                  //                     ),
                                                  //                   ],
                                                  //                 ),
                                                  //               ]),
                                                  //         ),
                                                  //       );
                                                  //     },
                                                  //   )
                                                  // else
                                                  //   Container(
                                                  //     height: 20,
                                                  //     // color: Colors.grey,
                                                  //     width:
                                                  //         MediaQuery.of(context)
                                                  //             .size
                                                  //             .width,
                                                  //     child: Column(
                                                  //       children: const [
                                                  //         Center(
                                                  //           child: Text(
                                                  //             'No Data Found',
                                                  //             style: TextStyle(
                                                  //                 color: Colors
                                                  //                     .black),
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //   )
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 10),
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
                                              color: Colors.black87,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '1', //('1 - ' + hal.toString() + ' of'),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'null', // (total.toString() + ' data'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              // reqset.pageSize = 10;
                                              // reqset.pageNumber = 0;
                                              // // page = 1;
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
                                              //  page--;
                                              // reqset.pageSize = 10;
                                              // //  reqset.pageNumber = page - 1;

                                              // bloc.add(Search(reqset));
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
                                                // reqset.pageSize = 10;
                                                // // reqset.pageNumber = page;
                                                // // page++;
                                                // bloc.add(Search(reqset));
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
                                                // reqset.pageSize = 10;
                                                // reqset.pageNumber = 3;
                                                // // page = 4;
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
                            ])),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future AddUserDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User - Add',
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
                // controller: _scrollgrid,
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 600,
                  width: 550,
                  child: Form(
                    // key: _menuaddKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'User Code',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _AddUserCode,
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
                            'Email Address',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _AddEmail,
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
                            'Full Name',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _AddFullName,
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
                                // key: _keyaddmenu,
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
                                  // addmenu.parent = vals!.split(" - ")[0];
                                  // reqset.settingGroup = dropdownValue;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Role',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 170,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                              color: Colors
                                                  .black, //your desire colour here
                                              width: 1.5,
                                            ),
                                            tristate: false,
                                            checkColor: Colors.black,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: addChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (addChecked == false) {
                                                  addChecked = true;
                                                } else if (addChecked == true) {
                                                  {
                                                    addChecked = false;
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Admin',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                              color: Colors
                                                  .black, //your desire colour here
                                              width: 1.5,
                                            ),
                                            tristate: false,
                                            checkColor: Colors.black,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: addChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (addChecked == false) {
                                                  addChecked = true;
                                                } else if (addChecked == true) {
                                                  {
                                                    addChecked = false;
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'User Whiteopen',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                              color: Colors
                                                  .black, //your desire colour here
                                              width: 1.5,
                                            ),
                                            tristate: false,
                                            checkColor: Colors.black,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: addChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (addChecked == false) {
                                                  addChecked = true;
                                                } else if (addChecked == true) {
                                                  {
                                                    addChecked = false;
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'User TMMIN',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 170,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                              color: Colors
                                                  .black, //your desire colour here
                                              width: 1.5,
                                            ),
                                            tristate: false,
                                            checkColor: Colors.black,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: addChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (addChecked == false) {
                                                  addChecked = true;
                                                } else if (addChecked == true) {
                                                  {
                                                    addChecked = false;
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'User BTPN',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                              color: Colors
                                                  .black, //your desire colour here
                                              width: 1.5,
                                            ),
                                            tristate: false,
                                            checkColor: Colors.black,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: addChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (addChecked == false) {
                                                  addChecked = true;
                                                } else if (addChecked == true) {
                                                  {
                                                    addChecked = false;
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'User BTPNS',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                              color: Colors
                                                  .black, //your desire colour here
                                              width: 1.5,
                                            ),
                                            tristate: false,
                                            checkColor: Colors.black,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: addChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (addChecked == false) {
                                                  addChecked = true;
                                                } else if (addChecked == true) {
                                                  {
                                                    addChecked = false;
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'User Adira',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
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
                                      color: Colors.blue,
                                      width: 1), //<-- SEE HERE
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  // addsetting.settingGroupCode = settinggroupcd;
                                  // addsetting.settingCode = settingcode;
                                  // addsetting.settingDesc = settingdesc;
                                  // addsetting.settingValueType =
                                  //     settingvaluetype;
                                  // addsetting.settingValue = settingvalue;
                                  // bloc.add(EditSettings(addsetting));
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
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
      });

  Future EditUserAction() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User - Edit',
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
                  // controller: _scrollgrid,
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: 650,
                    width: 550,
                    child: Form(
                      // key: _roleaddKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'User Code',
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
                              'Email Address',
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
                              'Full Name',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
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
                              height: 5,
                            ),
                            const Text(
                              'Company',
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
                                  // key: _keyaddmenu,
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
                                    // addmenu.parent = vals!.split(" - ")[0];
                                    // reqset.settingGroup = dropdownValue;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Role',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 170,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              side: BorderSide(
                                                color: Colors
                                                    .black, //your desire colour here
                                                width: 1.5,
                                              ),
                                              tristate: false,
                                              checkColor: Colors.black,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: addChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (addChecked == false) {
                                                    addChecked = true;
                                                  } else if (addChecked ==
                                                      true) {
                                                    {
                                                      addChecked = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Admin',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              side: BorderSide(
                                                color: Colors
                                                    .black, //your desire colour here
                                                width: 1.5,
                                              ),
                                              tristate: false,
                                              checkColor: Colors.black,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: addChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (addChecked == false) {
                                                    addChecked = true;
                                                  } else if (addChecked ==
                                                      true) {
                                                    {
                                                      addChecked = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'User Whiteopen',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              side: BorderSide(
                                                color: Colors
                                                    .black, //your desire colour here
                                                width: 1.5,
                                              ),
                                              tristate: false,
                                              checkColor: Colors.black,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: addChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (addChecked == false) {
                                                    addChecked = true;
                                                  } else if (addChecked ==
                                                      true) {
                                                    {
                                                      addChecked = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'User TMMIN',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 170,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              side: BorderSide(
                                                color: Colors
                                                    .black, //your desire colour here
                                                width: 1.5,
                                              ),
                                              tristate: false,
                                              checkColor: Colors.black,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: addChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (addChecked == false) {
                                                    addChecked = true;
                                                  } else if (addChecked ==
                                                      true) {
                                                    {
                                                      addChecked = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'User BTPN',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              side: BorderSide(
                                                color: Colors
                                                    .black, //your desire colour here
                                                width: 1.5,
                                              ),
                                              tristate: false,
                                              checkColor: Colors.black,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: addChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (addChecked == false) {
                                                    addChecked = true;
                                                  } else if (addChecked ==
                                                      true) {
                                                    {
                                                      addChecked = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'User BTPNS',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              side: BorderSide(
                                                color: Colors
                                                    .black, //your desire colour here
                                                width: 1.5,
                                              ),
                                              tristate: false,
                                              checkColor: Colors.black,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: addChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (addChecked == false) {
                                                    addChecked = true;
                                                  } else if (addChecked ==
                                                      true) {
                                                    {
                                                      addChecked = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'User Adira',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Verified Date',
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harap diisi, Tidak boleh kosong';
                                  }
                                  return null;
                                },
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
                                        color: Colors.blue,
                                        width: 1), //<-- SEE HERE
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // addsetting.settingGroupCode = settinggroupcd;
                                    // addsetting.settingCode = settingcode;
                                    // addsetting.settingDesc = settingdesc;
                                    // addsetting.settingValueType =
                                    //     settingvaluetype;
                                    // addsetting.settingValue = settingvalue;
                                    // bloc.add(EditSettings(addsetting));
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
                          ]),
                    ),
                  ),
                )),
          );
        });
      });

  Future OverrideAction() => showDialog(
      context: context,
      builder: (BuildContext context) {
        // return MyDialog();
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User - Override Password',
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
              height: 950,
              width: 550,
              child: SingleChildScrollView(
                // controller: _scrollgrid,
                scrollDirection: Axis.vertical,
                child: Expanded(
                  child: Container(
                    height: 950,
                    width: 550,
                    child: Form(
                      // key: _roleaddKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'User Code',
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
                              'Email Address',
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
                              'Full Name',
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
                              'Company',
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
                              'User Code',
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
                              'Reason',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
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
                              'Evidence',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 150,
                              color: Colors.grey.shade300,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.shade300,
                                // height: 115,
                                child: Stack(
                                  children: [
                                    // DropzoneView(
                                    //   onDrop: (dynamic ev) => dropzoneresult(ev),
                                    //   onCreated: (dropcontroller) =>
                                    //       this.controller = dropcontroller,
                                    // ),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          image != null
                                              ? kIsWeb
                                                  ? Container(
                                                      height: 200,
                                                      width: 200,
                                                      child: Image.memory(
                                                        webimg,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 200,
                                                      width: 200,
                                                      child: Image.file(
                                                        File(image!.path),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                              : Column(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .cloud_upload_outlined,
                                                      color: Colors.black,
                                                      size: 40,
                                                    ),
                                                    Text(
                                                      "No Image",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: 'Drop your file or ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: 'Browse ',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => getImage(
                                                    ImageSource.gallery,
                                                    setState), //chooseFileUsingFilePicker()
                                            ),
                                            TextSpan(
                                              text:
                                                  '\n Allowed file formats: xlsx',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            if (pesan != null)
                                              TextSpan(
                                                  text: pesan,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            if (objFile != null)
                                              TextSpan(
                                                  text:
                                                      "File yang dipilih : ${objFile!.name}"),
                                            if (objFile != null)
                                              TextSpan(
                                                  text:
                                                      "  ${objFile!.size} bytes"),
                                          ]))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      image = null;
                                    });
                                  },
                                  child: Text(
                                    'Delete File',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                  ),
                                ),
                              ],
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
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      });
}

// class MyDialog extends StatefulWidget {
//   const MyDialog({Key? key}) : super(key: key);

//   @override
//   State<MyDialog> createState() => _MyDialogState();
// }

// class _MyDialogState extends State<MyDialog> {
//   String? imagePath;
//   Image? images;
//   File? _photo;
//   File? imgs;
//   Uint8List webimg = Uint8List(8);

//   XFile? image;

//   final ImagePicker picker = ImagePicker();

//   //we can upload image from camera or from gallery based on parameter
//   Future getImage(ImageSource media, StateSetter setState) async {
//     image = await picker.pickImage(source: media);
//     var f = await image!.readAsBytes();
//     setState(() {
//       webimg = f;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//       return AlertDialog(
//         backgroundColor: Colors.grey.shade400,
//         content: new SingleChildScrollView(
//           child: new ListBody(
//             children: <Widget>[
//               image == null
//                   ? DottedBorder(
//                       child: Container(
//                         height: 200,
//                         width: 150,
//                       ),
//                       color: Colors.grey.shade200,
//                     )
//                   : kIsWeb
//                       ? Image.memory(
//                           webimg,
//                           fit: BoxFit.fill,
//                         )
//                       : Image.file(
//                           File(image!.path),
//                           fit: BoxFit.fill,
//                         ),
//               SizedBox(
//                 height: 10,
//               ),
//               // Container(child: images != null ? images : null),
//               GestureDetector(
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.camera),
//                       SizedBox(width: 5),
//                       Text('Take a picture '),
//                     ],
//                   ),
//                   onTap: () async {
//                     setState(() {
//                       getImage(ImageSource.gallery, setState);
//                       // _pickImage();
//                     });
//                   }),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
