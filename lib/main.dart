import 'package:flutter/material.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:sc_photos/widget/sc_appbar.dart';
import 'package:sc_photos/widget/sc_gallery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF1B434D)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    SCAppStorage.init();

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 45),
            SCAppBar(uriChange: () {
              setState(() {
                refresh = true;
              });
            }),
            const SizedBox(height: 25),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: SCGalleryView(refresh: refresh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
