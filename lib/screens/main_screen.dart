import 'package:flutter/material.dart';
import 'package:flutter_web/services/api_service.dart';

class MainScreen extends StatelessWidget {
  final newsApi = ApiService();
  _fetchNews() async {
    var _news = await newsApi.topNews();
    return _news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchNews(),
        builder: (context, news) {
          switch (news.connectionState) {
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return CircularProgressIndicator();
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: news.data.length,
                  itemBuilder: (context, index) {
                    final item = newsApi.newsContent(news.data, index);
                    return GestureDetector(
                      onTap: () {
                        //what to do OnTap
                      },
                      child: Column(
                        children: <Widget>[
                          Image.network(item.image),
                          Text(item.title),
                          Text(item.text),
                        ],
                      ),
                    );
                  });
          }
          return null;
        },
      ),
    );
  }
}
