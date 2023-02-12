import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modeles/News.dart';

class NewsHelper {
  NewsHelper._();
  static final NewsHelper newsHelper = NewsHelper._();

  Future<News?> FetchAllNews() async {
    String api =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=850da516b5474a6db03d93ca47ab4703";

    var responce = await http.get(Uri.parse(api));

    if (responce.statusCode == 200) {
      Map decodeddata = jsonDecode(responce.body);

      News n1 = News.fromJson(decodeddata);
      return n1;
    }
  }
}
