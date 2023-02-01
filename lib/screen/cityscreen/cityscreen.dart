import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/Theme/colorcheckbox.dart';
import 'package:web_wot/Theme/colors.dart';
import 'package:web_wot/bloc/citybloc/bloc/city_bloc.dart';
import 'package:web_wot/common/textbox.dart';
import 'package:web_wot/helper/custom_scroll.dart';
import 'package:web_wot/helper/menu_common.dart';
import 'package:web_wot/helper/nav_base.dart';
import 'package:web_wot/model/citymodel.dart';
import 'package:web_wot/screen/menu.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormFieldState> _keycity = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _addkeycity = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _keyeditcity = GlobalKey<FormFieldState>();
  List<GetProData> procity = [];

  double _size = 250.0;
  late CityBloc bloc;
  List<String> options = [];
  List<CityData> city = [];
  List<String> provincelist = [];
  List<String> provincelists = [];
  // List<String> provinceedit = [];
  List<String> provincecd = [];
  DownCityData downloaddoc = DownCityData();
  int? hal;
  int? total;
  String? dropdownValue;
  String? dropdownAdd;
  String? dropdownValues;
  bool _large = true;
  TextEditingController _Citycode = TextEditingController();
  TextEditingController _Addcitycode = TextEditingController();
  TextEditingController _Addcityname = TextEditingController();
  TextEditingController _Cityname = TextEditingController();
  RequestDeleteCity delreqpro = RequestDeleteCity();
  DownloadRequestCity reqdown = DownloadRequestCity();
  RequestCitySearch cityreq = new RequestCitySearch();
  TempData tempdata = TempData();
  RequestAddCity addpro = new RequestAddCity();
  final ScrollController _edittable = ScrollController();
  bool isChecked = false;
  final _addcityKey = GlobalKey<FormState>();

  @override
  void initState() {
    bloc = BlocProvider.of<CityBloc>(context);
    cityreq.pageSize = 10;
    cityreq.pageNumber = 1;
    cityreq.provinceId = '';
    cityreq.cityCd = '';
    cityreq.cityName = '';
    city.clear();
    bloc.add(SearchCity(cityreq));
    bloc.add(GetProvince());
    // TODO: implement initState
    super.initState();
  }

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<CityBloc>(context);
    return BlocListener<CityBloc, CityState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CityError) {
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
        if (state is GetProvinceList) {
          setState(() {
            for (int i = 0; i < state.resp.data!.length; i++) {
              provincelist.add(state.resp.data![i].provinceId.toString() +
                  " - " +
                  state.resp.data![i].provinceName.toString());

              GetProData getProData = new GetProData();
              getProData.provinceId = state.resp.data![i].provinceId.toString();
              getProData.provinceName =
                  state.resp.data![i].provinceName.toString();
              procity.add(getProData);

              provincelists.add(state.resp.data![i].provinceName.toString());
            }
          });
        }
        if (state is SearchSuccess) {
          setState(() {
            city.clear();
            city = state.resp.data!;
            hal = city.length;
            total = state.resp.countData;
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
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green),
            );
          bloc.add(SearchCity(cityreq));
        }
        if (state is EditCitySuccess) {
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
          bloc.add(SearchCity(cityreq));
        }
        if (state is DeleteSuccess) {
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
          bloc.add(SearchCity(cityreq));
        }
        if (state is DownloadCitySuccess) {
          setState(() {
            downloaddoc = state.resp.data!;
            writeFileWeb(downloaddoc.base64Data.toString(),
                downloaddoc.fileName.toString());
          });
        }
        if (state is TemplateCitySuccess) {
          setState(() {
            tempdata = state.resp.data!;
            writeFileWeb(
                tempdata.base64Data.toString(), tempdata.fileName.toString());
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
                          'City',
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
                            'Home / Master / City',
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
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
                                              'Province',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: 250,
                                              height: 35,
                                              margin:
                                                  EdgeInsets.only(bottom: 17),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade400),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  key: _keycity,
                                                  decoration:
                                                      const InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4)),
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 3.0,
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  value: dropdownValue != ""
                                                      ? dropdownValue
                                                      : null,
                                                  isExpanded: true,
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black),
                                                  items:
                                                      provincelist.map((val) {
                                                    return DropdownMenuItem(
                                                      child: Text(
                                                        val.split(" - ")[1],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      value: val,
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    cityreq.provinceId =
                                                        val!.split(" - ")[0];
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
                                          text: 'City Code',
                                          controller: _Citycode,
                                          length: 15,
                                          onChanged: (val) {
                                            cityreq.cityCd = val;
                                          },
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Textbox(
                                          text: 'City Name',
                                          controller: _Cityname,
                                          length: 15,
                                          onChanged: (val) {
                                            cityreq.cityName = val;
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
                                              bloc.add(SearchCity(cityreq));
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
                                              _keycity.currentState!.reset();
                                              _Citycode.clear();
                                              cityreq.provinceId = '';
                                              cityreq.cityName = '';
                                              cityreq.cityCd = '';
                                              _Cityname.clear();
                                              bloc.add(SearchCity(cityreq));
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
                            height: MediaQuery.of(context).size.height * 0.6,
                            // width: 2000,
                            color: const Color(0xFFE7E7E7),
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 0),
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
                                                AddCityDialog();
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
                                                EditCityDialog();
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
                                                DeleteCitys();
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
                                                print('masukimportcity');
                                                Navigator.of(context)
                                                    .pushNamed('/city/import');
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
                                                data:
                                                    Theme.of(context).copyWith(
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
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          [
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            reqdown.provinceCd =
                                                                cityreq
                                                                    .provinceId;
                                                            reqdown.cityCd =
                                                                _Citycode.text;
                                                            reqdown.cityName =
                                                                _Cityname.text;
                                                            reqdown.extention =
                                                                'csv';
                                                            bloc.add(
                                                                DownloadFileCity(
                                                                    reqdown));

                                                            // downreq.settingGroup =
                                                            //     reqset
                                                            //         .settingGroup;
                                                            // downreq.settingName =
                                                            //     _Settingcode.text;
                                                            // downreq.value =
                                                            //     _Value.text;
                                                            // downreq.extention =
                                                            //     'csv';
                                                            // bloc.add(DownloadFile(
                                                            //     downreq));
                                                          },
                                                        );
                                                      },
                                                      value: () {},
                                                      child: const Text(
                                                        'CSV',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            reqdown.provinceCd =
                                                                cityreq
                                                                    .provinceId;
                                                            reqdown.cityCd =
                                                                _Citycode.text;
                                                            reqdown.cityName =
                                                                _Cityname.text;
                                                            reqdown.extention =
                                                                'xls';
                                                            bloc.add(
                                                                DownloadFileCity(
                                                                    reqdown));
                                                          },
                                                        );
                                                      },
                                                      value:
                                                          () {}, //_exportToExcel,
                                                      child: const Text(
                                                        'XLS',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            reqdown.provinceCd =
                                                                cityreq
                                                                    .provinceId;
                                                            reqdown.cityCd =
                                                                _Citycode.text;
                                                            reqdown.cityName =
                                                                _Cityname.text;
                                                            reqdown.extention =
                                                                'xlsx';
                                                            bloc.add(
                                                                DownloadFileCity(
                                                                    reqdown));
                                                          },
                                                        );
                                                      },
                                                      value: () {},
                                                      child: const Text(
                                                        'XLSX',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                        checkColor:
                                                            Colors.black,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    getColor),
                                                        value: isChecked,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            var i = 0;
                                                            if (city[i]
                                                                    .isChecked ==
                                                                false) {
                                                              isChecked = true;
                                                              for (i = 0;
                                                                  i <
                                                                      city
                                                                          .length;
                                                                  i++)
                                                                city[i].isChecked =
                                                                    true;
                                                            } else if (city[i]
                                                                    .isChecked ==
                                                                true) {
                                                              isChecked = false;
                                                              for (i = 0;
                                                                  i <
                                                                      city
                                                                          .length;
                                                                  i++)
                                                                city[i].isChecked =
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Province',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'City Code',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'City Name',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Created By',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Created Date',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Changed By',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 15),
                                                        child: const Text(
                                                          'Changed Date',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                              if (city.length > 0 ||
                                                  city.isNotEmpty)
                                                BlocBuilder<CityBloc,
                                                    CityState>(
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
                                                        itemCount: city.length,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Column(
                                                                    children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.03,
                                                                    child:
                                                                        Checkbox(
                                                                      checkColor:
                                                                          Colors
                                                                              .black,
                                                                      fillColor:
                                                                          MaterialStateProperty.resolveWith(
                                                                              getColor),
                                                                      value: city[
                                                                              index]
                                                                          .isChecked,
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          city[index].isChecked =
                                                                              value!;
                                                                        });
                                                                      },
                                                                      side: const BorderSide(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        city[index]
                                                                            .provinceCode
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        city[index]
                                                                            .cityCd
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        city[index]
                                                                            .cityName
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        city[index]
                                                                            .createdBy
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        city[index]
                                                                            .createdTime
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        city[index]
                                                                            .updatedBy
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.10,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        city[index]
                                                                            .updatedTime
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 5, 16, 5),
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
                                          cityreq.pageSize = 10;
                                          cityreq.pageNumber = 0;
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
                                          //  page--;
                                          cityreq.pageSize = 10;
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: Colors.blue)),
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
                                            cityreq.pageSize = 10;
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
                                          cityreq.pageSize = 10;
                                          cityreq.pageNumber = 3;
                                          // page = 4;
                                          // bloc.add(Search(reqset));
                                        });
                                      },
                                      icon: Icon(
                                        Icons.keyboard_double_arrow_right,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
      ),
    );
  }

  Future AddCityDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'City - Add',
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
                  key: _addcityKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Province',
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
                            key: _addkeycity,
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
                            value: dropdownAdd != "" ? dropdownAdd : null,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            items: provincelist.map((vals) {
                              return DropdownMenuItem(
                                child: Text(
                                  vals.split(" - ")[1],
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: vals,
                              );
                            }).toList(),
                            onChanged: (vals) {
                              //  provincelist.
                              // dropdownValue = val;
                              dropdownAdd = vals!.split(" - ")[0];

                              // bloc.add(Search(reqset));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'City Code',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _Addcitycode,
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
                        'City Name',
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _Addcityname,
                        maxLines: 5, // <-- SEE HERE
                        minLines: 1,
                        maxLength: 150,
                        // maxLength: 150,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
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
                              if (_addcityKey.currentState!.validate()) {
                                setState(() {
                                  addpro.cityCd = _Addcitycode.text;
                                  addpro.cityName = _Addcityname.text;
                                  addpro.provinceId = dropdownAdd;

                                  // addsetting.settingDesc =
                                  //     _SettingDescription.text;
                                  // addsetting.settingCode = _SettingCode.text;
                                  // addsetting.settingValue = _SettingValue.text;
                                  // addsetting.settingGroupCode = dropdownValues;
                                  // addsetting.settingValueType =
                                  //     dropdownValuetype;
                                  bloc.add(AddCity(addpro));
                                  //bloc.add(Add(addset));
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

  void EditCityDialog() {
    var check = [];
    var cProvinceId;
    var cProvinceName;

    for (int i = 0; i < city.length; i++) {
      if (city[i].isChecked == true) {
        cProvinceName = cekProvinceName(procity, city[i].provinceId!);

        // print(cProvinceId);
        check.add(city[i].provinceId.toString() +
            ";" +
            city[i].cityCd.toString() +
            ";" +
            cProvinceName.toString() +
            ";" +
            city[i].cityName.toString());
      }
    }
    if (check.length == 1) {
      var splitted = check[0].toString().split(";");
      String ProId = splitted[0];
      String Citycode = splitted[1];
      String Pronames = splitted[2];
      String Citynames = splitted[3];
      print(Pronames);
      EditCitys(ProId, Citycode, Pronames, Citynames);
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

  Future EditCitys(String? proids, String? citycodes, String? proname,
          String? citynames) =>
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
                    'City - Edit',
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
              controller: _edittable,
              scrollDirection: Axis.vertical,
              child: Container(
                height: 600,
                width: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Province',
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
                          key: _keyeditcity,
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
                          value: proname, //!= "" ? proname : null,
                          // dropdownValues != "" ? dropdownValues : null,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          items: provincelists.map((val) {
                            return DropdownMenuItem(
                              child: Text(
                                val, //.split(" - ")[0],
                                style: TextStyle(color: Colors.black),
                              ),
                              value: val,
                            );
                          }).toList(),
                          onChanged: (val) {
                            proname = val;
                            // for (int i = 0; i < procity.length; i++) {
                            //   if (proids == procity[i].provinceId.toString()) {
                            //     val = proids;
                            //     proname = val;
                            //   }
                            // }
                            //!.split(" - ")[0];
                            print(proname! + "1");
                            // reqset.settingGroup = dropdownValue;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'City Code',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        child: TextFormField(
                          initialValue: citycodes,
                          readOnly: true,
                          cursorColor: Colors.grey,
                          // controller: _SettingCode,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey,
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
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'City Name',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      initialValue: citynames,
                      // controller: _SettingDescription,
                      maxLines: 5, // <-- SEE HERE
                      minLines: 1,
                      maxLength: 150,
                      // maxLength: 150,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                        addpro.cityName = value;
                        citynames = addpro.cityName;
                      },
                    ),
                    const SizedBox(
                      height: 10,
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
                            for (int i = 0; i < procity.length; i++) {
                              if (proname == procity[i].provinceName) {
                                print(proname! + "2");
                                proname = procity[i].provinceId.toString();
                              }
                            }

                            addpro.provinceId = proname;
                            addpro.cityCd = citycodes;
                            addpro.cityName = citynames;
                            bloc.add(EditCity(addpro));
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void DeleteCitys() {
    var check = [];
    delreqpro.listCode = [];

    for (int i = 0; i < city.length; i++) {
      if (city[i].isChecked == true) {
        check.add(city[i].cityCd.toString());
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
      for (var element in city) {
        if (element.isChecked == true) {
          delreqpro.listCode!.add(DelCityListCode(code: element.cityCd));
        }
      }
      bloc.add(DeleteCity(delreqpro));
    }
  }

  String? cekProvinceName(List<GetProData> procity, String provinceId) {
    String result;
    for (int i = 0; i < procity.length; i++) {
      if (procity[i].provinceId == provinceId) {
        result = procity[i].provinceName.toString();
        return result;
      } else {
        continue;
      }
    }
    return null;
  }
}
