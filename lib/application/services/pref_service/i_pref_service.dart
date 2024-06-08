import 'package:shared_preferences/shared_preferences.dart';

abstract class IPrefService {
  List<String>? getStringList(String key);
  Future<bool> setStringList(String key, List<String> value);
  SharedPreferences get();
  void clear();
}
