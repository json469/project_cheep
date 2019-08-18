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
    final Size _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          FeedHelpers.getTitle(_item.title),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        height: _screenSize.height,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildHeader(_textTheme, _item),
                    _buildImage(_item),
                    _buildBody(_item, _textTheme),
                  ],
                ),
              ),
            ),
            _buildGoToLinkButton(_textTheme, _item.meta.link)
          ],
        ),
      ),
    );
  }

  Widget _buildBody(RssItem _item, TextTheme _textTheme) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        FeedHelpers.getDescription(parse(_item.description).outerHtml),
        textAlign: TextAlign.left,
        style: _textTheme.body1,
      ),
    );
  }

  Widget _buildImage(RssItem _item) {
    if (_item.meta.image != null)
      return Container(
        color: Colors.grey.withOpacity(0.5),
        alignment: Alignment.center,
        child: Image.network(_item.meta.image, fit: BoxFit.fitWidth),
      );
    return Container();
  }

  Widget _buildHeader(TextTheme textTheme, RssItem item) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.title,
              style: textTheme.title
                  .copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
          Row(
            children: <Widget>[
              Text('By '),
              Text(item.dc.creator, style: textTheme.subtitle),
              SizedBox(width: 8),
              Text('•  ' + FeedHelpers.getFeedPageDate(item.pubDate))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGoToLinkButton(TextTheme textTheme, String url) {
    final Size _screenSize = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      height: 60.0,
      width: _screenSize.width,
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
