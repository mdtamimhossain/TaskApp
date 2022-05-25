import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/widget/theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Widget? widget;
  final TextEditingController? controller;
  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.widget,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: HeadingStyle1,
        ),
        Container(
          margin: EdgeInsets.only(top: 7),
          padding: EdgeInsets.only(left: 10),
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black45, width: 1.0)),
          child: Row(children: [
            Expanded(
              child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  controller: controller,
                  style: subtitleStyle,
                  decoration: InputDecoration(
                      hintText: hint,
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: context.theme.backgroundColor),
                      ))),
            ),
            widget == null ? Container() : Container(child: widget),
          ]),
        )
      ]),
    );
  }
}
