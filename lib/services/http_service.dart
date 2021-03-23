import 'package:dio/dio.dart';

class HttpService {
  Dio _dio;
  String baseUrl =
      "https://api.nasa.gov/planetary/apod?api_key=aWPhODExHc5j48m59viPzCysv1jkoaN7ID2dchPw&date=";

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    initializeInterceptors();
  }

  Future<Response> getImage(String date) async {
    Response response;
    try {
      response = await _dio.get(date);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(onError: (error) {
        print(error.message);
      }, onRequest: (request) {
        print("${request.path}");
      }, onResponse: (response) {
        print(response.data);
      }),
    );
  }
}
