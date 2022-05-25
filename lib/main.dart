import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/widget/theme.dart';
import 'package:todoapp/services/theme_service.dart';
import 'package:todoapp/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initdb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const HomePage(),
    );
  }
}
