import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'package:project_cheep/models/coupon_model.dart';

import 'package:project_cheep/helpers/network_helpers.dart';
import 'package:project_cheep/constants/feed_constants.dart';

class FeedFooterButton extends StatelessWidget {
  const FeedFooterButton(this.item, this.coupon, {Key key}) : super(key: key);
  final RssItem item;
  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: coupon.codes.length > 0
          ? _buildCouponCodeButton(context, coupon)
          : _buildOpenDealButton(context),
    );
  }

  Widget _buildOpenDealButton(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      height: 50.0,
      child: RaisedButton(
        color: Theme.of(context).primaryColorDark,
        child: Center(
          child: Text(
            kOpenDealButton,
            style:
                _textTheme.button.copyWith(fontSize: 24, color: Colors.white),
          ),
        ),
        onPressed: () => NetworkHelpers.launchUrl(item.meta.url),
      ),
    );
  }

  Widget _buildCouponCodeButton(BuildContext context, Coupon coupon) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        _buildCouponCode(context, coupon.codes),
        Container(
          height: 50.0,
          child: RaisedButton(
            color: Theme.of(context).primaryColorDark,
            child: Center(
              child: Text(
                kOpenDealButton,
                style: _textTheme.button.copyWith(color: Colors.white),
              ),
            ),
            onPressed: () => NetworkHelpers.launchUrl(item.meta.url),
          ),
        ),
      ],
    );
  }

  Widget _buildCouponCode(BuildContext context, List<dynamic> codes) {
    final ThemeData _themeData = Theme.of(context);
    final TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
      height: 50.0,
      color: _themeData.primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: coupon.codes.length,
        itemBuilder: (BuildContext context, int index) {
          var body1 = _textTheme.bodyText2;
          return Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, index != 0 ? 0 : 8.0, 8.0),
            child: FlatButton(
              splashColor: Colors.white38,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: _themeData.scaffoldBackgroundColor)),
              child: Row(
                children: <Widget>[
                  Text(codes[index],
                      style: body1.copyWith(color: Colors.white)),
                  SizedBox(width: 8.0),
                  Icon(Icons.content_copy, color: Colors.white),
                ],
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: codes[index]));
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Copied to Clipboard"),
                  duration: Duration(milliseconds: 300),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}
