import 'package:rootnity_app/services/api_services.dart';
import 'package:rootnity_app/ui/widget/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {

  //.. Method login
  static Future<Map<String, dynamic>> login(String email, String password,
      context) async {
    var response = await APIServices.postData(
        '/login',
        {
          'email': email,
          'password': password,
        },
        context);

    if (response != null && response.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var data = response.data['data'];

      await preferences.setString('token', data['token']);
      await preferences.setString('name', data['name']);
      await preferences.setString('email', data['email']);

      CustomToast.show(context, "Login berhasil", "success");
      return {
        'status': true
      }; //.. Status kondisi jika true maka halaman login bisa mengarah ke halaman home
    } else if (response != null && response.statusCode == 401) {
      return {'status': false, 'errors': response.data['errors']}; //.. Menampilkan pesan error pada masing masing textfield
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']}; //.. Menampilkan pesan error pada masing masing textfield
    } else {
      CustomToast.show(
          context, "Registrasi gagal! Silahan coba lagi.", "error");

      return {
        'status': false
      }; //.. Malah sebaliknya jika false maka halaman home tidak dapat diarahkan
    }
  }

  //.. Method Register
  static Future<Map<String, dynamic>> register(String name, String email,
      String password, String confirmPassword, context) async {
    var response = await APIServices.postData('/register', {
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    }, context);

    if (response != null && response.statusCode == 201) {
      var data = response.data['data'];

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('token', data['token']);
      await preferences.setString('name', data['name']);
      await preferences.setString('email', data['email']);

      CustomToast.show(context, "Register berhasil!", "success");
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']};
    } else {
      CustomToast.show(
          context, "Registrasi gagal! Silahan coba lagi.", "error");
      return {'status': false};
    }
  }

  // .. Logout
  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}