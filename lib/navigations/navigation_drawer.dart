import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:project_cheep/constants/navigation_drawer_constants.dart';
import 'package:project_cheep/navigations/about_page.dart';

class NavigationDrawer extends StatelessWidget {
  final List<DrawerItem> _drawerItems = [
    DrawerItem('About', Icons.info, AboutPage()),
    // DrawerItem('Feedback', Icons.feedback, FeedbackPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _renderDrawerList(context),
    );
  }

  ListView _renderDrawerList(BuildContext context) {
    List<Widget> _drawerList = [
      _renderDrawerHeader(context),
      _renderDrawerSubHeader(context),
    ];

    _drawerItems.forEach((_drawerItem) {
      _drawerList.add(ListTile(
          title:
              Text(_drawerItem.title, style: TextStyle(color: Colors.black87)),
          leading: Icon(
            _drawerItem.icon,
            color: Colors.black87,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _drawerItem.route),
            );
          }));
      _drawerList.add(Divider(
        height: 0.0,
      ));
    });

    _drawerList.add(ListTile(
      title: Text('Open Source'),
      leading: Icon(
        Icons.code,
        color: Colors.black87,
      ),
      onTap: () => _launchURL('https://github.com/json469/sound_doctrine'),
    ));

    return ListView(
      padding: EdgeInsets.all(0.0),
      children: _drawerList,
    );
  }

  Widget _renderDrawerHeader(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      margin: EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            maxRadius: 35,
            backgroundColor: Colors.white,
            child: FlutterLogo(),
          ),
          Text(
            kAppName,
            style: _textTheme.title.copyWith(color: Colors.white),
          ),
          Text(
            kAppVersion,
            style: _textTheme.caption.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _renderDrawerSubHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.blueGrey[700]),
      child: Column(
        children: <Widget>[
          Text(
            kAppDescription,
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Text(
            kAppDeveloper,
            style: TextStyle(fontSize: 10.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class DrawerItem {
  String title;
  IconData icon;
  Widget route;
  DrawerItem(this.title, this.icon, this.route);
}
