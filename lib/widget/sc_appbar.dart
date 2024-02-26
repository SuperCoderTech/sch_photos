import 'package:flutter/material.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';

class SCAppBar extends StatelessWidget {
  Function settingsClick;
  Function addClick;

  SCAppBar({Key? key, required this.settingsClick, required this.addClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const SizedBox(width: 20),
              const Icon(Icons.photo_album_outlined,
                  color: Colors.white, size: 23, weight: 700),
              const SizedBox(width: 10),
              Text(
                SCDataConstants.currentFolder == ""
                    ? 'SC Photos'
                    : SCDataConstants.currentFolder,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  addClick();
                },
                child: const Icon(Icons.add,
                    size: 23, color: Colors.white, weight: 700),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  settingsClick();
                },
                child: Icon(Icons.settings,
                    size: 23, color: Colors.white, weight: 700),
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }
}
