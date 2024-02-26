import 'package:flutter/material.dart';

class NoDataConatiner extends StatelessWidget {
  const NoDataConatiner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 60),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Failed to Load data 😢'),
            ),
          ],
        ),
      ),
    );
  }
}
