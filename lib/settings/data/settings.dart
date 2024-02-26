import 'dart:convert';

class Settings {
  String url;
  String drive;
  String user;
  bool showHiddenFiles;

  Settings(this.drive, this.user,
      {this.url = "", this.showHiddenFiles = false});

  factory Settings.fromJson(String jsonStr) {
    try {
      Map<String, dynamic> json = jsonDecode(jsonStr);
      return Settings(json['drive'], json['user'],
          url: json['url'], showHiddenFiles: json['showHiddenFiles']);
    } catch (e) {
      print('Error parsing JSON: $e');
      return Settings("", ""); // or throw an exception
    }
  }

  String toJsonString() {
    return jsonEncode({
      'drive': drive,
      'user': user,
      'url': url,
      'showHiddenFiles': showHiddenFiles,
    });
  }

  @override
  String toString() {
    return '{drive: $drive, user: $user, url: $url, showHiddenFiles: $showHiddenFiles}';
  }
}
