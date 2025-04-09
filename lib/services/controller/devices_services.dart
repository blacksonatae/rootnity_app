import 'package:rootnity_app/services/api/api_services.dart';

class DevicesServices {
  //.. Websockets

  //.. Ambil data devices dari local jika ada

  //.. Fungsi untuk menyimpan data devices ke local storage


  //.. Fetch Devices dari API + Local SharedPreferences (Jika koneksi gagal)
  /*static Future<void> fetchSectors(context) async {
    try {
      var response = await ApiServices.getData('/sectors', context);
      if (response != null && response.statusCode == 200) {

      } else {

      }
    } catch (e) {
      
    }
  }*/
  //.. Fungsi untuk mengirim data baru ke server (menggunakan API)
  static Future<Map<String, dynamic>> createDevices(
      String nameDevices, String sectorId, context) async {
    var response = await ApiServices.postData(
      '/devices',
      {
        'name_devices': nameDevices,
        'sectors_id': sectorId,
      },
      context,
    );

    if (response != null && response.statusCode == 201) {
      //..
      return {'status': true};
    } else if (response != null && response.statusCode == 422) {
      return {'status': false, 'errors': response.data['errors']};
    } else {
      return {'status': false};
    }
  }
}
