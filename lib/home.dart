import 'package:auto_size_text/auto_size_text.dart';
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
          title: AutoSizeText(item.title, maxLines: 2),
          leading: _buildThumbnail(context, item.meta.image),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Page(item))),
        );
      },
    );
  }

  ClipRRect _buildThumbnail(BuildContext context, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
          constraints: BoxConstraints.tightFor(width: 64.0, height: 64.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: imageUrl != null
              ? Image.network(imageUrl, fit: BoxFit.fitWidth)
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Icon(
                    Icons.money_off,
                    color: Colors.white,
                  ))),
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
