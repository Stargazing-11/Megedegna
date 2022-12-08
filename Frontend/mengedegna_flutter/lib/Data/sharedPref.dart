// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  void saveToken(key, value) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(key, value);
  }

  Future<String> getValueOf(key) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String value = sharedPrefs.getString(key)!;
    return value;
  }
}
