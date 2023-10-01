import 'package:flutter/material.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';
import 'package:sc_photos/widget/sc_appbar.dart';
import 'package:sc_photos/widget/sc_fab_options.dart';
import 'package:sc_photos/widget/sc_gallery_list.dart';
import 'package:sc_photos/widget/sc_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SCAppStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: SCAppConstants.color),
      darkTheme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: SCAppConstants.color),
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
  @override
  Widget build(BuildContext context) {
    print("MyHomePage ---");
    return Scaffold(
      body: buildAppBody(context),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: SCAppConstants.color,
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return SCFabOptions();
              });
        });
  }

  SizedBox buildAppBody(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),
          SCAppBar(settingsClick: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SCSettings()))
                .then((value) => setState(() {}));
          }),
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
              child: SCGalleryView(),
            ),
          ),
        ],
      ),
    );
  }
}
