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
        title: Text(
          _tryRetrieveStoreName(item.title),
          overflow: TextOverflow.ellipsis,
        ),
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

  String _tryRetrieveStoreName(String title) {
    // Given most of the store names are written after the @ symbol...
    final RegExp _atSymbolRegExp = RegExp('[@]');
    if (_atSymbolRegExp.hasMatch(title))
      return title.substring(title.indexOf(_atSymbolRegExp) + 1);
    return 'Cheep Deal';
  }
}
