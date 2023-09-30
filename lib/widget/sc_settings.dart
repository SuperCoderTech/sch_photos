import 'package:flutter/material.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:settings_ui/settings_ui.dart';

class SCSettings extends StatefulWidget {
  const SCSettings({Key? key}) : super(key: key);

  @override
  State<SCSettings> createState() => _SCSettingsState();
}

class _SCSettingsState extends State<SCSettings> {
  final TextEditingController _controller = TextEditingController();

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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => getURLDialog(context));
                },
              ),
              SettingsTile.navigation(
                title: const Text("UserName"),
                leading: const Icon(Icons.person),
                value: Text(SCAppConstants.defaultUser),
                onPressed: (BuildContext context) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => textDialog(context,
                              label: "UserName",
                              defaultValue: SCAppConstants.defaultUser,
                              onChange: () {
                            SCAppConstants.defaultUser = _controller.text;
                            SCAppStorage.setValueLocalStorage(
                                LocalStorageConstants.USER_NAME,
                                _controller.text);
                            SCAppStorage.updateAllSettings();
                          }));
                },
              ),
              SettingsTile.navigation(
                title: const Text("Drive Name"),
                leading: const Icon(Icons.drive_file_move),
                value: Text(SCAppConstants.defaultDrive),
                onPressed: (BuildContext context) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => textDialog(context,
                              label: "Drive Name",
                              defaultValue: SCAppConstants.defaultDrive,
                              onChange: () {
                            SCAppConstants.defaultDrive = _controller.text;
                            SCAppStorage.setValueLocalStorage(
                                LocalStorageConstants.DRIVE,
                                _controller.text);
                            SCAppStorage.updateAllSettings();
                          }));
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

  Widget textDialog(BuildContext context,
      {required String label,
      required String defaultValue,
      required Function onChange}) {
    _controller.text = defaultValue;
    return AlertDialog(
      content: Builder(builder: (context) {
        Size size = MediaQuery.of(context).size;
        return SizedBox(
          width: size.width * 0.9,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: const OutlineInputBorder(), labelText: label),
          ),
        );
      }),
      actions: [
        TextButton(
          onPressed: () =>
              {onChange(), Navigator.pop(context, 'OK'), setState(() {})},
          child: const Text('OK'),
        )
      ],
    );
  }

  Widget getURLDialog(BuildContext context) {
    _controller.text = RestDataCommunicator.BASE_URL;
    return AlertDialog(
      content: Builder(builder: (context) {
        Size size = MediaQuery.of(context).size;
        return SizedBox(
          width: size.width * 0.9,
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Private Key',
            ),
          ),
        );
      }),
      actions: [
        TextButton(
          onPressed: () => {
            RestDataCommunicator.BASE_URL = _controller.text,
            SCAppStorage.setValueLocalStorage(
                LocalStorageConstants.SERVER_URL, _controller.text),
            Navigator.pop(context, 'OK'),
            setState(() {})
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
