import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{
  static  String islockey='locked';

  static Future<void> setLockState(bool isLocked) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setBool(islockey, isLocked);
  }
 
 static Future<bool> getLockState() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getBool(islockey)??false;

  }
}
