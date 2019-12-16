import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';
import 'package:newsapi_client/newsapi_client.dart';

class ApiService {
  final client = NewsapiClient(apiKey);

  Future<Map<String, dynamic>> topNews() async {
    final response = await client.request(
      TopHeadlines(
        page: 1,
        pageSize: 20,
        country: 'id',
      ),
    );
    return response;
  }

  NewsModel newsContent(Map<String, dynamic> response, int index) {
    var newsImage = response['articles'][index]['urlToImage'],
        newsTitle = response['articles'][index]['title'],
        newsText = response['articles'][index]['content'].split('[')[0],
        news = NewsModel(image: newsImage, title: newsTitle, text: newsText);
    return news;
  }
}
