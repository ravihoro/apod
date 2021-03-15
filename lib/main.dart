import 'package:flutter/material.dart';
import './pages/home_page.dart';
import 'package:provider/provider.dart';
import './model/image_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Astronomy Picture of the Day",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.amber,
        primarySwatch: Colors.amber,
        accentColor: Colors.amber,
      ),
      home: ChangeNotifierProvider<ImageModel>(
        create: (context) => ImageModel(),
        child: HomePage(),
      ),
    );
  }
}
