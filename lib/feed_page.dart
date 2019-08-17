import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:project_cheep/helpers/feed_helpers.dart';
import 'package:webfeed/webfeed.dart';

class FeedPage extends StatefulWidget {
  FeedPage(this.item, {Key key}) : super(key: key);
  final RssItem item;

  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final RssItem _item = this.widget.item;
    final TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          FeedHelpers.getTitle(_item.title),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
                child: Text(
              _item.title,
              style: _textTheme.title,
            )),
            Container(
                constraints: BoxConstraints.tightFor(height: 200.0),
                child: Image.network(_item.meta.image, fit: BoxFit.fitWidth)),
            Text(
              FeedHelpers.getDescription(parse(_item.description).outerHtml),
              textAlign: TextAlign.left,
              style: _textTheme.body1,
            ),
            Text(_item.meta.link),
          ],
        ),
      ),
    );
  }
}
