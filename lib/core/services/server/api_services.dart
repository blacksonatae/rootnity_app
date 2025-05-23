import 'package:dio/dio.dart';
import 'package:rootnity_app/core/services/server/uri_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  //.. URI API Laravel
  static final _dio = Dio(
    BaseOptions(
      baseUrl: "${UriServices.uri_domain}/api",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  //.. Method GET untuk mengambil data dari server
  static Future<Response?> getData(String endPoint, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    _dio.options.headers['Authorization'] =
    token != null ? 'Bearer $token' : null;

    return await _dio.get(endPoint);
  }

  //.. Method POST untuk mengirim data ke server
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