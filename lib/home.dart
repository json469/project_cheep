import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

import 'package:project_cheep/navigations/navigation_drawer.dart';
import 'package:project_cheep/feed/feed_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  Future<Response> _feed;
  _HomeState() {
    _feed = _fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cheep')),
      body: _buildFutureBuilder(),
      drawer: NavigationDrawer(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<Response> _fetchFeed() async {
    return get('https://www.cheapies.nz/deals/feed');
  }

  FutureBuilder<Response> _buildFutureBuilder() {
    return FutureBuilder<Response>(
      future: _feed,
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _buildLoadingScreen();
          case (ConnectionState.active):
            return _buildLoadingScreen();
          case (ConnectionState.waiting):
            return _buildLoadingScreen();
          default:
            return RefreshIndicator(
              child: _buildFeedListView(RssFeed.parse(snapshot.data.body)),
              onRefresh: _onRefresh,
            );
        }
      },
    );
  }

  Future<void> _onRefresh() {
    setState(() {
      _feed = _fetchFeed();
    });
    // To prevent "The RefreshIndicator onRefresh callback must return a Future."
    return Future.delayed(const Duration(milliseconds: 0));
  }

  ListView _buildFeedListView(RssFeed feed) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.grey.withOpacity(0.5), height: 1),
      itemCount: feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final RssItem item = feed.items[index];
        return FeedItem(item);
      },
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
