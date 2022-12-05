import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/settingbloc/setting_group_bloc.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/model/setting_group.dart';
import 'package:web_wot/screen/menu.dart';
import 'package:bloc/bloc.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  requestSetting reqset = new requestSetting();
  //late final requestSetting reqset;
  late SettingGroupBloc bloc;
  double _size = 250.0;

  bool _large = true;

  bool value = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  List<responseSetting> arraysetting = [];

  static const _birulangit = 0xFFF7FAFC;

  final ScrollController _scrollgrid = ScrollController();
  final ScrollController _mainscroll = ScrollController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SettingGroupBloc>(context);

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return BlocListener<SettingGroupBloc, SettingGroupState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SettingError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                duration: const Duration(seconds: 5),
                content: Text(
                  state.error,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red));
        }
        if (state is SettingSuccess) {
          arraysetting.clear();
          arraysetting.addAll(state.respset);
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
                        FlatButton(
                          child: const Text(
                            'Dashboard',
                            style: TextStyle(color: Colors.black87),
                          ),
                          onPressed: () {},
                        ),
                        const Spacer(),
                        Row(
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
                            'Home / Admin / Dashboard',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      controller: _mainscroll,
                      children: [
                        Container(
                          height: 124,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Setting Group Code',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 55,
                                        width: 250,
                                        child: TextFormField(
                                          decoration: new InputDecoration(
                                            // labelText: "Enter Email",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),
                                          maxLength: 12,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          onChanged: (value) {
                                            reqset.groupCd = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Setting Group Name',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 55,
                                        width: 250,
                                        child: TextFormField(
                                          decoration: new InputDecoration(
                                            // labelText: "Enter Email",
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.grey.shade400),
                                            ),
                                          ),
                                          maxLength: 12,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          onChanged: (value) {
                                            reqset.groupName = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: TextButton(
                                      onPressed: () {
                                        bloc.add(Search(reqset));
                                      },
                                      child: const Text(
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
                                      onPressed: () {},
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
                          height: 472,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: TextButton(
                                          onPressed: () {},
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
                                          onPressed: () {},
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
                                                width: 1.0, color: Colors.blue),
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
                                          onPressed: () {},
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
                                                width: 1.0, color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Import'),
                                            ],
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 1.0, color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Download',
                                                style: TextStyle(
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
                                            color: Color(_birulangit),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
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
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChecked =
                                                              !isChecked;
                                                        });
                                                      },
                                                      side: const BorderSide(
                                                          color: Colors.grey)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10,
                                                  height: 50,
                                                  child: const Center(
                                                    child: const Text(
                                                      'Setting Group Code',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10,
                                                  height: 50,
                                                  child: const Center(
                                                    child: const Text(
                                                      'Setting Group Name',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10,
                                                  height: 50,
                                                  child: const Center(
                                                    child: const Text(
                                                      'Description',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10,
                                                  height: 50,
                                                  child: const Center(
                                                    child: Text(
                                                      'Created By',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10,
                                                  height: 50,
                                                  child: const Center(
                                                    child: Text(
                                                      'Created Date',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10,
                                                  height: 50,
                                                  child: const Center(
                                                    child: const Text(
                                                      'Change By',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10,
                                                  height: 50,
                                                  child: const Center(
                                                    child: const Text(
                                                      'Change Date',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          arraysetting.length > 0 ||
                                                  arraysetting.isNotEmpty
                                              ? Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ListView.builder(
                                                    itemCount: 10,
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
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                            child: Text(arraysetting[
                                                                    index]
                                                                .settingGroupCode
                                                                .toString()),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                                  ),
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text('No Data Found'),
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
                        Container(
                          //Paging
                          height: 80,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                              child: Row(
                                children: const [
                                  Text(
                                    'Showing',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
