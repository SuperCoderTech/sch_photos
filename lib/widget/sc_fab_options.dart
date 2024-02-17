import 'package:flutter/material.dart';
import 'package:sc_photos/commons/sc_common_widgets.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:sc_photos/widget/sc_image_upload.dart';

class SCFabOptions extends StatelessWidget {
  const SCFabOptions({Key? key}) : super(key: key);

  void uploadPhotos(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SCImageUpload()));
  }

  void createFolder(BuildContext context) async {
    SCCommonWidgets.showTextDialog(context,
        label: "Folder Name", defaultValue: "", onChange: (folderName) async {
      print(folderName);
      await RestDataCommunicator.sendRequest(RestURL.create_folder,
          params: {'folder': SCAppConstants.currentFolder, 'name': folderName});
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildOption(context,
                    icon: Icons.photo, text: "Photos", onTap: uploadPhotos),
                buildOption(context,
                    icon: Icons.slow_motion_video_outlined, text: "Video"),
                buildOption(context,
                    icon: Icons.folder_copy_outlined,
                    text: "Add Folder",
                    onTap: createFolder),
                buildOption(context,
                    icon: Icons.refresh, text: "Thumbnail", onTap: runThumbnail)
              ]),
        ));
  }

  Widget buildOption(BuildContext context,
      {required IconData icon, required String text, Function? onTap}) {
    return GestureDetector(
      onTap: () {
        print("tapped me");
        if (onTap != null) onTap!(context);
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

  runThumbnail(BuildContext context) {
    RestDataCommunicator.thumb();
    Navigator.of(context, rootNavigator: true).pop();
  }
}
