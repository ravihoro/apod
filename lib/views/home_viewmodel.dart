import 'package:stacked/stacked.dart';
import 'package:apod/services/http_service.dart';
import '../model/image_data.dart';
import 'package:dio/dio.dart';
import '../app/locator.dart';
import '../enums/viewstate.dart';

class HomeViewModel extends BaseViewModel {
  HttpService _httpService = locator<HttpService>();
  ViewState _state = ViewState.Loading;

  ViewState get state => _state;

  ImageData _imageData;
  DateTime _dateTime;

  ImageData get imageData => _imageData;
  DateTime get dateTime => _dateTime;

  set dateTime(DateTime date) {
    _dateTime = date;
    notifyListeners();
  }

  set imageData(ImageData imageData) {
    _imageData = imageData;
    notifyListeners();
  }

  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  loadImage(DateTime date) async {
    if (_dateTime == null) {
      _dateTime = date;
    }
    setState(ViewState.Loading);
    Response response;
    try {
      response =
          await _httpService.getImage(date.toIso8601String().substring(0, 10));
      if (response.statusCode == 200) {
        _imageData = ImageData.fromJson(response.data);
      } else {
        _imageData = null;
      }
      setState(ViewState.Idle);
    } on DioError catch (e) {
      print(e);
      setState(ViewState.Idle);
    }
  }
}
