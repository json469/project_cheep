import 'package:flutter/material.dart';
import 'package:project_cheep/models/coupon_model.dart';
import 'package:webfeed/webfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:project_cheep/constants/network_constants.dart';

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
              .collection(kCollectionName)
              .document(kDocumentName)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return _buildFeedListView(
                RssFeed.parse(snapshot.data.data[kRSS]),
                snapshot.data.data[kDeals],
              );
            } else {
              return _buildLoadingScreen();
            }
          }),
      drawer: NavigationDrawer(),
    );
  }

  ListView _buildFeedListView(RssFeed rawFeeds, Map rawCoupons) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.grey.withOpacity(0.5), height: 1),
      itemCount: rawFeeds.items.length,
      itemBuilder: (BuildContext context, int index) {
        final RssItem item = rawFeeds.items[index];
        final String nodeId =
            item.link.substring(item.link.lastIndexOf('/') + 1);
        return FeedItem(item, Coupon(rawCoupons['$nodeId']));
      },
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
