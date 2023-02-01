import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:web_wot/common/keyval.dart';
import 'package:web_wot/model/supportpicmodel.dart';
import 'package:web_wot/service/restapi.dart';

class CustomDropdownEmail extends StatefulWidget {
  final List<String>? items;
  final List<KeyVal>? itemsKey;
  final SuggestionsBoxController? boxController;
  final String? hint, label;
  final String? Function(String?)? validator, onChanged, onAction;
  final Function(AutoData)? onSubmit;
  final Function()? onTap, itemSubmitted;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? readOnly, enabled, isExpanded;
  final int? maxLine, maxLength;

  const CustomDropdownEmail(
      {Key? key,
      this.onSubmit,
      this.itemsKey,
      this.isExpanded,
      this.boxController,
      this.itemSubmitted,
      this.items,
      this.hint,
      this.label,
      this.validator,
      this.onChanged,
      this.onAction,
      this.inputType,
      this.inputAction,
      this.focusNode,
      this.readOnly,
      this.onTap,
      this.controller,
      this.enabled,
      this.maxLine,
      this.maxLength})
      : super(key: key);
  @override
  _CustomDropdownEmailState createState() => _CustomDropdownEmailState();
}

class _CustomDropdownEmailState extends State<CustomDropdownEmail> {
  SuggestionsBoxController controller = new SuggestionsBoxController();
  RestApi api = new RestApi();
  bool expanded = false;

  @override
  Widget build(context) {
    return TypeAheadFormField(
      suggestionsBoxController: controller,
      validator: widget.validator,
      textFieldConfiguration: TextFieldConfiguration(
        style: TextStyle(color: Colors.black),
        onTap: () {
          setState(() {
            (!expanded) ? expanded = true : expanded = false;
            (expanded) ? controller.open() : controller.close();
          });
        },
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: (!expanded)
              ? Icon(Icons.arrow_drop_down, color: Colors.black)
              : Icon(Icons.arrow_drop_up, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabled: widget.enabled ?? true,
          labelText: widget.label,
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 14, color: Colors.black),
          labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          filled: true,
          fillColor: (widget.enabled == null)
              ? Colors.white
              : widget.enabled!
                  ? Colors.white
                  : Colors.black,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.black38)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 0.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.black, width: 0.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.red, width: 0.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.red, width: 0.5)),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await getSuggestions(pattern);
      },
      debounceDuration: Duration(seconds: 0),
      itemBuilder: (context, suggestion) {
        AutoData data = suggestion as AutoData;
        return ListTile(
          title: Text(
            data.email!,
            style: TextStyle(fontSize: 14),
          ),
        );
      },
      suggestionsBoxVerticalOffset: 0,
      transitionBuilder: (context, suggestionsBox, animationController) =>
          FadeTransition(
        child: suggestionsBox,
        opacity: CurvedAnimation(
            parent: animationController as Animation<double>,
            curve: Curves.fastOutSlowIn),
      ),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        constraints: BoxConstraints(maxHeight: 300),
      ),
      onSuggestionSelected: (suggestion) {
        setState(() {
          AutoData data = suggestion as AutoData;
          widget.controller!.text = data.email!;
          expanded = false;
          widget.onSubmit!(data);
        });
      },
    );
  }

  Future<List> getSuggestions(String pattern) async {
    ResponseGetAuto result = new ResponseGetAuto();
    result = await api.GetAutoData();
    List<AutoData> matches = [];
    matches.addAll(result.data!);
    matches.retainWhere(
      (element) => element.email!.toLowerCase().contains(
            pattern.toLowerCase(),
          ),
    );

    return matches;
  }
}
