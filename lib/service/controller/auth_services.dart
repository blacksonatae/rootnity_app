import 'package:rootnity_app/service/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  //.. Method Login
  static Future<Map<String, dynamic>> login(
      String email, String password, context) async {
    var response = await APIServices.postData(
      '/login',
      {
        'email': email,
        'password': password,
      },
      context,
    );

    if (response != null && response.statusCode == 200) {
      var data = response.data['data'];
      //.. Informasi name, email, dan token akan masuk kedalam method AccountPreferences
      AccountPreferences(data['token'], data['name'], data['email']);
      return {
        'status': true
      }; //.. Status kondisi jika true maka halaman login bisa mengarah ke halaman home
    } else if (response != null && response.statusCode == 422 || response?.statusCode == 401) {
      return {
        'status': false,
        'errors': response?.data['errors']
      }; //.. Menampilkan pesan error pada masing masing textfield
    } else {
      return {
        'status': false
      }; //.. Malah sebaliknya jika false maka halaman home tidak dapat diarahkan
    }
  }

  //.. Method Register
  static Future<Map<String, dynamic>> register(String name, String email,
      String password, String confirmPassword, context) async {
    var response = await APIServices.postData(
      '/register',
      {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      },
      context,
    );

    if (response != null && response.statusCode == 201) {
      var data = response.data['data'];
      //.. Informasi name, email, dan token akan masuk kedalam method AccountPreferences
      AccountPreferences(data['token'], data['name'], data['email']);
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {
        'status': false,
        'errors': response.data['errors']
      }; //.. Menampilkan pesan error pada masing masing textfield
    } else {
      return {
        'status': false
      }; //.. Malah sebaliknya jika false maka halaman home tidak dapat diarahkan
    }
  }

  //.. Method SharedPreferences
  static void AccountPreferences(
      String token, String name, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', token);
    await preferences.setString('name', name);
    await preferences.setString('email', email);
  }

  //.. Logout
  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //.. Menghapus informasi akun seperti token, email, dan password
    await preferences.clear();
  }
}
