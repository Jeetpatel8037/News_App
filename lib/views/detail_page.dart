import 'package:flutter/material.dart';
import 'package:news_app/helperes/News_helperes.dart';
import 'package:news_app/modeles/News.dart';

class detail_page extends StatefulWidget {
  const detail_page({Key? key}) : super(key: key);

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NewsHelper.newsHelper.FetchAllNews(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            News data = snapshot.data;
            return (data != null)
                ? ListView.builder(
                    // itemCount: 1,
                    itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Container(
                          height: 250,
                          color: Colors.grey,
                          child:
                              Image.network("${data.articles![i].urlToImage}"),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.articles![i].title}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${data.articles![i].publishedAt}",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(height: 5),
                              Text("${data.articles![i].content}"),
                              const Divider(),
                              Text("${data.articles![i].author}"),
                              Text("${data.articles![i].source}"),
                            ],
                          ),
                        ),
                      ],
                    );
                  })
                : const Center(
                    child: Text("data not found"),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
