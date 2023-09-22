import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageConstants { SERVER_URL, SHOW_HIDDEN_FILES }

class SCAppStorage {

  static SharedPreferences? localStorage;

  static Future init() async {
    try {
      localStorage = await SharedPreferences.getInstance();
      RestDataCommunicator.BASE_URL =
          getValueFromLocalStorage(LocalStorageConstants.SERVER_URL)!;
    } catch (e) {
      print(e);
    }
    return true;
  }

  static String? getValueFromLocalStorage(LocalStorageConstants val) {
    String? s = localStorage!.getString(val.toString());
    return s;
  }

  static bool setValueLocalStorage(LocalStorageConstants key, String val) {
    localStorage?.setString(key.toString(), val);
    return true;
  }
}
