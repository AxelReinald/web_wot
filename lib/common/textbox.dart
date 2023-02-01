import 'package:flutter/material.dart';
import 'package:web_wot/model/parametermodel.dart';

class Textbox extends StatefulWidget {
  final String text;
  final int? length;
  final Function(String?)? onChanged, onAction;

  const Textbox({
    Key? key,
    // required TextEditingController ParameterCd,
    required this.text,
    this.onChanged,
    this.onAction,
    this.controller,
    this.length,
    // required this.req,
  }) : super(key: key);

  final TextEditingController? controller;
  // final RequestParameterSearch req;

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.text, //'Parameter Code',
          style: const TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 55,
          width: 250,
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              // labelText: "Enter Email",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(width: 1.0, color: Colors.grey.shade400),
              ),
            ),
            maxLength: widget.length,
            style: const TextStyle(color: Colors.black),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
