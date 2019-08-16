import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cheep')),
      body: buildFutureBuilder(),
    );
  }

  FutureBuilder<Response> buildFutureBuilder() {
    return FutureBuilder<Response>(
      future: fetchFeed(),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final RssFeed feed = RssFeed.parse(snapshot.data.body);
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.grey),
            itemCount: feed.items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(feed.items[index].title),
              );
            },
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Center(child: CircularProgressIndicator())],
          );
        }
      },
    );
  }

  Future<Response> fetchFeed() {
    return get('https://www.cheapies.nz/deals/feed');
  }
}
