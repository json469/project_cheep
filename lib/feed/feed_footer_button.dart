import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'package:project_cheep/helpers/network_helpers.dart';
import 'package:project_cheep/constants/feed_constants.dart';

class FeedFooterButton extends StatelessWidget {
  const FeedFooterButton(this.item);
  final RssItem item;

  @override
  Widget build(BuildContext context) {
    final int nodeID =
        int.parse(item.link.substring(item.link.lastIndexOf('/') + 1));

    return Positioned(
      bottom: 0,
      // height: 60.0,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<Response>(
          future: get(
              'https://us-central1-cheep-scraper.cloudfunctions.net/get_coupon_code/?node_id=$nodeID'),
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
      height: 60.0,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            kOpenDealButton,
            style: _textTheme.button.copyWith(color: Colors.white),
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
          height: 60.0,
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
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

    List<String> listOfCodes = [];
    if (codes.startsWith('[')) {
      // TODO(JesseSon): Fix after changes made to multi code array format
      // listOfCodes = json.decode(codes);
      listOfCodes = [
        'COUPONCODE1',
        'COUPONCODE2',
        'COUPONCODE3',
        'COUPONCODE4'
      ];
    } else {
      listOfCodes.add(codes);
    }

    return Container(
      height: 60.0,
      color: _themeData.primaryColorDark,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOfCodes.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(index != 0 ? 0 : 8.0, 12.0, 8.0, 12.0),
            child: FlatButton(
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
                      color: _themeData.scaffoldBackgroundColor),
                ],
              ),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}

// Widget _buildCouponCode(TextTheme textTheme, RssItem item) {
//   final int nodeID =
//       int.parse(item.link.substring(item.link.lastIndexOf('/') + 1));
//   return FutureBuilder<Response>(
//     future: get(
//         'https://us-central1-cheep-scraper.cloudfunctions.net/get_coupon_code/?node_id=$nodeID'),
//     builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {
//         if (snapshot.data.body != '') {
//           if (snapshot.data.body is String)
//             return Container(
//                 margin: const EdgeInsets.only(top: 4.0),
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.circular(4.0),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   snapshot.data.body,
//                   style: textTheme.subhead.copyWith(color: Colors.white),
//                 ));
//         }
//       }
//       return Container();
//     },
//   );
// }
