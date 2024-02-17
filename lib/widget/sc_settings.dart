import 'package:flutter/material.dart';
import 'package:sc_photos/commons/sc_common_widgets.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:settings_ui/settings_ui.dart';

class SCSettings extends StatefulWidget {
  const SCSettings({Key? key}) : super(key: key);

  @override
  State<SCSettings> createState() => _SCSettingsState();
}

class _SCSettingsState extends State<SCSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff001B3A),
            title: const Text("Settings")),
        body: SettingsList(
          sections: [
            SettingsSection(title: const Text('Common'), tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: const Text('Server Url'),
                leading: const Icon(Icons.computer_outlined),
                value: Text(RestDataCommunicator.BASE_URL),
                onPressed: (BuildContext context) {
                  SCCommonWidgets.showTextDialog(
                    context,
                    label: "Private Key",
                    defaultValue: RestDataCommunicator.BASE_URL,
                    onChange: (changedVal) {
                      RestDataCommunicator.BASE_URL = changedVal;
                      SCAppStorage.setValueLocalStorage(
                          LocalStorageConstants.SERVER_URL, changedVal);
                      setState(() {});
                    },
                  );
                },
              ),
              SettingsTile.navigation(
                title: const Text("UserName"),
                leading: const Icon(Icons.person),
                value: Text(SCAppConstants.defaultUser),
                onPressed: (BuildContext context) {
                  SCCommonWidgets.showTextDialog(
                    context,
                    label: "UserName",
                    defaultValue: SCAppConstants.defaultUser,
                    onChange: (changedValue) {
                      SCAppConstants.defaultUser = changedValue;
                      SCAppStorage.setValueLocalStorage(
                          LocalStorageConstants.USER_NAME, changedValue);
                      SCAppStorage.updateAllSettings();
                      setState(() {});
                    },
                  );
                },
              ),
              SettingsTile.navigation(
                title: const Text("Drive Name"),
                leading: const Icon(Icons.drive_file_move),
                value: Text(SCAppConstants.defaultDrive),
                onPressed: (BuildContext context) {
                  SCCommonWidgets.showTextDialog(
                    context,
                    label: "Drive Name",
                    defaultValue: SCAppConstants.defaultDrive,
                    onChange: (changedVal) {
                      SCAppConstants.defaultDrive = changedVal;
                      SCAppStorage.setValueLocalStorage(
                          LocalStorageConstants.DRIVE, changedVal);
                      SCAppStorage.updateAllSettings();
                      setState(() {});
                    },
                  );
                },
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  print("value of swith $value");
                  SCAppStorage.setBoolLocalStorage(
                      LocalStorageConstants.SHOW_HIDDEN_FILES, value);
                  SCAppConstants.showHiddenfiles = value;
                  setState(() {});
                },
                initialValue: SCAppConstants.showHiddenfiles,
                leading: const Icon(Icons.lock_clock_sharp),
                title: const Text('Show hidden Folders/Files'),
              ),
            ])
          ],
        ));
  }
}
