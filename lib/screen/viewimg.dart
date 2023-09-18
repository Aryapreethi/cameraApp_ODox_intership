import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:opencamera/model/cameraApp.dart';
// import 'package:opencamera/screen/Homescreen.dart';


class ViewImageDel extends StatefulWidget {
  final int? index;
 final String? imageUrl;
  const ViewImageDel({required this.index,required this.imageUrl, super.key});

  @override
  State<ViewImageDel> createState() => _ViewImageDelState();
}

class _ViewImageDelState extends State<ViewImageDel> {
  late Box<CameraApp> data;
   @override
     void initState() {
    super.initState();
    data = Hive.box('camera');

  }
//delete a item from hive
void delete(){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
      title:const Text("confirm delete!"),
      content:const Text("are you sure!do you want to delete?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("cancel")),
          TextButton(onPressed: (){
             data.deleteAt(widget.index!);
              Navigator.pop(context);
                Navigator.pop(context);
  
        }, child: const Text("ok")),
      ],
    );
      
    },
     
  );
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Moments",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // setState(() {
                // delete();
                // }
                // );
                // Navigator.pop(context);
                delete();
              },
              icon: const Icon(Icons.delete, color: Colors.black)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.file(File(widget.imageUrl!),
        fit: BoxFit.fill,
        ),
      ),
    );
  }
}
