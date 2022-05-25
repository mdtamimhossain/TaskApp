import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/widget/new_task_input_field.dart';
import 'package:todoapp/widget/theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "10:30 PM";
  String _StartTime = DateFormat("hh:mm a").format(DateTime.now());
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 20, 30, 60];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 2, 2),
      appBar: _appBar(),
      body: Container(
        margin: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "add task",
                style: HeadingStyle2,
              ),
              MyInputField(
                title: 'Title',
                hint: "Enter Your Title ..",
                controller: _titleController,
              ),
              MyInputField(
                title: 'Note',
                hint: "Enter your note ..",
                controller: _noteController,
              ),
              MyInputField(
                title: 'Date',
                hint: DateFormat().add_yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    print("Hi bro");
                    _getDateFromCalender();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Start Time',
                      hint: _StartTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded),
                        onPressed: () {
                          _getTimeFromClock(false);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded),
                        onPressed: () {
                          _getTimeFromClock(true);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  onChanged: (String? value) => {
                    setState(
                      () {
                        _selectedRemind = int.parse(value!);
                      },
                    )
                  },
                  underline: Container(height: 0),
                  iconSize: 35,
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 4,
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  onChanged: (String? value) => {
                    setState(
                      () {
                        _selectedRepeat = value!;
                      },
                    )
                  },
                  underline: Container(height: 0),
                  iconSize: 35,
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 4,
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorsButton(),
                  _createTaskButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateInputField() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.pink,
          icon: Icon(Icons.warning_amber_outlined));
    }
  }

  _addTaskToDb() async {
    await _taskController.addTask(Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _StartTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColorIndex,
      isCompleted: 0,
    ));
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: GestureDetector(
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,
        ),
        onTap: () {
          Get.back();
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

  _getDateFromCalender() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017),
      lastDate: DateTime(2080),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  _getTimeFromClock(bool isEndTime) async {
    TimeOfDay? _pickerTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(hour: 11, minute: 30),
    );
    if (_pickerTime == null) {
      print("Cancel");
    } else if (isEndTime == true) {
      _endTime = _pickerTime.format(context);
    } else {
      _StartTime = _pickerTime.format(context);
    }
  }

  _colorsButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: subtitleStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColorIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _selectedColorIndex == index
                      ? Icon(Icons.done)
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _createTaskButton() {
    return GestureDetector(
      onTap: () {
        _validateInputField();
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 50,
        width: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: primaryClr),
        child: Center(
          child: Text(
            "Create Task",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
