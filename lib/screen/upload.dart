import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_wot/screen/menu.dart';

class Import extends StatefulWidget {
  const Import({Key? key}) : super(key: key);

  @override
  State<Import> createState() => _ImportState();
}

class _ImportState extends State<Import> with SingleTickerProviderStateMixin {
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
    return Scaffold(
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
                              icon:
                                  const Icon(Icons.notifications_none_outlined),
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
                            child: DottedBorder(
                              radius: Radius.circular(15),
                              strokeWidth: 1,
                              color: Colors.grey,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Drag and drop or Browse your file here\n Allowed file formats: xlsx',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Row(children: [
                              TextButton(
                                onPressed: () {},
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
                                  onPressed: () {}, child: Text('Submit')),
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
    );
  }
}
