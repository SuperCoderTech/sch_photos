import 'package:flutter/material.dart';
import 'package:sc_commons/rest/rest_client.dart';
import 'package:sc_commons/storage/shared_pref_manager.dart';
import 'package:sc_photos/commons/sc_helper.dart';
import 'package:sc_photos/constants/sc_constants.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';
import 'package:sc_photos/home/page/home_page.dart';
import 'package:sc_photos/settings/data/settings.dart';
import 'package:sc_photos/utils/sc_app_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? loginRemark;

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCAppConstants.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icon/logo.png', width: 200),
            const SizedBox(height: 20),
            loginRemark == null
                ? GestureDetector(
                    onDoubleTap: goToHome,
                    child: const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(color: Colors.white)),
                  )
                : Text(loginRemark!)
          ],
        ),
      ),
    );
  }

  void checkLogin() async {
    await SharedPreferencesManager.initialize();
    String? settingsJson =
        SharedPreferencesManager.instance.getString(SCConstants.SETTINGS);
    print("setting from storage :: $settingsJson");

    if (settingsJson == null) {
      Settings newSetting = Settings("Drive", "NOUSER",
          url: "https://summary-enormous-lamb.ngrok-free.app/",
          showHiddenFiles: false);
      settingsJson = newSetting.toJsonString();
    }

    SharedPreferencesManager.instance
        .setString(SCConstants.SETTINGS, settingsJson);
    SCDataConstants.settings = Settings.fromJson(settingsJson);
    print("final data ${SCDataConstants.settings}");

    login();
  }

  void login() async {
    try {
      var json = await SCHelper.login();
      if (json['auth'] == "failed") {
        setState(() {
          loginRemark = json['msg'];
        });
      }
    } catch (err) {
      print(err);
    }
    await goToHome();
  }

  Future<void> goToHome() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
