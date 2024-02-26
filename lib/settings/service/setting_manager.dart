import 'package:sc_commons/storage/shared_pref_manager.dart';
import 'package:sc_photos/constants/sc_constants.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';

class SettingsManager {
  static void updateAllSettings() {
    SharedPreferencesManager.instance.setString(
        SCConstants.SETTINGS, SCDataConstants.settings!.toJsonString());
  }
}
