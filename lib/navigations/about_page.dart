import 'package:flutter/material.dart';

import 'package:project_cheep/helpers/ink_well_wrapper.dart';
import 'package:project_cheep/helpers/network_helpers.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                _buildResources(context),
                _buildOpenContribtion(context),
              ],
            ),
          ),
          _buildContextDeveloperButton(context),
        ],
      ),
    );
  }

  Widget _buildResources(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader(context, 'Resources'),
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("This app was built with Choice Cheapies NZ RSS feed."),
              _buildLink(
                site: 'Choice Cheapies NZ',
                url: 'https://cheapies.nz/',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOpenContribtion(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader(context, 'Open Source'),
        Container(
          padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "This app is open source and we welcome all form of contributions."),
              _buildLink(
                site: 'Cheep Github',
                url: 'https://github.com/json469/project_cheep',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      height: 50.0,
      color: Colors.blueGrey[700],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildLink({String site, String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWellWrapper(
        child: Text(
          site,
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () => NetworkHelpers.launchUrl(url),
      ),
    );
  }

  MaterialButton _buildContextDeveloperButton(BuildContext context) {
    return MaterialButton(
      minWidth: double.maxFinite,
      height: 60,
      color: Theme.of(context).primaryColor,
      child: Text('CONTACT DEVELOPER',
          style:
              Theme.of(context).textTheme.button.copyWith(color: Colors.white)),
      onPressed: () =>
          NetworkHelpers.sendEmail('jessethetentdeveloper@gmail.com'),
    );
  }
}
