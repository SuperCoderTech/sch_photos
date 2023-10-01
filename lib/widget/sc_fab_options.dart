import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';

class SCFabOptions extends StatelessWidget {
  const SCFabOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildOption(icon: Icons.photo, text: "Photos"),
            buildOption(icon: Icons.slow_motion_video_outlined, text: "Video"),
            buildOption(icon: Icons.folder_copy_outlined, text: "Add Folder")
          ],
        ));
  }

  Widget buildOption(
      {required IconData icon, required String text, required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: SCAppConstants.color, child: Icon(icon)),
            const SizedBox(height: 10),
            Text(text)
          ]),
    );
  }
}
