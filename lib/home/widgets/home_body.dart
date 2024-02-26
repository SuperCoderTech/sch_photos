import 'package:flutter/material.dart';
import 'package:sc_photos/commons/sc_helper.dart';
import 'package:sc_photos/gallery/page/sc_gallery_v2.dart';
import 'package:sc_photos/settings/page/setting_page_v2.dart';
import 'package:sc_photos/widget/sc_appbar.dart';
import 'package:sc_photos/widget/sc_fab_options.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),
          SCAppBar(
            settingsClick: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPageV2()))
                  .then((value) => reLogin());
            },
            addClick: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return SCFabOptions(
                      onUpdate: () {
                        setState(() {});
                      },
                    );
                  });
            },
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: SCGalleryV2(),
            ),
          ),
        ],
      ),
    );
    ;
  }

  reLogin() async {
    var json = await SCHelper.login();
    setState(() {});
  }
}
