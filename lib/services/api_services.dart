import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:rootnity_app/ui/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
  // .. Url API Laravel
  static final _dio = Dio(
    BaseOptions(
      baseUrl: "https://4d1c-2001-448a-10ed-23f0-6821-b906-1a48-e4f9.ngrok-free.app/api",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  // .. Method Get
  static Future<Response?> getData(String endpoint, context) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        CustomToast.show(context, "Tidak ada koneksi", "erros");
        return null;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      _dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : null;

      return await _dio.get(endpoint);
    } catch (e) {
      CustomToast.show(context, "Gagal mengambil data!", "error");
      return null;
    }
  }

  // .. Method Post
  static Future<Response?> postData(
      String endpoint, Map<String, dynamic> data, context) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        CustomToast.show(
            context, "Tidak ada koneksi! Coba lagi nanti.", "erros");
        return null;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      _dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : null;

      Response response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response;
      }
    } catch (e) {
      CustomToast.show(context, "Gagal mengirim data!", "error");
      return null;
    }
  }

  // .. Method Delete
  static Future<Response?> deleteData(String endpoint, context) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        CustomToast.show(
            context, "Tidak ada koneksi! Coba lagi nanti.", "erros");
        return null;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      _dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : null;

      return await _dio.delete(endpoint);
    } catch (e) {
      CustomToast.show(context, "Gagal menghapus data!", "error");
      return null;
    }
  }

  // .. Method berfungsi untuk mengatur headers, termasuk token jika ada
  /*static Future<String?> _setHeaders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    print("Token ${token}");

    // Menambahkan token jika user sudah login atau melakukan operasi CRUD pada Sector dan Devices

    return _dio.options.headers['Authorization'] =
        token != null ? 'Bearer $token' : null;
  }*/
}
