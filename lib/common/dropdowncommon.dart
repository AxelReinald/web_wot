import 'package:flutter/material.dart';

class DropdownCommon extends StatefulWidget {
  final String text;
  final String? value;
  final Function(String?)? onChanged;
  DropdownCommon({
    Key? key,
    required GlobalKey<FormFieldState> keycompany,
    required this.text,
    required this.value,
    required this.combus,
    this.onChanged,
  })  : _keycompany = keycompany,
        super(key: key);

  final GlobalKey<FormFieldState> _keycompany;
  final List<String> combus;

  @override
  State<DropdownCommon> createState() => _DropdownCommonState();
}

class _DropdownCommonState extends State<DropdownCommon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.text,
          style: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 250,
          height: 35,
          margin: EdgeInsets.only(bottom: 17),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              key: widget._keycompany,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 3.0,
                ),
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.white,
              value: widget.value,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              items: widget.combus.map((val) {
                return DropdownMenuItem(
                  child: Text(
                    val.split(" - ")[1],
                    style: TextStyle(color: Colors.black),
                  ),
                  value: val,
                );
              }).toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
