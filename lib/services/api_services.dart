import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  //.. Url API Laravel
  static final _dio = Dio(
<<<<<<< HEAD
    BaseOptions(baseUrl: "https://1fb3-116-90-214-39.ngrok-free.app/api", headers: {
=======
    BaseOptions(baseUrl: "https://e40f-2001-448a-10ed-23f0-1ccc-de68-4909-d053.ngrok-free.app/api", headers: {
>>>>>>> a335fe51410725e807fe0ea011dff5f6bf2bedcd
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
