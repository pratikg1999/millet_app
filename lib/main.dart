import 'package:flutter/material.dart';
import 'package:millet_app/src/results.dart';

import 'src/app.dart';

void main() => runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String,WidgetBuilder>{
        '/app' : (context) => App(),
        '/Result' : (context) => Result(),
      },
      home: App(),
    ));