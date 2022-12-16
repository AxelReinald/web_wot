import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:http/http.dart' as http;
import 'package:web_wot/bloc/settinggroupbloc/setting_group_bloc.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/helper/upload_set.dart';
import 'package:web_wot/model/setting_group.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';

class Import extends StatefulWidget {
  const Import({Key? key}) : super(key: key);

  @override
  State<Import> createState() => _ImportState();
}

class _ImportState extends State<Import> with SingleTickerProviderStateMixin {
  double _size = 250.0;
  late SettingGroupBloc bloc;
  DownData download = DownData();
  DownloadRequestSettings dowreq = new DownloadRequestSettings();
  bool _large = true;
  Uploadresponse response = Uploadresponse();
  late File selectedfile;
  // Response response;
  late String progress;
  var cetak;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  void opendir() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result != null && result.files.isNotEmpty) {
      // File file = File(result.files.single.path!);
      final fileBytes = result.files.first.bytes.toString();
      final fileName = result.files.first.name;
      // bloc.add(Upload(fileBytes));
      setState(() {});
    } else {
      return;
      // User canceled the picker
    }
  }

  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SettingGroupBloc>(context);
    return BlocListener<SettingGroupBloc, SettingGroupState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SettingLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DownloadTemplateSuccess) {
          setState(() {
            download = state.resp.data!;
            writeFileWeb(
                download.base64Data.toString(), download.fileName.toString());
          });
        }
        if (state is UploadSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Upload Berhasil',
                    style: TextStyle(
                      color: Colors.white,
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
                          'Import',
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
                            'Home / Admin / SettingGroup / Import',
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
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              height: 250,
                              child: Stack(
                                children: [
                                  DropzoneView(
                                    onDrop: (value) {
                                      print('masuk file');
                                    },
                                    onCreated: (dropcontroller) =>
                                        this.controller = dropcontroller,
                                  ),
                                  DottedBorder(
                                    radius: Radius.circular(15),
                                    strokeWidth: 1,
                                    color: Colors.grey,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload_outlined,
                                            color: Colors.black,
                                            size: 50,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: 'Drag and Drop or ',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  opendir();
                                                  //print('masuk browse');
                                                },
                                              text: 'Browse ',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            TextSpan(
                                                text: 'your file here\n\n',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            TextSpan(
                                              text:
                                                  'Allowed file formats: xlsx',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ]))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Row(children: [
                                TextButton(
                                  onPressed: () {
                                    bloc.add(DownloadTemplate(dowreq));
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.download),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('Download file Template')
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // bloc.add(Upload());
                                      //Uploadrequest();
                                    },
                                    child: Text('Submit')),
                              ]),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
