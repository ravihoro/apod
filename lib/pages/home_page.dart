import 'package:apod/pages/image_page.dart';
import 'package:flutter/material.dart';
import '../utils/http_service.dart';
import 'package:provider/provider.dart';
import '../model/image_data.dart';
import '../model/image_model.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService http;
  DateTime date;
  double screenWidth = 768;

  @override
  void initState() {
    super.initState();
    http = HttpService();
    date = DateTime.now();
    loadImage(date);
  }

  _changeDate(BuildContext context) async {
    var imageModel = context.read<ImageModel>();
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: imageModel.date,
      firstDate: DateTime(1997),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != imageModel.date) {
      imageModel.date = pickedDate;
    }
  }

  loadImage(DateTime date) async {
    Response response;
    var imageModel = context.read<ImageModel>();
    try {
      response = await http.getImage(date.toIso8601String().substring(0, 10));
      if (response.statusCode == 200) {
        imageModel.image = ImageData.fromJson(response.data);
      } else {
        imageModel.image = null;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Consumer<ImageModel>(
          builder: (context, imageModel, child) {
            return AppBar(
              centerTitle: true,
              title: Text(
                'Astronomy Picture of the Day',
              ),
            );
          },
        ),
      ),
      bottomSheet: Consumer<ImageModel>(
        builder: (context, imageModel, child) {
          return Container(
            height: 50,
            color: Colors.grey[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    'Date: ${imageModel.date == null ? "N/A" : imageModel.date.toIso8601String().substring(0, 10)}',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    child: Text('Change Date'),
                    onPressed: () {
                      _changeDate(context);
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    child: Text('Find'),
                    onPressed: () {
                      imageModel.image = null;
                      loadImage(imageModel.date);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      body: ImagePage(),
    );
  }
}
