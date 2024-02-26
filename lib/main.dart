import 'package:flutter/material.dart';
import 'package:sc_photos/splash/splash_page.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SC Photos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: SCAppConstants.color),
      darkTheme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: SCAppConstants.color),
      home: const SplashScreen(),
    );
  }
}
