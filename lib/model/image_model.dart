import 'package:flutter/cupertino.dart';

import 'image_data.dart';

class ImageModel extends ChangeNotifier {
  ImageData _imageData;
  DateTime _date;

  set image(ImageData imageData) {
    _imageData = imageData;
    if (_date == null) {
      _date = DateTime.parse(_imageData.date);
    }
    notifyListeners();
  }

  set date(DateTime date) {
    _date = date;
    notifyListeners();
  }

  DateTime get date => _date;

  ImageData get image => _imageData;
}
