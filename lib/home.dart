import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cheep'),
      ),
      body: FutureBuilder<Response>(
          future: fetchFeed(),
          builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return SingleChildScrollView(
                  child: Text(snapshot.data.body.toString()));
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Center(child: CircularProgressIndicator())],
            );
          }),
    );
  }

  Future<Response> fetchFeed() {
    return get('https://www.cheapies.nz/deals/feed');
  }
}
