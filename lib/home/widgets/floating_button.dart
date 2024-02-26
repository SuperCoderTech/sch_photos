import 'package:flutter/material.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:sc_photos/widget/sc_fab_options.dart';

class SCFloatingButton extends StatelessWidget {
  const SCFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: SCAppConstants.color,
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return SCFabOptions();
              });
        },
        child: const Icon(Icons.add, color: Colors.white));
    ;
  }
}
