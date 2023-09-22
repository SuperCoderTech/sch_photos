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

  Future<bool> backPress() async {
    if (currentFolder.isEmpty) return true;
    String tmp = currentFolder.substring(0, currentFolder.lastIndexOf("/"));
    print("before back $currentFolder");
    if (tmp.isNotEmpty && tmp.contains("/")) {
      tmp = tmp.substring(0, tmp.lastIndexOf("/"));
      currentFolder = "$tmp/";
    } else {
      currentFolder = "";
    }
    print("current Folder $currentFolder");
    setState(() {});
    return false;
  }

  void onFolderClick(String folderName) {
    currentFolder += "$folderName/";
    print("modified folder :: $currentFolder");
    setState(() {});
  }

  Future<List<dynamic>> getAllItems() async {
    print("get All Items called");
    List<dynamic> items = await RestDataCommunicator.sendRequest(
        RestURL.getImageByFolder,
        params: {'folder': currentFolder});
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
                if (snapshot.hasData) {
                  return Column(children: [
                    SCFolderList(
                        data: snapshot.data!, onFolderChange: onFolderClick),
                    SCImageList(
                        currentFolder: currentFolder, data: snapshot.data!)
                  ]);
                } else if (snapshot.hasError) {
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
                } else {
                  return const Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )));
  }
}

// Column(children: [
// SCFolderList(data: data, onFolderChange: onFolderClick),
// SCImageList(currentFolder: currentFolder, data: data)
// ])
