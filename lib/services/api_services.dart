import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  //.. Url API Laravel
  static final _dio = Dio(
    BaseOptions(baseUrl: "https://ed72-116-90-214-39.ngrok-free.app/api", headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }),
  );

  //.. Method Get
  static Future<Response?> getData(String endpoint, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    _dio.options.headers['Authorization'] =
    token != null ? 'Bearer $token' : null;

    return await _dio.get(endpoint);
  }

  //.. Method Post
  static Future<Response?> postData(
      String endpoint, Map<String, dynamic> data, context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      _dio.options.headers['Authorization'] =
      token != null ? 'Bearer $token' : null;

      Response response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response;
      }
    } catch (e) {
      return null;
    }
  }
}