import 'package:flutter/material.dart';
import 'package:sc_photos/comunicator/sc_communicator.dart';

class SCAppBar extends StatelessWidget {
  Function uriChange;

  SCAppBar({Key? key, required this.uriChange}) : super(key: key);
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home),
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) => getURLDialog(context));
            },
            child: Icon(Icons.settings,
                size: 23, color: Colors.white, weight: 700),
          )
        ],
      ),
    );
  }

  Widget getURLDialog(BuildContext context) {
    _controller.text = RestDataCommunicator.BASE_URL;
    return AlertDialog(
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Private Key',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => {
            RestDataCommunicator.BASE_URL = _controller.text,
            Navigator.pop(context, 'OK'),
            uriChange()
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
