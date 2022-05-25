import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/services/notification_service.dart';
import 'package:todoapp/services/theme_service.dart';

import 'package:todoapp/view/task_page_view.dart';
import 'package:todoapp/widget/theme.dart';

import '../button/addtask.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotiFyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
          child: Column(
        children: [
          _taskRow(),
          Container(
            margin: EdgeInsets.only(top: 10, left: 13),
            child: DatePicker(DateTime.now(),
                width: 80,
                height: 100,
                selectionColor: primaryClr,
                selectedTextColor: Colors.white,
                initialSelectedDate: DateTime.now(),
                dateTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                )),
          )
        ],
      )),
    );
  }

  _taskRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: HeadingStyle1,
              ),
              Text(
                "Today",
                style: HeadingStyle2,
              )
            ],
          ),
        ),
        addTaskButton(label: '+addTask', ontap: () => Get.to(AddTaskPage()))
      ],
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        child: Icon(
          Icons.nightlight_rounded,
          size: 20,
          color: Colors.black,
        ),
        onTap: () {
          ThemeService().switchTheme();
          NotiFyHelper().displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode
                ? "Activated Light Theme"
                : "Activated Dark Theme",
          );
          NotiFyHelper().scheduledNotification();
        },
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('images/images.png'),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
