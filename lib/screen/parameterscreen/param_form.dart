// import 'package:example_fe/helper/app_scale.dart';
// import 'package:example_fe/model/dummy_param.dart';
// import 'package:example_fe/shared_widgets.dart/custom_textfield.dart';
// import 'package:example_fe/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:web_wot/model/parametermodel.dart';

class ParamFormItem extends StatefulWidget {
  final bool isLast;
  final AddDtl model;
  final Function(String?) onCodeChanged, onNameChanged, onDescChanged;
  final Function(bool?) onCheckedChanged;
  const ParamFormItem({
    required this.model,
    required this.isLast,
    required this.onCheckedChanged,
    required this.onCodeChanged,
    required this.onNameChanged,
    required this.onDescChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<ParamFormItem> createState() => _ParamFormItemState();
}

class _ParamFormItemState extends State<ParamFormItem> {
  late TextEditingController dtlCodeCo;
  late TextEditingController dtlNameCo;
  late TextEditingController dtlDescCo;
  @override
  void initState() {
    dtlCodeCo = TextEditingController(text: widget.model.detailCd);
    dtlNameCo = TextEditingController(text: widget.model.detailName);
    dtlDescCo = TextEditingController(text: widget.model.detailDesc);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ParamFormItem oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        dtlCodeCo.value = dtlCodeCo.value.copyWith(text: widget.model.detailCd);
        dtlNameCo.value =
            dtlNameCo.value.copyWith(text: widget.model.detailName);
        dtlDescCo.value =
            dtlDescCo.value.copyWith(text: widget.model.detailDesc);
      });
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: 22,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.isLast ? Colors.transparent : Colors.white,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //!
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: SizedBox(
              height: 50,
              width: 50,
              child: Checkbox(
                value: widget.model.isChecked ?? false,
                tristate: false,
                side: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                splashRadius: 1,
                onChanged: (val) {
                  widget.onCheckedChanged(val);
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10),
                        borderSide: new BorderSide()),
                    hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                    contentPadding: EdgeInsets.only(
                        left: 5, bottom: 11, top: 11, right: 15),
                    hintText: "Parameter Detail Code"),
                style: TextStyle(color: Colors.black),
                // hint: "",
                controller: dtlCodeCo,
                onChanged: (val) {
                  widget.onCodeChanged(val);
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10),
                        borderSide: new BorderSide()),
                    hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                    contentPadding: EdgeInsets.only(
                        left: 5, bottom: 11, top: 11, right: 15),
                    hintText: "Parameter Detail Name"),
                style: TextStyle(color: Colors.black),
                controller: dtlNameCo,
                onChanged: (val) {
                  widget.onNameChanged(val);
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10),
                        borderSide: new BorderSide()),
                    hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                    contentPadding: EdgeInsets.only(
                        left: 5, bottom: 11, top: 11, right: 15),
                    hintText: "Description"),
                style: TextStyle(color: Colors.black),
                // hint: "Description",
                controller: dtlDescCo,
                onChanged: (val) {
                  widget.onDescChanged(val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
