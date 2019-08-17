import 'package:flutter/material.dart';
import 'package:project_cheep/feed_page.dart';
import 'package:webfeed/webfeed.dart';

class FeedItem extends StatelessWidget {
  const FeedItem(this.item, {Key key}) : super(key: key);
  final RssItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      title: _buildTitle(context),
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
        Text(item.pubDate,
            style: _textTheme.body1.copyWith(color: Colors.grey)),
      ],
    );
  }

  ClipRRect _buildThumbnail(BuildContext context, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        constraints: BoxConstraints.tightFor(width: 92.0, height: 64.0),
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
    );
  }
}
