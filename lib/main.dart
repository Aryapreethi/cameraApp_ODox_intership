import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opencamera/model/cameraApp.dart';
import 'package:opencamera/screen/Homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<CameraApp>(CameraAppAdapter());
  await Hive.openBox<CameraApp>('camera');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        appBarTheme: AppBarTheme(color: Colors.black)
      ),
      home:  const MyWidget(),
      
    );
  }
}
