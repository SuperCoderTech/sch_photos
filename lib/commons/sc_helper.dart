import 'dart:convert';

import 'package:sc_commons/rest/rest_client.dart';
import 'package:sc_photos/constants/sc_data_constants.dart';
import 'package:sc_photos/constants/sc_url_constants.dart';

class SCHelper {
  static Future<dynamic> login() async {
    RestClient.registerBaseUrl(SCDataConstants.settings!.url);
    dynamic params = {
      'drive': SCDataConstants.settings!.drive,
      'user': SCDataConstants.settings!.user
    };
    String? resp =
    await RestClient.sendRequest(SCURLConstants.LOGIN, params: params);
    print("login response :: $resp");
    var json = jsonDecode(resp!);
    if (json['auth'] == "success") {
      RestClient.registerSessionKey(json['authKey']);
    }

    return json;
  }

}