import 'package:flutter/material.dart';
import 'package:sc_photos/widget/sc_settings.dart';

class SCAppBar extends StatelessWidget {
  Function settingsClick;
  SCAppBar({Key? key, required this.settingsClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(Icons.photo_album_outlined,
                  color: Colors.white, size: 23, weight: 700),
              SizedBox(width: 10),
              Text(
                'SC Photos',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              settingsClick();
            },
            child: Icon(Icons.settings,
                size: 23, color: Colors.white, weight: 700),
          )
        ],
      ),
    );
  }
}
