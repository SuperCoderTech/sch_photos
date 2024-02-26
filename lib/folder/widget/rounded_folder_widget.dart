import 'package:flutter/material.dart';
import 'package:sc_commons/rest/rest_client.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';
import 'package:sc_photos/constants/sc_url_constants.dart';

class RoundedFolderWidget extends StatelessWidget {
  final List<dynamic> data;
  final Function(String) onFolderChange;

  const RoundedFolderWidget(
      {Key? key, required this.data, required this.onFolderChange})
      : super(key: key);

  List<dynamic> getFolders() {
    return data
        .where((element) =>
            element['type'] == "directory" &&
            (SCDataConstants.settings!.showHiddenFiles ||
                !element['name'].toString().startsWith(".")))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> folders = getFolders();
    if (folders.length == 0) return SizedBox();
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: folders.length,
          itemBuilder: (context, index) {
            print(index);
            return Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 8.0, right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    onFolderChange(folders[index]['name']);
                  },
                  child: Column(children: [
                    CircleAvatar(
                      backgroundColor: Colors.black45,
                      backgroundImage: NetworkImage(
                          "${RestClient.BASE_URL + SCURLConstants.DIRECTORY_IMAGE}?folder=${SCDataConstants.currentFolder}${folders[index]['name']}/",
                          headers: {
                            "ngrok-skip-browser-warning": "true",
                            'sessionKey': RestClient.SESSION_KEY
                          }),
                      radius: 27,
                    ),
                    SizedBox(height: 2),
                    Text(folders[index]['name'],
                        style: TextStyle(fontSize: 12)),
                  ]),
                ));
          }),
    );
  }
}
