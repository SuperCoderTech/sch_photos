import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sc_commons/rest/rest_client.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';
import 'package:sc_photos/constants/sc_url_constants.dart';
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
              child: buildMasonaryGridView(imageWidget)))
    ]));
  }

  AlignedGridView buildAlignedGridView(List<dynamic> imageWidget) {
    return AlignedGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: imageWidget.length,
      itemBuilder: (context, index) {
        return getImageWidget(imageWidget[index]);
      },
    );
  }

  Widget buildMasonaryGridView(List<dynamic> imageWidget) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: imageWidget.length,
        (context, index) => getImageWidget(imageWidget[index]),
      ),
    );
  }

  List<dynamic> getImages() {
    imageUrlList = [];
    List<dynamic> images =
        widget.data.where((element) => element['type'] == "image").toList();
    return images;
  }

  Widget getImageWidget(e) {
    //authKey=${RestClient.SESSION_KEY}&
    String url =
        "${RestClient.BASE_URL + SCURLConstants.SEND_IMAGE}?folder=${SCDataConstants.currentFolder}&file=${e['name']}";
    int index = imageUrlList.length;
    imageUrlList.add({"name": e['name'], "url": "$url&thumb=false"});

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
          imageUrl: "$url&thumb=true",
          httpHeaders: {
            "ngrok-skip-browser-warning": "true",
            'sessionKey': RestClient.SESSION_KEY
          },
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
