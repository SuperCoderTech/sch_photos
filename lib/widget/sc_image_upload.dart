import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';

class SCImageUpload extends StatefulWidget {
  const SCImageUpload({Key? key}) : super(key: key);

  @override
  State<SCImageUpload> createState() => _SCImageUploadState();
}

class _SCImageUploadState extends State<SCImageUpload> {
  List<Map<String, dynamic>> images = [];

  @override
  void initState() {
    super.initState();
    pickImageOnStart();
  }

  void pickImageOnStart() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: true);

    setState(() {
      if (result != null) {
        result.paths.forEach((path) => {
              images.add({'file': File(path!), 'status': 'YTS'})
            });
        startUploading();
      } else {
        Navigator.pop(context);
      }
    });
  }

  void startUploading() async {
    images.forEach((file) async {
      await uploadSingleImage(file);
    });
  }

  Future<void> uploadSingleImage(file) async {
    file['status'] = "WIP";
    setState(() {});
    var resp = await RestDataCommunicator.asyncFileUpload(
        SCAppConstants.currentFolder, file['file']);
    print(resp);
    file['status'] = "Done";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Uploading Photos   ${getFinishCount()}"),

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return getImageWidget(images[index]);
            }),
      ),
    );
  }

  Widget getImageWidget(Map<String, dynamic> imag) {
    String name = imag['file'].path.split(Platform.pathSeparator).last;
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          const SizedBox.square(dimension: 80, child: Icon(Icons.photo)),
          const SizedBox(width: 10),
          Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text(name, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 10),
              Text(imag['status'], style: const TextStyle(fontSize: 15))
            ],
          )
        ],
      ),
    );
  }

  String getFinishCount() {
    try {
      String cnt =
          "${images.where((element) => element['status'] == "Done").length}/${images.length}";
      return cnt;
    } catch (err) {
      return "-/-";
    }
  }
}
