import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:project_cheep/web_view_container.dart';
import 'package:webfeed/webfeed.dart';

class Page extends StatefulWidget {
  Page(this.item, {Key key}) : super(key: key);
  final RssItem item;

  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    final RssItem item = this.widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(item.title),
            Html(data: item.description),
            RaisedButton(
              child: Text('Link'),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewContainer(item.link))),
            )
          ],
        ),
      ),
    );
  }
}
