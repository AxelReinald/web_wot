import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/companybloc/bloc/company_bloc.dart';
import 'package:web_wot/common/dropdowncommon.dart';
import 'package:web_wot/common/headerscreen.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/companymodel.dart';
import 'package:web_wot/screen/menu.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormFieldState> _keycompany = GlobalKey<FormFieldState>();
  TextEditingController _Comcode = TextEditingController();
  TextEditingController _Comname = TextEditingController();
  TextEditingController _CompCode = TextEditingController();
  TextEditingController _CompName = TextEditingController();
  TextEditingController _Address = TextEditingController();
  RequestComAdd reqcomadd = RequestComAdd();
  RequestComDelete delreq = RequestComDelete();
  RequestSearchComp reqcom = RequestSearchComp();
  DowncomData down = DowncomData();
  double _size = 250.0;
  List<String> combus = [];
  List<String> comtype = [];
  List<String> comeditbus = [];
  List<String> comedittype = [];
  List<String> comeditcity = [];
  List<String> comcity = [];
  int? hal;
  int? total;
  List<String> businesslist = [];
  List<BusData> gbfield = [];
  List<TypeComData> tcfield = [];
  List<ComCityData> ccfield = [];
  //List<RespCompData> com = [];
  late CompanyBloc bloc;
  String? dropdownbus;
  RequestSearchComp comp = RequestSearchComp();
  bool isChecked = false;
  List<RespCompData> coms = [];
  String? dropdowntype;
  String? dropdowncity;
  String? dropdownbuss;
  DownlaodRequestComp reqdownload = DownlaodRequestComp();
  final _comadd = GlobalKey<FormState>();
  bool _large = true;
  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  void initState() {
    bloc = BlocProvider.of<CompanyBloc>(context);
    reqcom.pageNumber = 1;
    reqcom.pageSize = 10;
    reqcom.business = '';
    reqcom.companyCd = '';
    reqcom.companyName = '';

    coms.clear();
    bloc.add(SearchCom(reqcom));
    bloc.add(GetBusiness());
    bloc.add(GetTypeCom());
    bloc.add(GetCityCom());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyBloc, CompanyState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CompanyLoading) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CompanyError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  duration: const Duration(seconds: 5),
                  content: Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red),
            );
        }
        if (state is SearchComSuccess) {
          setState(() {
            coms.clear();
            coms = state.resp.data!;
            hal = coms.length;
            total = state.resp.countData;
          });
        }
        if (state is DeleteComSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text(
                    'Delete Success',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
          bloc.add(SearchCom(reqcom));
        }
        if (state is DownloadComSuccess) {
          setState(() {
            down = state.resp.data!;
            writeFileWeb(down.base64Data.toString(), down.fileName.toString());
          });
        }
        if (state is AddComSuccess) {
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
          bloc.add(SearchCom(reqcom));
        }
        if (state is EditComSuccess) {
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
          bloc.add(SearchCom(reqcom));
        }
        if (state is GetDataBusinessSuccess) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              combus.add(state.resp.data![i].paramCode.toString() +
                  " - " +
                  state.resp.data![i].companyBusiness.toString());
              BusData gb = new BusData();
              gb.paramCode = state.resp.data![i].paramCode.toString();
              gb.companyBusiness =
                  state.resp.data![i].companyBusiness.toString();
              gbfield.add(gb);
              comeditbus.add(state.resp.data![i].companyBusiness.toString());
            }
          });
        }
        if (state is GetDataTypeSuccess) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              comtype.add(state.resp.data![i].paramCode.toString() +
                  " - " +
                  state.resp.data![i].companyType.toString());
              TypeComData tc = new TypeComData();
              tc.paramCode = state.resp.data![i].paramCode.toString();
              tc.companyType = state.resp.data![i].companyType.toString();
              tcfield.add(tc);
              comedittype.add(state.resp.data![i].companyType.toString());
            }
          });
        }
        if (state is GetDataCitySuccess) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              comcity.add(state.resp.data![i].cityId.toString() +
                  " - " +
                  state.resp.data![i].cityName.toString());
              ComCityData cc = new ComCityData();
              cc.cityId = state.resp.data![i].cityId.toString();
              cc.cityName = state.resp.data![i].cityName.toString();
              ccfield.add(cc);
              comeditcity.add(state.resp.data![i].cityName.toString());
            }
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
                        Text(
                          'Company',
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
                  HeaderScreen(
                    text: 'Home / Master / Company',
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
                          height: 124,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: [
                                      DropdownCommon(
                                        keycompany: _keycompany,
                                        value: dropdownbus != ""
                                            ? dropdownbus
                                            : null,
                                        text: 'Business',
                                        onChanged: (val) {
                                          reqcom.business =
                                              val!.split(" - ")[0];
                                        },
                                        combus: combus,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Textbox(
                                        text: 'Company Code',
                                        controller: _Comcode,
                                        length: 15,
                                        onChanged: (val) {
                                          reqcom.companyCd = val;
                                        },
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Textbox(
                                        text: 'Company Name',
                                        controller: _Comname,
                                        length: 15,
                                        onChanged: (val) {
                                          reqcom.companyName = val;
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
                                            bloc.add(SearchCom(reqcom));
                                          },
                                          child: Text(
                                            'Search',
                                            style:
                                                TextStyle(color: Colors.white),
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
                                            dropdownbus = null;
                                            _keycompany.currentState!.reset();
                                            _Comcode.clear();
                                            reqcom.business = '';
                                            reqcom.companyCd = '';
                                            reqcom.companyName = '';
                                            comp.companyCd = '';
                                            comp.companyName = '';
                                            _Comname.clear();
                                            bloc.add(SearchCom(reqcom));
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          // width: 2000,
                          color: const Color(0xFFE7E7E7),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                //  controller: _tablescrolls,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 120,
                                          child: TextButton(
                                            onPressed: () {
                                              AddCompDialog();
                                            },
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
                                            onPressed: () {
                                              EditCompDialog();
                                            },
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
                                              DeleteComp();
                                            },
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
                                                  .pushNamed('/company/import');
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text('Import'),
                                              ],
                                            ),
                                            style: OutlinedButton.styleFrom(
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
                                              data: Theme.of(context).copyWith(
                                                cardColor: Colors.grey.shade600,
                                              ),
                                              child: PopupMenuButton(
                                                offset: Offset(-3, 40),
                                                tooltip: '',
                                                child: const Center(
                                                  child: Text(
                                                    'Download',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          reqdownload.business =
                                                              reqcom.business;
                                                          reqdownload
                                                                  .companyCd =
                                                              reqcom.companyCd;
                                                          reqdownload
                                                                  .companyName =
                                                              reqcom
                                                                  .companyName;
                                                          reqdownload
                                                                  .extention =
                                                              'csv';
                                                          bloc.add(
                                                              DownloadFileCom(
                                                                  reqdownload));
                                                        },
                                                      );
                                                    },
                                                    value: () {},
                                                    child: const Text(
                                                      'CSV',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          reqdownload.business =
                                                              reqcom.business;
                                                          reqdownload
                                                                  .companyCd =
                                                              reqcom.companyCd;
                                                          reqdownload
                                                                  .companyName =
                                                              reqcom
                                                                  .companyName;
                                                          reqdownload
                                                                  .extention =
                                                              'xls';
                                                          bloc.add(
                                                              DownloadFileCom(
                                                                  reqdownload));
                                                        },
                                                      );
                                                    },
                                                    value:
                                                        () {}, //_exportToExcel,
                                                    child: const Text(
                                                      'XLS',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          reqdownload.business =
                                                              reqcom.business;
                                                          reqdownload
                                                                  .companyCd =
                                                              reqcom.companyCd;
                                                          reqdownload
                                                                  .companyName =
                                                              reqcom
                                                                  .companyName;
                                                          reqdownload
                                                                  .extention =
                                                              'xlsx';
                                                          bloc.add(
                                                              DownloadFileCom(
                                                                  reqdownload));
                                                        },
                                                      );
                                                    },
                                                    value: () {},
                                                    child: const Text(
                                                      'XLSX',
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                                      checkColor: Colors.black,
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .resolveWith(
                                                                  getColor),
                                                      value: isChecked,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          var i = 0;
                                                          if (coms[i]
                                                                  .isChecked ==
                                                              false) {
                                                            isChecked = true;
                                                            for (i = 0;
                                                                i < coms.length;
                                                                i++)
                                                              coms[i].isChecked =
                                                                  true;
                                                          } else if (coms[i]
                                                                  .isChecked ==
                                                              true) {
                                                            isChecked = false;
                                                            for (i = 0;
                                                                i < coms.length;
                                                                i++)
                                                              coms[i].isChecked =
                                                                  false;
                                                          }
                                                        });
                                                      },
                                                      side: const BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Company Code',
                                                        style: const TextStyle(
                                                            color: Colors.black,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Company Name',
                                                        style: const TextStyle(
                                                            color: Colors.black,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Type',
                                                        style: const TextStyle(
                                                            color: Colors.black,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Business',
                                                        style: const TextStyle(
                                                            color: Colors.black,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Address',
                                                        style: const TextStyle(
                                                            color: Colors.black,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Created By',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Created Date',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Changed By',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: const Text(
                                                        'Changed Date',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                            if (coms.length > 0 ||
                                                coms.isNotEmpty)
                                              BlocBuilder<CompanyBloc,
                                                  CompanyState>(
                                                builder: (context, state) {
                                                  return Container(
                                                    //isi table
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
                                                      itemCount: coms.length,
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
                                                              child: Checkbox(
                                                                checkColor:
                                                                    Colors
                                                                        .black,
                                                                fillColor: MaterialStateProperty
                                                                    .resolveWith(
                                                                        getColor),
                                                                value: coms[
                                                                        index]
                                                                    .isChecked,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    coms[index]
                                                                            .isChecked =
                                                                        value!;
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
                                                              height: 50,
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
                                                                  coms[index]
                                                                      .companyCd
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
                                                              height: 50,
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
                                                                  coms[index]
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
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  coms[index]
                                                                      .type
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
                                                              height: 50,
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
                                                                  coms[index]
                                                                      .business
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
                                                              height: 50,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.15,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15),
                                                                child: Text(
                                                                  coms[index]
                                                                      .address
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
                                                              height: 50,
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
                                                                  coms[index]
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
                                                              height: 50,
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
                                                                  coms[index]
                                                                      .createdTime
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 50,
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
                                                                  coms[index]
                                                                      .updatedBy
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 50,
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
                                                                  coms[index]
                                                                      .updatedTime
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                    ),
                                                  );
                                                },
                                              )
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
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                              child: Row(
                                children: [
                                  Text(
                                    'Showing:',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    ('1 - ' + hal.toString() + ' of'),
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    (total.toString() + ' data'),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        comp.pageNumber = 1;
                                        comp.pageSize = 10;
                                        // cityreq.pageSize = 10;
                                        // cityreq.pageNumber = 0;
                                        // page = 1;
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
                                        comp.pageSize = 10;
                                        //  page--;
                                        // cityreq.pageSize = 10;
                                        //  reqset.pageNumber = page - 1;

                                        //  bloc.add(Search(reqset));
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
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.blue)),
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
                                          comp.pageSize = 10;
                                          // reqset.pageNumber = page;
                                          // page++;
                                          //  bloc.add(Search(reqset));
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
                                          comp.pageSize = 10;
                                          comp.pageNumber = 3;
                                          // page = 4;
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
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future AddCompDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Company - Add',
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
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 550,
                child: Form(
                  key: _comadd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Company Code',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _CompCode,
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
                      Text(
                        'Company Name',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _CompName,
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
                      Text(
                        'Company Type',
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
                            // key: _keysettinggroupadd,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 3.0,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            dropdownColor: Colors.white,
                            value: dropdowntype != "" ? dropdowntype : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: comtype.map((vals) {
                              return DropdownMenuItem(
                                child: Text(
                                  vals.split(" - ")[1],
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: vals,
                              );
                            }).toList(),
                            onChanged: (vals) {
                              reqcomadd.companyType = vals!.split(" - ")[0];
                              // reqset.settingGroup = dropdownValue;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Business',
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
                            // key: _keysettinggroupadd,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 3.0,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            dropdownColor: Colors.white,
                            value: dropdownbuss != "" ? dropdownbuss : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: combus.map((vale) {
                              return DropdownMenuItem(
                                child: Text(
                                  vale.split(" - ")[1],
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: vale,
                              );
                            }).toList(),
                            onChanged: (vale) {
                              reqcomadd.companyBusiness = vale!.split(" - ")[0];
                              // reqset.settingGroup = dropdownValue;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _Address,
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
                      Text(
                        'City',
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
                            // key: _keysettinggroupadd,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 3.0,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            dropdownColor: Colors.white,
                            value: dropdowncity != "" ? dropdowncity : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: comcity.map((values) {
                              return DropdownMenuItem(
                                child: Text(
                                  values.split(" - ")[1],
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: values,
                              );
                            }).toList(),
                            onChanged: (values) {
                              reqcomadd.cityCd = values!.split(" - ")[0];
                              // reqset.settingGroup = dropdownValue;
                            },
                          ),
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
                                  color: Colors.blue, width: 1), //<-- SEE HERE
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              if (_comadd.currentState!.validate()) {
                                setState(() {
                                  //reqcomadd.cityCd = dropdowncity;
                                  // reqcomadd.companyBusiness = dropdownbuss;
                                  // reqcomadd.companyType = dropdowntype;
                                  reqcomadd.companyCd = _CompCode.text;
                                  reqcomadd.companyName = _CompName.text;
                                  reqcomadd.address = _Address.text;
                                  print(reqcomadd.cityCd);
                                  print(reqcomadd.companyBusiness);
                                  print(reqcomadd.companyType);
                                  print(reqcomadd.companyCd);
                                  print(reqcomadd.companyName);
                                  bloc.add(AddCom(reqcomadd));
                                });
                                Navigator.pop(context);
                              }
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void EditCompDialog() {
    var check = [];
    var cCompType;
    var cCompBus;
    var cCompCity;

    for (int i = 0; i < coms.length; i++) {
      if (coms[i].isChecked == true) {
        cCompType = cekCompType(tcfield, coms[i].companyType!);
        cCompBus = cekCompBus(gbfield, coms[i].companyBusiness!);
        cCompCity = cekCompCity(ccfield, coms[i].cityId!);
        check.add(coms[i].companyCd.toString() +
            ";" +
            coms[i].companyName.toString() +
            ";" +
            cCompType.toString() +
            ";" +
            cCompBus.toString() +
            ";" +
            coms[i].address.toString() +
            ";" +
            cCompCity.toString());
      }
    }

    if (check.length == 1) {
      var splitted = check[0].toString().split(";");
      String ComCd = splitted[0];
      String ComName = splitted[1];
      String ComType = splitted[2];
      String ComBus = splitted[3];
      String ComAdd = splitted[4];
      String ComCity = splitted[5];
      EditComps(ComCd, ComName, ComType, ComBus, ComAdd, ComCity);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 5),
              content: Text(
                'Pilih Satu Data!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red),
        );
    }
  }

  String? cekCompType(List<TypeComData> comps, String paramCd) {
    String result;
    for (int i = 0; i < comps.length; i++) {
      if (comps[i].paramCode == paramCd) {
        result = comps[i].companyType.toString();
        return result;
      } else {
        continue;
      }
    }
    return null;
  }

  String? cekCompBus(List<BusData> comps, String paramCd) {
    String result;
    for (int i = 0; i < comps.length; i++) {
      if (comps[i].paramCode == paramCd) {
        result = comps[i].companyBusiness.toString();
        return result;
      } else {
        continue;
      }
    }
    return null;
  }

  String? cekCompCity(List<ComCityData> comps, String paramCd) {
    String result;
    for (int i = 0; i < comps.length; i++) {
      if (comps[i].cityId == paramCd) {
        result = comps[i].cityName.toString();
        return result;
      } else {
        continue;
      }
    }
    return null;
  }

  Future EditComps(String? comcd, String? comname, String? comtypes,
          String? combuss, String? comadd, String? comcitys) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Company - Edit',
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
              //controller: _edittable,
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Company Code',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      // controller: _CompCode,
                      readOnly: true,
                      initialValue: comcd,
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
                    Text(
                      'Company Name',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      // controller: _CompName,
                      initialValue: comname,
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
                      onChanged: (value) {
                        reqcomadd.companyName = value;
                        comname = reqcomadd.companyName;
                      },
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
                    Text(
                      'Company Type',
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
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          // key: _keysettinggroupadd,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 3.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          dropdownColor: Colors.white,
                          value: comtypes,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: comedittype.map((vals) {
                            return DropdownMenuItem(
                              child: Text(
                                vals, //.split(" - ")[1],
                                style: TextStyle(color: Colors.black),
                              ),
                              value: vals,
                            );
                          }).toList(),
                          onChanged: (vals) {
                            comtypes = vals;
                            // reqcomadd.companyType = vals!.split(" - ")[0];
                            // comtypes = reqcomadd.companyType;
                            // reqset.settingGroup = dropdownValue;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Business',
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
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          // key: _keysettinggroupadd,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 3.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          dropdownColor: Colors.white,
                          value: combuss,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: comeditbus.map((vale) {
                            return DropdownMenuItem(
                              child: Text(
                                vale, //.split(" - ")[1],
                                style: TextStyle(color: Colors.black),
                              ),
                              value: vale,
                            );
                          }).toList(),
                          onChanged: (vale) {
                            combuss = vale;
                            // reqcomadd.companyBusiness = vale!.split(" - ")[0];
                            // combuss = reqcomadd.companyBusiness;
                            // reqset.settingGroup = dropdownValue;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Address',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      // controller: _Address,
                      initialValue: comadd,
                      maxLength: 40,
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
                      onChanged: (value) {
                        comadd = value;
                      },
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
                    Text(
                      'City',
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
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          // key: _keysettinggroupadd,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 3.0,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          dropdownColor: Colors.white,
                          value: comcitys,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: comeditcity.map((values) {
                            return DropdownMenuItem(
                              child: Text(
                                values, //.split(" - ")[1],
                                style: TextStyle(color: Colors.black),
                              ),
                              value: values,
                            );
                          }).toList(),
                          onChanged: (values) {
                            comcitys = values;
                            // reqcomadd.cityCd = values!.split(" - ")[0];
                            // comcitys = reqcomadd.cityCd;
                            // reqset.settingGroup = dropdownValue;
                          },
                        ),
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
                                color: Colors.blue, width: 1), //<-- SEE HERE
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            // if (_comadd.currentState!.validate()) {
                            setState(() {
                              for (int i = 0; i < tcfield.length; i++) {
                                if (comtypes == tcfield[i].companyType) {
                                  comtypes = tcfield[i].paramCode.toString();
                                }
                              }
                              for (int i = 0; i < ccfield.length; i++) {
                                if (comcitys == ccfield[i].cityName) {
                                  comcitys = ccfield[i].cityId.toString();
                                }
                              }

                              for (int i = 0; i < gbfield.length; i++) {
                                if (combuss == gbfield[i].companyBusiness) {
                                  combuss = gbfield[i].paramCode.toString();
                                }
                              }
                              reqcomadd.companyType = comtypes;
                              reqcomadd.companyBusiness = combuss;
                              reqcomadd.cityCd = comcitys;
                              reqcomadd.companyCd = comcd;
                              reqcomadd.companyName = comname;
                              reqcomadd.address = comadd;
                              bloc.add(EditCom(reqcomadd));
                              print("masuk edit");
                            });
                            Navigator.pop(context);
                            // }
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void DeleteComp() {
    var check = [];
    delreq.listCode = [];

    for (int i = 0; i < coms.length; i++) {
      if (coms[i].isChecked == true) {
        check.add(coms[i].companyCd.toString());
      }
    }

    if (check.length < 1) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 5),
              content: Text(
                'Pilih minimal 1 data untuk dihapus',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red),
        );
      return null;
    } else if (check.length >= 1) {
      for (var element in coms) {
        if (element.isChecked == true) {
          delreq.listCode!.add(DelListCode(code: element.companyCd));
        }
      }
      bloc.add(DeleteCom(delreq));
    }
  }
}
