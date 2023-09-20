import 'package:flutter/material.dart';
import 'package:sc_photos/widget/sc_title.dart';

class SCFolderList extends StatefulWidget {
  List<dynamic> data;
  Function(String) onFolderChange;

  SCFolderList({Key? key, required this.data, required this.onFolderChange})
      : super(key: key);

  @override
  State<SCFolderList> createState() => _SCFolderListState();
}

class _SCFolderListState extends State<SCFolderList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> folderWidgets = getFolders();
    if (folderWidgets.isEmpty) return const SizedBox();
    return Column(
      children: [
        const SizedBox(height: 5),
        const TitleView(titleTxt: "Folders", arrowReqd: true, leftPadding: 15),
        SizedBox(
          width: double.infinity,
          child: Wrap(spacing: 10, runSpacing: 20, children: folderWidgets),
        )
      ],
    );
  }

  List<Widget> getFolders() {
    List<Widget> widgets = widget.data
        .where((element) => element['type'] == "directory")
        .map((e) => GestureDetector(
            onTap: () {
              print("folder changed :: $e['name']");
              widget.onFolderChange(e['name']);
            },
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                const Icon(Icons.folder, size: 60),
                SizedBox(
                    width: 80,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          e['name'],
                          style: const TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        )))
              ],
            )))
        .toList();
    return widgets;
  }
}
