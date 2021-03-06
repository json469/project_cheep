import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:webfeed/webfeed.dart';

import 'package:project_cheep/models/coupon_model.dart';

import 'package:project_cheep/feed/feed_footer_button.dart';
import 'package:project_cheep/helpers/feed_helpers.dart';
import 'package:project_cheep/constants/feed_constants.dart';

class FeedPage extends StatefulWidget {
  FeedPage(this.item, this.coupon, {Key key}) : super(key: key);
  final RssItem item;
  final Coupon coupon;

  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final RssItem _item = this.widget.item;
    final Coupon _coupon = this.widget.coupon;
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final Size _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          FeedHelpers.getTitle(_item.title),
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[_buildShareIcon(_item)],
      ),
      body: Container(
        height: _screenSize.height,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: _coupon.codes.length > 0
                    ? 100.0
                    : 50.0, // Leave bottom margin for coupon height to be rendered (which is dynamic)
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildHeader(_textTheme, _item),
                    _buildImage(_item),
                    _buildBody(_textTheme, _item),
                  ],
                ),
              ),
            ),
            FeedFooterButton(_item, _coupon)
          ],
        ),
      ),
    );
  }

  IconButton _buildShareIcon(RssItem _item) {
    return IconButton(
      icon: Icon(Icons.share),
      onPressed: () => Share.share(kShareDeal + _item.link),
    );
  }

  Widget _buildHeader(TextTheme textTheme, RssItem item) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.title,
              style: textTheme.headline6
                  .copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Text(item.dc.creator, style: textTheme.subtitle2),
                Text(' • ' + FeedHelpers.getFeedPageDate(item.pubDate)),
              ]),
              _buildTags(item),
              _buildExpiryTag(item),
            ],
          ),
        ],
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

  Widget _buildBody(TextTheme _textTheme, RssItem _item) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        FeedHelpers.getDescription(parse(_item.description).outerHtml),
        textAlign: TextAlign.left,
        style: _textTheme.bodyText2,
      ),
    );
  }

  Widget _buildTags(RssItem item) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Wrap(
        children: item.categories
            .map((category) => Container(
                  margin: EdgeInsets.only(bottom: 4.0, right: 4.0),
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(category.value.replaceAll('&amp;', '') + ' ',
                      style: _textTheme.bodyText2
                          .copyWith(fontSize: 10, color: Colors.white)),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildExpiryTag(RssItem item) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    if (item.meta.expiry == null) return Container();

    if (FeedHelpers.isExpired(item.meta.expiry))
      return Container(
          margin: const EdgeInsets.only(top: 4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: Text(
            kExpired,
            style: _textTheme.subtitle1.copyWith(color: Colors.white),
          ));

    final _expiryString = FeedHelpers.getExpiryDaysLeft(item.meta.expiry);
    return Container(
        margin: const EdgeInsets.only(top: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _expiryString == kExpiresToday ||
                  _expiryString == kExpiresTomorrow
              ? Colors.orange
              : Colors.green,
          borderRadius: BorderRadius.circular(4.0),
        ),
        alignment: Alignment.center,
        child: Text(
          _expiryString,
          style: _textTheme.subtitle1.copyWith(color: Colors.white),
        ));
  }
}
