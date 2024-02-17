import 'package:flutter/material.dart';

class SCCommonWidgets {

  static void showTextDialog(BuildContext context,
      {required String label,
      required String defaultValue,
      required Function onChange}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => textDialog(context,
            label: label, defaultValue: defaultValue, onChange: onChange));
  }

  static Widget textDialog(BuildContext context,
      {required String label,
      required String defaultValue,
      required Function onChange}) {
    TextEditingController controller = TextEditingController();
    controller.text = defaultValue;
    return AlertDialog(
      content: Builder(builder: (context) {
        Size size = MediaQuery.of(context).size;
        return SizedBox(
          width: size.width * 0.9,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: const OutlineInputBorder(), labelText: label),
          ),
        );
      }),
      actions: [
        TextButton(
          onPressed: () =>
              {onChange(controller.text), Navigator.pop(context, 'OK')},
          child: const Text('OK'),
        )
      ],
    );
  }
}
