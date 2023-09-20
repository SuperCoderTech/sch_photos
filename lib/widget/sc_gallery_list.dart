import 'package:flutter/material.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:sc_photos/widget/sc_folder_list.dart';
import 'package:sc_photos/widget/sc_image_list.dart';

class SCGalleryView extends StatefulWidget {
  bool refresh;

  SCGalleryView({Key? key, this.refresh = false}) : super(key: key);

  @override
  State<SCGalleryView> createState() => _SCGalleryViewState();
}

class _SCGalleryViewState extends State<SCGalleryView> {
  String currentFolder = "";
  List<dynamic> data = [];

  void getData() async {
    data = await RestDataCommunicator.sendRequest(RestURL.getImageByFolder,
        params: {'folder': currentFolder});
    print(data);
    setState(() {});
  }

  void refreshCheck() {
    if (widget.refresh) {
      currentFolder = "";
      widget.refresh = false;
      getData();
    }
  }

  Future<bool> backPress() async {
    if (currentFolder.isEmpty) return true;

    final lastSlashIndex = currentFolder.lastIndexOf("/");
    if (lastSlashIndex == -1) {
      currentFolder = "";
    } else {
      currentFolder = currentFolder.substring(0, lastSlashIndex);
      if (currentFolder.isEmpty) currentFolder = "/";
    }

    print("currentFolder: $currentFolder");
    getData();
    return false;
  }

  void onFolderClick(String folderName) {
    currentFolder += folderName + "/";
    print("modified folder :: $currentFolder");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    refreshCheck();
    return WillPopScope(
        onWillPop: backPress,
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(children: [
              SCFolderList(data: data, onFolderChange: onFolderClick),
              SCImageList(currentFolder: currentFolder, data: data)
            ])));
  }
}
