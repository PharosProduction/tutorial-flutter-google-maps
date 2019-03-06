import 'package:flutter/material.dart';

import 'screens/map.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps'),
        ),
        body: Map(),
      ),
    );
  }
}
