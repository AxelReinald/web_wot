import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:web_wot/bloc/supportedobjectbloc/bloc/supported_object_bloc.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/supportedobjectmodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:http/http.dart' as http;

class UploadSO extends StatefulWidget {
  const UploadSO({Key? key}) : super(key: key);

  @override
  State<UploadSO> createState() => _UploadSOState();
}

class _UploadSOState extends State<UploadSO>
    with SingleTickerProviderStateMixin {
  double _size = 250.0;
  PlatformFile? objFile = null;
  late DropzoneViewController controller;
  late SupportedObjectBloc bloc;
  TempData tempso = TempData();
  bool _large = true;
  String pesan = '';
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
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

    bloc.add(UploadSOFile(droppedFile));
  }

  void uploadSelectedFile() async {
    //---Create http package multipart request object
    // var stream = new http.ByteStream(objFile!.());
    // stream.cast();
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "http://192.168.0.130:9017/temacs/api/temacs/main/v1/uploadSupportedObject"),
    );
    //-----add other fields if needed
    // request.fields["id"] = "abc";
    // print(objFile!.name);
    //-----add selected file with request
    request.files.add(http.MultipartFile(
        "file", objFile!.readStream!, objFile!.size,
        filename: objFile!.name));
    print(objFile!.readStream!);
    //-------Send request
    var resp = await request.send();
    //------Read response
    String result = await resp.stream.bytesToString();

    if (result.contains("Success")) {
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
              backgroundColor: Colors.blue),
        );
    } else if (result.contains("error")) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 5),
              content: Text(
                'Upload Gagal',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red),
        );
    }
    //-------Your response
    // print(result);
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SupportedObjectBloc>(context);
    return BlocListener<SupportedObjectBloc, SupportedObjectState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is TemplateSuccess) {
          setState(() {
            tempso = state.resp.data!;
            writeFileWeb(
                tempso.base64Data.toString(), tempso.fileName.toString());
          });
        }
        if (state is UploadSOSuccess) {
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
                  backgroundColor: Colors.blue),
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
                            'Home / Master / Supported Object / Import',
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
                                    onDrop: (dynamic ev) => dropzoneresult(ev),
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
                                                text: 'Browse ',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () =>
                                                      chooseFileUsingFilePicker()),
                                            // () async {
                                            //   picked = await FilePicker
                                            //       .platform
                                            //       .pickFiles();

                                            //  },

                                            // ),
                                            TextSpan(
                                                text: 'your file here\n\n',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            TextSpan(
                                              text:
                                                  'Allowed file formats: xlsx\n\n',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            if (pesan != null)
                                              TextSpan(text: pesan),

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
                                    bloc.add(DownloadTemplateSO());
                                  },
                                  child: Row(
                                    children: [
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
                                      Navigator.of(context)
                                          .pushNamed('/supportedobject');
                                    },
                                    child: Text('Cancel')),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () => uploadSelectedFile(),

                                  // () {
                                  //   // _validateInputs();
                                  //   // bloc.add(Upload());
                                  //   // Uploadrequest();
                                  // },
                                  child: Text('Submit'),
                                ),
                              ]),
                            )
                          ]),
                        ),
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