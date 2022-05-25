import 'package:get/get.dart';
import 'package:todoapp/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask(Task? task) async {
    return await DbHelper.insert(task);
  }
}
