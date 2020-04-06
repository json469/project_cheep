import 'package:flutter/material.dart';

import 'package:project_cheep/helpers/ink_well_wrapper.dart';
import 'package:project_cheep/helpers/network_helpers.dart';
import 'package:project_cheep/constants/about_page_constants.dart';

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
              Text(kAboutDescription),
              _buildLink(
                site: kChoiceCheapiesNZ,
                url: kChoiceCheapiesLink,
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
              Text(kCheepDescription),
              _buildLink(
                site: kCheepGithub,
                url: kCheepGithubLink,
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
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
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
      child: Text(kContactDeveloper,
          style:
              Theme.of(context).textTheme.button.copyWith(color: Colors.white)),
      onPressed: () =>
          NetworkHelpers.sendEmail(kContactDeveloperEmail),
    );
  }
}
