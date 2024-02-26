import 'package:flutter/material.dart';
import 'package:sc_photos/home/widgets/floating_button.dart';
import 'package:sc_photos/home/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
      //floatingActionButton: const SCFloatingButton(),
    );
  }
}
