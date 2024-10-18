import 'package:pica_comic/base.dart';

const imageUrls = [
  "https://cdn-msp.jmapiproxy3.cc",
  "https://cdn-msp3.jmapiproxy3.cc",
  "https://cdn-msp2.jmapiproxy1.cc",
  "https://cdn-msp3.jmapiproxy3.cc",
  "https://cdn-msp2.jmapiproxy4.cc",
  "https://cdn-msp2.jmapiproxy3.cc",
  "https://cdn-msp.jmapiproxy1.cc",
  "https://cdn-msp.jmapiproxy2.cc",
  "https://cdn-msp2.jmapiproxy2.cc",
  "https://cdn-msp3.jmapiproxy2.cc",
  "https://cdn-msp.jmapinodeudzn.net",
  "https://cdn-msp3.jmapinodeudzn.net",
];

String getBaseUrl(){
  int index = int.parse(appdata.settings[37]);
  if (index == 12) {
    return appdata.settings[84];
  } else {
    return imageUrls[index];
  }
}

String getJmCoverUrl(String id) {
  return "${getBaseUrl()}/media/albums/${id}_3x4.jpg";
}

String getJmImageUrl(String imageName, String id) {
  return "${getBaseUrl()}/media/photos/$id/$imageName";
}

String getJmAvatarUrl(String imageName) {
  return "${getBaseUrl()}/media/users/$imageName";
}
