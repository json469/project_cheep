import 'package:flutter/material.dart';
import 'package:project_cheep/feed/feed_page.dart';
import 'package:project_cheep/helpers/feed_helpers.dart';
import 'package:webfeed/webfeed.dart';

class FeedItem extends StatelessWidget {
  const FeedItem(this.item, {Key key}) : super(key: key);
  final RssItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      title: _buildTitle(context),
      subtitle: _buildSubTitle(context),
      leading: _buildThumbnail(context, item.meta.image),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => FeedPage(item))),
    );
  }

  Column _buildTitle(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.title,
          style: _textTheme.subhead
              .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSubTitle(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(FeedHelpers.getFeedItemDate(item.pubDate),
              style: _textTheme.body1.copyWith(color: Colors.grey)),
          _buildExpiredTag(),
        ],
      ),
    );
  }

  Widget _buildExpiredTag() {
    if (FeedHelpers.isExpired(item.meta.expiry))
      return Container(
          margin: const EdgeInsets.only(top: 4.0),
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: Text(
            'EXPIRED',
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          ));
    return Container();
  }

  Widget _buildThumbnail(BuildContext context, String imageUrl) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          constraints: BoxConstraints.tightFor(width: 80.0, height: 80.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.75),
          ),
          child: imageUrl != null
              ? Image.network(imageUrl, fit: BoxFit.fitWidth)
              : Container(
                  child: Icon(
                  Icons.money_off,
                  color: Colors.white,
                )),
        ),
      ),
    );
  }
}
