import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:web_wot/bloc/citybloc/bloc/city_bloc.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/citymodel.dart';
import 'package:web_wot/model/uploadmodel.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:http/http.dart' as http;

class UploadCity extends StatefulWidget {
  const UploadCity({Key? key}) : super(key: key);

  @override
  State<UploadCity> createState() => _UploadCityState();
}

class _UploadCityState extends State<UploadCity>
    with SingleTickerProviderStateMixin {
  double _size = 250.0;
  PlatformFile? objFile = null;
  TempData resptemp = TempData();
  late CityBloc bloc;
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

    bloc.add(UploadCityFile(droppedFile));
  }

  void uploadSelectedFile() async {
    //---Create http package multipart request object
    // var stream = new http.ByteStream(objFile!.());
    // stream.cast();
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("http://192.168.0.130:9018/training/v1/uploadCity"),
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
    print(result);
  }

  late DropzoneViewController controller;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<CityBloc>(context);
    return BlocListener<CityBloc, CityState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is TemplateCitySuccess) {
          setState(() {
            resptemp = state.resp.data!;
            writeFileWeb(
                resptemp.base64Data.toString(), resptemp.fileName.toString());
          });
        }
        if (state is UploadCitySuccess) {
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
                            'Home / Master / City / Import',
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
                                    bloc.add(DownloadTemplateCity());
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
                                      Navigator.of(context).pushNamed('/city');
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
            )
          ],
        ),
      ),
    );
  }
}
