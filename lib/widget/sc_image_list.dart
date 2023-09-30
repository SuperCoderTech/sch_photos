import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';
import 'package:sc_photos/widget/sc_fullscreen_image_view.dart';
import 'package:sc_photos/widget/sc_title.dart';

class SCImageList extends StatefulWidget {
  List<dynamic> data;
  String currentFolder;

  SCImageList({Key? key, required this.currentFolder, required this.data})
      : super(key: key);

  @override
  State<SCImageList> createState() => _SCImageListState();
}

class _SCImageListState extends State<SCImageList> {
  List<Map<String, String>> imageUrlList = [];

  @override
  Widget build(BuildContext context) {
    List<dynamic> imageWidget = getImages();
    if (imageWidget.isEmpty) return const SizedBox();

    return Expanded(
        child: Column(children: [
      const TitleView(
        titleTxt: "Photos",
        arrowReqd: true,
      ),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: AlignedGridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: imageWidget.length,
                itemBuilder: (context, index) {
                  return getImageWidget(imageWidget[index]);
                },
              )))
    ]));
  }

  List<dynamic> getImages() {
    imageUrlList = [];
    List<dynamic> images =
        widget.data.where((element) => element['type'] == "image").toList();
    return images;
  }

  Widget getImageWidget(e) {
    String url = RestDataCommunicator.getImageUrl(
        widget.currentFolder, e['name'], "false");
    int index = imageUrlList.length;
    imageUrlList.add({"name": e['name'], "url": url});

    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScreenImageView(
                      imageUrlList: imageUrlList, position: index)));
        },
        child: CachedNetworkImage(
          placeholder: (context, url) => const SizedBox(
            height: 120,
            child: Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          imageUrl: RestDataCommunicator.getImageUrl(
              widget.currentFolder, e['name'], "true"),
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          fit: BoxFit.fill,
        ));
  }
}
