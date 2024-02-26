import 'package:flutter/material.dart';
import 'package:sc_photos/commons/sc_common_widgets.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';
import 'package:sc_photos/settings/service/setting_manager.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPageV2 extends StatefulWidget {
  const SettingsPageV2({Key? key}) : super(key: key);

  @override
  State<SettingsPageV2> createState() => _SettingsPageV2State();
}

class _SettingsPageV2State extends State<SettingsPageV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: SCAppConstants.color,
            title:
                const Text("Settings", style: TextStyle(color: Colors.white))),
        body: SettingsList(
            brightness: Brightness.light,
            lightTheme: const SettingsThemeData(
                settingsSectionBackground: Colors.white),
            sections: [
              SettingsSection(
                  title: const Text('Common'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      title: const Text('Server Url'),
                      leading: const Icon(Icons.computer_outlined),
                      value: Text(SCDataConstants.settings!.url),
                      onPressed: (BuildContext context) {
                        SCCommonWidgets.showTextDialog(
                          context,
                          label: "Private Key",
                          defaultValue: SCDataConstants.settings!.url,
                          onChange: (changedVal) {
                            SCDataConstants.settings!.url = changedVal;
                            SettingsManager.updateAllSettings();
                            setState(() {});
                          },
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: const Text("User"),
                      leading: const Icon(Icons.person),
                      value: Text(SCDataConstants.settings!.user),
                      onPressed: (BuildContext context) {
                        SCCommonWidgets.showTextDialog(
                          context,
                          label: "User",
                          defaultValue: SCDataConstants.settings!.user,
                          onChange: (changedValue) {
                            SCDataConstants.settings!.user = changedValue;
                            SettingsManager.updateAllSettings();
                            setState(() {});
                          },
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: const Text("Drive Name"),
                      leading: const Icon(Icons.drive_file_move),
                      value: Text(SCDataConstants.settings!.drive),
                      onPressed: (BuildContext context) {
                        SCCommonWidgets.showTextDialog(
                          context,
                          label: "Drive Name",
                          defaultValue: SCDataConstants.settings!.drive,
                          onChange: (changedVal) {
                            SCDataConstants.settings!.drive = changedVal;
                            SettingsManager.updateAllSettings();
                            setState(() {});
                          },
                        );
                      },
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        print("value of swith $value");
                        SCDataConstants.settings!.showHiddenFiles = value;
                        SettingsManager.updateAllSettings();
                        setState(() {});
                      },
                      initialValue: SCDataConstants.settings!.showHiddenFiles,
                      leading: const Icon(Icons.lock_clock_sharp),
                      title: const Text('Show hidden Folders/Files'),
                    ),
                  ])
            ]));
  }
}
