import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webfeed/webfeed.dart';

class FeedPage extends StatefulWidget {
  FeedPage(this.item, {Key key}) : super(key: key);
  final RssItem item;

  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final RssItem item = this.widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(item.title),
            Divider(),
            Html(data: item.description),
            Divider(),
            Text(item.meta.link),
          ],
        ),
      ),
    );
  }
}
