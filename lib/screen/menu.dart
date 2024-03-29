// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LeftDrawer extends StatefulWidget {
  LeftDrawer({
    // required Key key,
    required this.size,
  }) : super();

  final double size;

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> with TickerProviderStateMixin {
  static const _birulangit = 0xFFF7FAFC;
  double _height3 = 0;
  double _width3 = 320.0;
  double _height2 = 0;
  double _width2 = 320.0;
  double _height = 0;
  double _width = 320.0;
  bool _resized = false;
  bool _resized2 = false;
  bool _resized3 = false;
  bool menuClicked = true;
  bool menuClicked2 = true;
  bool menuClicked3 = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      // height: MediaQuery.of(context).size.height,
      color: Colors.white, //const Color(0xFF2C3C56),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            color: Colors.white, //Color(0xFF223047),
            child: const Image(
              image: AssetImage('images/logo.jpeg'),
            ),
          ),
          Column(
            children: [
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                vsync: this,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(_birulangit)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: _width,
                        height: 40,
                        child: Column(children: [
                          GestureDetector(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'User Access',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  menuClicked
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (_resized) {
                                  _resized = false;
                                  _height = 0;
                                  _width = 320.0;
                                  menuClicked = true;
                                } else {
                                  _resized = true;
                                  _height = 40.0;
                                  _width = 320.0;
                                  menuClicked = false;
                                }
                              });
                            },
                          ),
                        ]),
                      ),
                    ),
                    InkWell(
                      child: Ink(
                        height: _height,
                        width: _width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Menu',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/menuscreen');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height,
                        width: _width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Role',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/role');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height,
                        width: _width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'User',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/user');
                      },
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                vsync: this,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(_birulangit),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: _width2,
                        height: 40,
                        child: Column(children: [
                          GestureDetector(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Master',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  menuClicked2
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (_resized2) {
                                  _resized2 = false;
                                  _height2 = 0;
                                  _width2 = 320.0;
                                  menuClicked2 = true;
                                } else {
                                  _resized2 = true;

                                  _height2 = 40.0;
                                  _width2 = 320.0;
                                  menuClicked2 = false;
                                }
                              });
                            },
                          ),
                        ]),
                      ),
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(Icons.keyboard_arrow_right,
                                  color: Colors.black),
                              SizedBox(width: 10),
                              Text(
                                'Setting Group',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/settinggroup');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Setting',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/setting');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Parameter',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/parameter');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Province',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/province');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'City',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/city');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Company',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/company');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Supported Object',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/supportedobject');
                      },
                    ),
                    InkWell(
                      child: Ink(
                        height: _height2,
                        width: _width2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Supported PIC',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/supportpic');
                      },
                    ),
                  ],
                ),
              ),
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                vsync: this,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(_birulangit),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: _width3,
                        height: 40,
                        child: Column(children: [
                          GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Ticket',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  menuClicked3
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (_resized3) {
                                  _resized3 = false;

                                  _height3 = 0;
                                  _width3 = 320.0;
                                  menuClicked3 = true;
                                } else {
                                  _resized3 = true;

                                  _height3 = 40.0;
                                  _width3 = 320.0;
                                  menuClicked3 = false;
                                }
                              });
                            },
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      height: _height3,
                      width: _width3,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: const [
                            Icon(Icons.keyboard_arrow_right,
                                color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              'Request',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: _height3,
                      width: _width3,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Verification',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: _height3,
                      width: _width3,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: const [
                            Icon(Icons.keyboard_arrow_right,
                                color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              'Process',
                              style: TextStyle(color: Colors.black),
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
          Container(
            //pemisah paling bawah
            height: 100,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
