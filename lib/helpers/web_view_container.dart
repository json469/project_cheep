import 'package:flutter/material.dart';
import 'package:project_cheep/helpers/network_helpers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final String title;
  final String url;
  WebViewContainer({this.title, this.url});
  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  final _key = UniqueKey();
  bool _showLoadingPage = true;

  void _handleLoad(String value) {
    setState(() => _showLoadingPage = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => NetworkHelpers.launchUrl(widget.url),
          ),
        ],
      ),
      body: IndexedStack(
        index: _showLoadingPage ? 1 : 0,
        children: [
          // Index 0 with actual PageView content
          Column(
            children: <Widget>[
              Expanded(
                  child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
                onPageFinished: _handleLoad,
              )),
            ],
          ),
          // Index 1 with LoadingPage content
          _buildLoadingPage(),
        ],
      ),
    );
  }

  Widget _buildLoadingPage() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
