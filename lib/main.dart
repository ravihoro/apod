import 'package:flutter/material.dart';
import './app/locator.dart';
import './app/router.dart' as route;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stacked APOD',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        primarySwatch: Colors.amber,
        accentColor: Colors.amber,
      ),
      initialRoute: '/',
      onGenerateRoute: route.Router.generateRoute,
    );
  }
}
