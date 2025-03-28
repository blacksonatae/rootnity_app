import 'package:rootnity_app/services/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  //.. Method untuk menyimpan informasi pengguna
  static Future<void> saveUserData(
      String token, String name, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('token', token);
    await preferences.setString('name', name);
    await preferences.setString('email', email);
  }

  //.. Method untuk mengambil informasi user
  static Future<Map<String, String?>> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return {
      'token': preferences.getString('token'),
      'name': preferences.getString('name'),
      'email': preferences.getString('email'),
    };
  }

  //.. Method Register Pengguna
  static Future<Map<String, dynamic>> register(String name, String email,
      String password, String confirmPassword) async {
    var response = await ApiServices.postData('/register', {
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    });

    if (response['status']) {
      var data = response['data']['data'];
      //.. Response data akan dimasukan kedalam local
      await saveUserData(data['token'], data['name'], data['email']);
      return {'status': true};
    } else {
      return {
        'status': false,
        'message': response['message'],
        'errors': response['errors'],
      };
    }
  }

  //.. Method Login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    var response = await ApiServices.postData('/login', {
      'email': email,
      'password': password,
    });
    if (response['status']) {
      var data = response['data']['data'];
      //.. Response data akan dimasukan kedalam local
      await saveUserData(data['token'], data['name'], data['email']);
      return {'status': true};
    } else {
      return {
        'status': false,
        'message': response['message'],
        'errors': response['errors'],
      };
    }
  }

  //.. Method Logout
  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //.. Menghapus semua data local
    await preferences.clear();
  }
}
