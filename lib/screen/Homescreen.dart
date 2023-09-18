

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:opencamera/api/auth.dart';
import 'package:opencamera/model/cameraApp.dart';
import 'package:opencamera/screen/viewimg.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  LocalAuthentication auth = LocalAuthentication();
  XFile? _image;
  bool isLock = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  //to exit back 

  Future<bool> onwillPop() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you want to exit?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                exit(0);
                // Navigator.of(context).pop(true);
              },
              child: const Text("Proceed"),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  //get value from sharedpreference

  Future<void> load() async {
    bool isLocked = await AppPreferences.getLockState();
    // ignore: unrelated_type_equality_checks
    if (isLocked == Null) {
      isLocked = false;
      await AppPreferences.setLockState(false);
    }
    if (isLocked) {
      authenticate();
    }
    setState(() {
      isLock = isLocked;
    });
  }



  Future<void> switchLock(bool isLocked) async {
    setState(() {
      isLock = isLocked;
    });
    await AppPreferences.setLockState(isLocked);
  }


//authendication function
  Future<void> authenticate() async {
    //  List<BiometricType> Bio=await auth.getAvailableBiometrics();
    try {
      final isauth = await auth.authenticate(
        localizedReason: 'Verify to enter',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
          useErrorDialogs: true,
        ),
      );

      if (!isauth) {
          authenticate();
      }
    } catch (e) {
      Text("Error during authentication: $e");
    }
  }

// void getAvailableBiometric() async {
//   List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
  
//   if (availableBiometrics.contains(BiometricType.face) ||
//       availableBiometrics.contains(BiometricType.fingerprint)) {
//         authenticate();
   
//     print("Biometric authentication is available.");
//   } else {
//     print("Biometric authentication is not available on this device.");
//   }
// }






//adding image to hive
  getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
        Hive.box<CameraApp>('camera').add(CameraApp(imageUrl: _image!.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onwillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: const Text(
            "Moments",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Switch(
              value: isLock,
              onChanged: (value) async {
                await switchLock(value);
              },
            )
          ],
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<CameraApp>('camera').listenable(),
            builder: (BuildContext context, value, Widget? child) {
              return Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final camera = value.getAt(index);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewImageDel(
                              index: index,
                              imageUrl: camera.imageUrl,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.file(
                          File(camera!.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            getImage();
          },
          child: const Icon(
            Icons.camera,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
