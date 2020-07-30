import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_cheep/blocs/theme_changer.dart';
import 'package:project_cheep/helpers/network_helpers.dart';
import 'package:project_cheep/constants/navigation_drawer_constants.dart';
import 'package:project_cheep/navigations/about_page.dart';

class NavigationDrawer extends StatelessWidget {
  final List<DrawerItem> _drawerItems = [
    DrawerItem('About', Icons.info, AboutPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _renderDrawerList(context),
    );
  }

  ListView _renderDrawerList(BuildContext context) {
    final themeProvider = Provider.of<ThemeChanger>(context);

    List<Widget> _drawerList = [
      _renderDrawerHeader(context),
      _renderDrawerSubHeader(context),
    ];

    _drawerItems.forEach((_drawerItem) {
      _drawerList.add(ListTile(
          title: Text(_drawerItem.title),
          leading: Icon(
            _drawerItem.icon,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _drawerItem.route),
            );
          }));
    });

    _drawerList.add(ListTile(
      title: Text('Dark Mode'),
      leading: Icon(
        Icons.brightness_4,
      ),
      trailing: Switch(
        value: !themeProvider.isLight(),
        onChanged: (x) => themeProvider.toggleTheme(),
      ),
    ));

    _drawerList.add(ListTile(
      title: Text('Open Source'),
      leading: Icon(
        Icons.code,
      ),
      onTap: () => NetworkHelpers.launchUrl(kGithubOpenSourceLink),
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
            style: _textTheme.headline6.copyWith(color: Colors.white),
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
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
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
}

class DrawerItem {
  String title;
  IconData icon;
  Widget route;
  DrawerItem(this.title, this.icon, this.route);
}
