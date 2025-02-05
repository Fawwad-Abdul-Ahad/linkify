import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkify/firebase_options.dart';
import 'package:linkify/screens/login_screen.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
      themeMode: ThemeMode.dark,
      home: ScreenUtilInit(designSize: Size(360, 960),child: LoginScreen(),),
    );
  }
}
