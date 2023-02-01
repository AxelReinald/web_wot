import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web_wot/model/supportpicmodel.dart';
import 'package:flutter/material.dart';

class PICFormItem extends StatefulWidget {
  final bool isLast;
  final AddPIC model;
  final Function(String?) onNameChanged, onPhoneChanged, onEmailChanged;
  final Function(bool?) onCheckedChanged;
  const PICFormItem(
      {required this.isLast,
      required this.model,
      required this.onCheckedChanged,
      required this.onEmailChanged,
      required this.onNameChanged,
      required this.onPhoneChanged,
      Key? key})
      : super(key: key);

  @override
  State<PICFormItem> createState() => _PICFormItemState();
}

class _PICFormItemState extends State<PICFormItem> {
  late TextEditingController dtlEmail;
  late TextEditingController dtlName;
  late TextEditingController dtlPhone;

  @override
  void initState() {
    // TODO: implement initState
    dtlEmail = TextEditingController(text: widget.model.email);
    dtlName = TextEditingController(text: widget.model.name);
    dtlPhone = TextEditingController(text: widget.model.mobileNo);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PICFormItem oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        dtlEmail.value = dtlEmail.value.copyWith(text: widget.model.email);
        dtlName.value = dtlName.value.copyWith(text: widget.model.name);
        dtlPhone.value = dtlPhone.value.copyWith(text: widget.model.mobileNo);
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
                    hintText: "Name"),
                style: TextStyle(color: Colors.black),
                // hint: "",
                controller: dtlName,
                onChanged: (val) {
                  widget.onNameChanged(val);
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
                    hintText: "Phone No"),
                style: TextStyle(color: Colors.black),
                controller: dtlPhone,
                onChanged: (val) {
                  widget.onPhoneChanged(val);
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
                    hintText: "Email"),
                style: TextStyle(color: Colors.black),
                // hint: "Description",
                controller: dtlEmail,
                onChanged: (val) {
                  widget.onEmailChanged(val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
