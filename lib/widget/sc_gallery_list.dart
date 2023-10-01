import 'package:flutter/material.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:sc_photos/widget/sc_folder_list.dart';
import 'package:sc_photos/widget/sc_image_list.dart';

class SCGalleryView extends StatefulWidget {
  const SCGalleryView({Key? key}) : super(key: key);

  @override
  State<SCGalleryView> createState() => _SCGalleryViewState();
}

class _SCGalleryViewState extends State<SCGalleryView> {
  Future<bool> backPress() async {
    if (SCAppConstants.currentFolder.isEmpty) return true;
    String tmp = SCAppConstants.currentFolder
        .substring(0, SCAppConstants.currentFolder.lastIndexOf("/"));
    print("before back $SCAppConstants.currentFolder");
    if (tmp.isNotEmpty && tmp.contains("/")) {
      tmp = tmp.substring(0, tmp.lastIndexOf("/"));
      SCAppConstants.currentFolder = "$tmp/";
    } else {
      SCAppConstants.currentFolder = "";
    }
    print("current Folder $SCAppConstants.currentFolder");
    setState(() {});
    return false;
  }

  void onFolderClick(String folderName) {
    SCAppConstants.currentFolder += "$folderName/";
    print("modified folder :: $SCAppConstants.currentFolder");
    setState(() {});
  }

  Future<List<dynamic>> getAllItems() async {
    print("get All Items called");
    List<dynamic> items = await RestDataCommunicator.sendRequest(
        RestURL.getImageByFolder,
        params: {'folder': SCAppConstants.currentFolder});
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: backPress,
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder<List<dynamic>>(
              future: getAllItems(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return Column(children: [
                    SCFolderList(
                        data: snapshot.data!, onFolderChange: onFolderClick),
                    SCImageList(
                        currentFolder: SCAppConstants.currentFolder,
                        data: snapshot.data!)
                  ]);
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Column(
                        children: [
                          Icon(Icons.error_outline,
                              color: Colors.red, size: 60),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Failed to Load data 😢'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )));
  }
}

// Column(children: [
// SCFolderList(data: data, onFolderChange: onFolderClick),
// SCImageList(SCAppConstants.currentFolder: SCAppConstants.currentFolder, data: data)
// ])
