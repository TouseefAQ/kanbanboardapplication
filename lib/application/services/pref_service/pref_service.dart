import 'package:kanbanboard/application/services/pref_service/i_pref_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService implements IPrefService {
  late final SharedPreferences _pref;

  PrefService(SharedPreferences preferences) : _pref = preferences;

  @override
  void clear() {
    _pref.clear();
  }

  @override
  SharedPreferences get() {
    return _pref;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _pref.setStringList(key, value);
  }

  @override
  List<String>? getStringList(String key) {
    // D.info("PrefService: getStringList");
    return _pref.getStringList(key);
  }
}
