import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:project_cheep/helpers/feed_helpers.dart';
import 'package:project_cheep/web_view_container.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(_textTheme, _item),
            Container(
                constraints: BoxConstraints.tightFor(height: 200.0),
                child: Image.network(_item.meta.image, fit: BoxFit.fitWidth)),
            Text(
              FeedHelpers.getDescription(parse(_item.description).outerHtml),
              textAlign: TextAlign.left,
              style: _textTheme.body1,
            ),
            _buildGoToLinkButton(_textTheme, _item.meta.link)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme, RssItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(item.title, style: textTheme.title),
        Text(item.dc.creator, style: textTheme.subtitle),
        Text(FeedHelpers.getFeedPageDate(item.pubDate))
      ],
    );
  }

  Widget _buildGoToLinkButton(
    TextTheme textTheme,
    String url,
  ) {
    return Container(
      height: 60.0,
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        child: Center(
          child: Text(
            'GO TO LINK',
            style: textTheme.button.copyWith(color: Colors.white),
          ),
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WebViewContainer(url))),
      ),
    );
  }
}
