import 'package:flutter/material.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:settings_ui/settings_ui.dart';

import '../comunicator/sc_communicator.dart';

class SCSettings extends StatefulWidget {
  const SCSettings({Key? key}) : super(key: key);

  @override
  State<SCSettings> createState() => _SCSettingsState();
}

class _SCSettingsState extends State<SCSettings> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: SettingsList(
          sections: [
            SettingsSection(title: Text('Common'), tiles: <SettingsTile>[
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
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: false,
                leading: const Icon(Icons.lock_clock_sharp),
                title: const Text('Show hidden Folders/Files'),
              ),
            ])
          ],
        ));
  }

  Widget getURLDialog(BuildContext context) {
    _controller.text = RestDataCommunicator.BASE_URL;
    return AlertDialog(
      content: Builder(builder: (context) {
        Size size = MediaQuery.of(context).size;
        return Container(
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
