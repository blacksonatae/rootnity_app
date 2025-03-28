import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static final _dio = Dio(
    BaseOptions(baseUrl: "", headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }),
  );

  //.. Method untuk menangani error response
  static Map<String, dynamic> handleError(DioException e) {
    if (e.response != null) {
      return {
        'status': false,
        'statusCode': e.response?.statusCode,
        'message': e.response?.data['message'] ?? 'Terjadi kesalahan',
        'errors': e.response?.data['errors'] ?? {},
      };
    } else {
      return {
        'status': false,
        'statusCode': null,
        'message': 'Gagal terhubung ke server. Periksa koneksi anda.',
        'errors': {},
      };
    }
  }

  //.. Method GET untuk mengambil data dari server
  static Future<Map<String, dynamic>> getData(String endpoint) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      _dio.options.headers['Authorization'] =
          token != null ? 'Bearer $token' : null;

      Response response = await _dio.get(endpoint);
      return {'status': true, 'data': response.data};
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  //.. Method POST untuk mengirim data ke server kemudian disimpan ke database
  static Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      _dio.options.headers['Authorization'] =
          token != null ? 'Bearer $token' : null;

      Response response = await _dio.post(endpoint, data: data);
      return {'status': true, 'data': response.data};
    } on DioException catch (e) {
      return handleError(e);
    }
  }
}
