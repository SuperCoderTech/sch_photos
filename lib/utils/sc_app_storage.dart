import 'dart:ui';

import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageConstants { SERVER_URL, SHOW_HIDDEN_FILES, DRIVE, USER_NAME }

class SCAppConstants {
  static const color = const Color(0xff001B3A);
  static bool showHiddenfiles = false;
  static String defaultDrive = "Mine";
  static String defaultUser = "MRB";
  static String currentFolder = "";
}

class SCAppStorage {
  static SharedPreferences? localStorage;

  static Future init() async {
    try {
      localStorage = await SharedPreferences.getInstance();
      updateAllSettings();
    } catch (e) {
      print(e);
    }
    return true;
  }

  static String? getValueFromLocalStorage(LocalStorageConstants val) {
    String? s = localStorage!.getString(val.toString());
    return s;
  }

  static bool getBoolFromLocalStorage(LocalStorageConstants val) {
    bool? s = localStorage!.getBool(val.toString());
    return s ?? false;
  }

  static bool setValueLocalStorage(LocalStorageConstants key, String val) {
    print("${LocalStorageConstants.SHOW_HIDDEN_FILES}   $val");
    localStorage?.setString(key.toString(), val);
    return true;
  }

  static bool setBoolLocalStorage(LocalStorageConstants key, bool val) {
    print("${LocalStorageConstants.SHOW_HIDDEN_FILES}   $val");
    localStorage?.setBool(key.toString(), val);
    return true;
  }

  static void updateAllSettings() {
    RestDataCommunicator.BASE_URL =
        getValueFromLocalStorage(LocalStorageConstants.SERVER_URL)!;
    SCAppConstants.showHiddenfiles =
        getBoolFromLocalStorage(LocalStorageConstants.SHOW_HIDDEN_FILES)!;
    if (getValueFromLocalStorage(LocalStorageConstants.DRIVE) != null) {
      SCAppConstants.defaultDrive =
          getValueFromLocalStorage(LocalStorageConstants.DRIVE)!;
    }
    if (getValueFromLocalStorage(LocalStorageConstants.USER_NAME) != null) {
      SCAppConstants.defaultUser =
          getValueFromLocalStorage(LocalStorageConstants.USER_NAME)!;
    }
    RestDataCommunicator.setDefaultStorage();
    RestDataCommunicator.getAuthToken();
    SCAppConstants.currentFolder = "";
  }
}
