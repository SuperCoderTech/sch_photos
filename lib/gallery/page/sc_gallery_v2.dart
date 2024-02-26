import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sc_commons/rest/rest_client.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';
import 'package:sc_photos/constants/sc_url_constants.dart';
import 'package:sc_photos/folder/widget/rounded_folder_widget.dart';
import 'package:sc_photos/gallery/widget/center_loader.dart';
import 'package:sc_photos/gallery/widget/no_data_container.dart';
import 'package:sc_photos/widget/sc_folder_list.dart';
import 'package:sc_photos/widget/sc_image_list.dart';

class SCGalleryV2 extends StatefulWidget {
  const SCGalleryV2({Key? key}) : super(key: key);

  @override
  State<SCGalleryV2> createState() => _SCGalleryV2State();
}

class _SCGalleryV2State extends State<SCGalleryV2> {
  bool backPress() {
    if (SCDataConstants.currentFolder.isEmpty) return true;
    String tmp = SCDataConstants.currentFolder
        .substring(0, SCDataConstants.currentFolder.lastIndexOf("/"));
    print("before back ${SCDataConstants.currentFolder}");
    print("after back $tmp");
    if (tmp.isNotEmpty && tmp.contains("/")) {
      tmp = tmp.substring(0, tmp.lastIndexOf("/"));
      SCDataConstants.currentFolder = "$tmp/";
    } else {
      SCDataConstants.currentFolder = "";
    }
    print("current Folder $SCDataConstants.currentFolder");
    setState(() {});
    return false;
  }

  Future<List<dynamic>> getAllItems() async {
    print("get All Items called");
    String? resp = await RestClient.sendRequest(
        SCURLConstants.GET_FOLDER_AND_IMAGE_IN_FOLDER,
        params: {'folder': SCDataConstants.currentFolder});
    List<dynamic> items = jsonDecode(resp!);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didpop) {
          if (backPress()) {
            Navigator.of(context).pop();
            return;
          }
        },
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder<List<dynamic>>(
              future: getAllItems(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CenterLoader();
                }

                if (snapshot.hasData) {
                  return Column(children: [
                    RoundedFolderWidget(
                        data: snapshot.data!,
                        onFolderChange: (folder) {
                          SCDataConstants.currentFolder += "$folder/";
                          setState(() {});
                        }),
                    SCImageList(
                        currentFolder: SCDataConstants.currentFolder,
                        data: snapshot.data!)
                  ]);
                }

                return const NoDataConatiner();
              },
            )));
  }
}
