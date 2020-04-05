import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:project_cheep/navigations/navigation_drawer.dart';
import 'package:project_cheep/feed/feed_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cheep')),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('rss')
              .document('cheapies')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.data['cheapies']);
              return RefreshIndicator(
                child: Container(),
                // child: _buildFeedListView(RssFeed.parse(snapshot.data.data['cheapies'])),
                onRefresh: () {},
              );
            } else {
              return _buildLoadingScreen();
            }
          }),
      drawer: NavigationDrawer(),
    );
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
