import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'package:project_cheep/helpers/network_helpers.dart';
import 'package:project_cheep/constants/feed_constants.dart';

class FeedFooterButton extends StatelessWidget {
  const FeedFooterButton(this.item, {Key key}) : super(key: key);
  final RssItem item;

  @override
  Widget build(BuildContext context) {
    final int nodeID =
        int.parse(item.link.substring(item.link.lastIndexOf('/') + 1));

    return Positioned(
      bottom: 0,
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<Response>(
          future: get(
              'https://asia-northeast1-cheep-backend.cloudfunctions.net/get_coupon_code/?node_id=$nodeID'),
          builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final codes = snapshot.data.body;
              if (codes == '') {
                return _buildOpenDealButton(context);
              } else {
                return _buildCouponCodeButton(context, codes);
              }
            } else {
              return _buildLoadingButton(context);
            }
          }),
    );
  }

  Widget _buildLoadingButton(BuildContext context) {
    return Container(
      height: 60.0,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
        onPressed: null,
      ),
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

  Widget _buildCouponCodeButton(BuildContext context, String codes) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        _buildCouponCode(context, codes),
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

  Widget _buildCouponCode(BuildContext context, String codes) {
    final ThemeData _themeData = Theme.of(context);
    final TextTheme _textTheme = Theme.of(context).textTheme;

    List<dynamic> listOfCodes = [];
    if (codes.startsWith('[')) {
      listOfCodes = jsonDecode(codes);
    } else {
      listOfCodes.add(codes);
    }

    return Container(
      height: 50.0,
      color: _themeData.primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: listOfCodes.length,
        itemBuilder: (BuildContext context, int index) {
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
                  Text(listOfCodes[index],
                      style: _textTheme.body1.copyWith(color: Colors.white)),
                  SizedBox(width: 8.0),
                  Icon(Icons.content_copy,
                      color: Colors.white),
                ],
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: listOfCodes[index]));
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
