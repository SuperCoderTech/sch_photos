import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sc_photos/utils/sc_app_storage.dart';

enum RestURL {
  getAuthToken,
  getAllData,
  getImageByFolder,
  send_image,
  create_folder,
  thumb,
  change_upload_folder
}

extension ParseToString on RestURL {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class RestDataCommunicator {
  static String BASE_URL = "http://192.168.X.XX:5000/";
  static String? AUTH_KEY = null;

  static setDefaultStorage() {
    sendRequest(RestURL.change_upload_folder,
        params: {'drive': SCAppConstants.defaultDrive});
  }

  static getUrlWithAuth(url) {
    return BASE_URL + url.toString() + "?authKey=" + AUTH_KEY.toString();
  }

  static Future<bool> getAuthToken() async {
    print(BASE_URL + 'getAuthToken');
    final uri =
        Uri.parse(BASE_URL + 'getAuthToken/' + SCAppConstants.defaultUser);
    var response = await http.get(uri);
    int statusCode = response.statusCode;
    String responseBody = response.body;
    if (statusCode == 200) {
      var decodedJson = jsonDecode(responseBody);
      print(decodedJson);
      AUTH_KEY = decodedJson['token'].toString();
      return true;
    }
    return false;
  }

  static void thumb() {
    sendRequest(RestURL.thumb);
  }

  static String getParamsString(Map<String, dynamic>? params) {
    String queryString = "";
    if (params != null) {
      queryString = Uri(
          queryParameters: params.map((key, value) =>
              MapEntry(key, value == null ? null : value.toString()))).query;
      queryString = "&" + queryString;
    }
    return queryString;
  }

  static Future<dynamic>? sendRequest(RestURL url,
      {Map<String, dynamic>? params}) async {
    if (AUTH_KEY == null) await RestDataCommunicator.getAuthToken();
    String queryString = getParamsString(params);
    String fullUrl = getUrlWithAuth(url.toShortString()) + queryString;
    print(fullUrl);
    final uri = Uri.parse(fullUrl);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic decodedJson = jsonDecode(response.body);
      print(decodedJson);
      return decodedJson;
    }
    return null;
  }

  static Future<String> sendPostRequest(RestURL url, dynamic? body,
      {Map<String, dynamic>? params}) async {
    String queryString = getParamsString(params);
    String fullUrl = getUrlWithAuth(url.toShortString()) + queryString;
    final uri = Uri.parse(fullUrl);
    final headers = {'Content-Type': 'application/json'};
    String jsonBody = "";
    if (body != null) jsonBody = json.encode(body);
    print(fullUrl);
    print(jsonBody);
    final encoding = Encoding.getByName('utf-8');
    var response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    return responseBody;
  }

  static String getImageUrl(
      String currentFolder, String fileName, String thumb) {
    String url = getUrlWithAuth(RestURL.send_image.toShortString());
    url += "&path=" +
        Uri.encodeComponent(currentFolder + fileName) +
        "&thumb=" +
        thumb;
    print(url);
    return url;
  }

  static Future<String> asyncFileUpload(String folder, File file,
      {String url = "saveImage", Map<String, dynamic>? params}) async {
    String queryString = getParamsString(params);
    var request = http.MultipartRequest("POST",
        Uri.parse(getUrlWithAuth(url) + "&folder=" + folder + queryString));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    var pic = await http.MultipartFile.fromPath("file_field", file.path);
    request.files.add(pic);
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var response = await request.send();
    print("request complete: " + request.toString());
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    return responseString;
  }
}
