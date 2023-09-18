// ignore_for_file: file_names

import 'package:hive_flutter/hive_flutter.dart';

part 'cameraApp.g.dart';

@HiveType(typeId: 1)

class CameraApp {
  CameraApp({required this.imageUrl});

  @HiveField(0)
  String imageUrl;

}
