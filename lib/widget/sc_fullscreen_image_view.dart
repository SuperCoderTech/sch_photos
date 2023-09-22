import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';

class FullScreenImageView extends StatefulWidget {
  List<Map<String, String>> imageUrlList;
  int position;

  FullScreenImageView(
      {Key? key, required this.imageUrlList, required this.position})
      : super(key: key);

  @override
  State<FullScreenImageView> createState() => _FullScreenImageViewState();
}

class _FullScreenImageViewState extends State<FullScreenImageView> {
  PageController? _pageController;

  int currentImagePosition = 0;

  void shareImage() async {
    var filePath = await downloadImage();
    final file = XFile(filePath);
    await Share.shareXFiles([file], text: 'Sharing File');
  }

  void deleteImage() async {
    var url = widget.imageUrlList[currentImagePosition]['url']!;
    url = url.replaceAll("send_image", "delete_image");
    print(url);
    final uri = Uri.parse(url);
    var response = await get(uri);
    widget.imageUrlList.removeAt(currentImagePosition);
    Fluttertoast.showToast(
        msg: "Deleted...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {});
  }

  Future<String> downloadImage() async {
    var status = await Permission.manageExternalStorage.request();

    if (!status.isGranted) {
      return "";
    }

    Fluttertoast.showToast(
        msg: "Downloading...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    var url = widget.imageUrlList[currentImagePosition]['url']!;
    var name = widget.imageUrlList[currentImagePosition]['name']!;
    print(url);
    final uri = Uri.parse(url);
    var response = await get(uri);
    var documentDirectory = Directory('/storage/emulated/0/Download');
    var filePathAndName = '${documentDirectory.path}/$name';
    print(filePathAndName);
    await Directory(documentDirectory.path).create(recursive: true); // <-- 1
    File file = File(filePathAndName);
    file.writeAsBytesSync(response.bodyBytes);

    Fluttertoast.showToast(
        msg: "Download Complete.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    return filePathAndName;
  }

  @override
  Widget build(BuildContext context) {
    currentImagePosition = widget.position;
    _pageController = PageController(initialPage: widget.position);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: PhotoViewGallery.builder(
                  pageController: _pageController,
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    currentImagePosition = index;
                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(
                          widget.imageUrlList[index]['url']!),
                      initialScale: PhotoViewComputedScale.contained * 1,
                    );
                  },
                  itemCount: widget.imageUrlList.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: Colors.black45,
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          shareImage();
                        },
                        child: const Icon(
                          Icons.share,
                          color: Colors.white60,
                        ),
                      ),
                      GestureDetector(
                          child: const Icon(
                        Icons.copy,
                        color: Colors.white60,
                      )),
                      GestureDetector(
                        onTap: () {
                          deleteImage();
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white60,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(currentImagePosition);
                          downloadImage();
                        },
                        child: const Icon(
                          Icons.download,
                          color: Colors.white60,
                        ),
                      )
                    ],
                  ),
                ))
          ])),
    );
  }
}
