import 'package:flutter/material.dart';
import 'package:todoapp/widget/theme.dart';

class addTaskButton extends StatelessWidget {
  final String label;
  final Function() ontap;
  const addTaskButton({Key? key, required this.label, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(right: 15, top: 10),
        height: 60,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
