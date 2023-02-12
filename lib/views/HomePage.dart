import 'package:flutter/material.dart';
import 'package:news_app/helperes/News_helperes.dart';
import 'package:news_app/views/detail_page.dart';

import '../modeles/News.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Jeet's News App"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: NewsHelper.newsHelper.FetchAllNews(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.hasError}"),
              );
            } else if (snapshot.hasData) {
              News data = snapshot.data;
              return (data != null)
                  ? ListView.builder(
                      itemCount: data.articles!.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          leading: Container(
                              color: Colors.grey[200],
                              height: 150,
                              width: 150,
                              child: Image.network(
                                "${data.articles![i].urlToImage}",
                                fit: BoxFit.fitHeight,
                              )),
                          title: Text("${data.articles![i].title}"),
                          subtitle: Text("${data.articles![i].content}"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (e) => const detail_page()));
                          },
                        );
                      })
                  : const Center(
                      child: Text("No any data found"),
                    );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
