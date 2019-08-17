import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_cheep/page.dart';
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
      body: _buildFutureBuilder(),
    );
  }

  FutureBuilder<Response> _buildFutureBuilder() {
    return FutureBuilder<Response>(
      future: fetchFeed(),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _buildLoadingScreen();
          case (ConnectionState.active):
            return _buildLoadingScreen();
          case (ConnectionState.waiting):
            return _buildLoadingScreen();
          default:
            return _buildFeedListView(RssFeed.parse(snapshot.data.body));
        }
      },
    );
  }

  ListView _buildFeedListView(RssFeed feed) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.grey),
      itemCount: feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final RssItem item = feed.items[index];
        return ListTile(
          title: Text(item.title),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Page(item))),
        );
      },
    );
  }

  Widget _buildLoadingScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[Center(child: CircularProgressIndicator())],
    );
  }

  Future<Response> fetchFeed() {
    return get('https://www.cheapies.nz/deals/feed');
  }
}
