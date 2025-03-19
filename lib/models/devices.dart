import 'package:rootnity_app/models/wifi.dart';

class Devices {
  String? id;
  final String name;
  final String sectorsId;
  WiFi? wiFi;

  //.. Buatkan constructors pada devices untuk menyimpan data
  Devices({
    this.id,
    required this.name,
    required this.sectorsId,
    this.wiFi,
  });

  //.. Convert Json ke Object
  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      id: json['id'] ?? 0,
      name: json['name_sectors'] ?? '',
      sectorsId: json['sectors_id'] ?? 0,
    );
  }

  //.. Convert Object to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_sectors': name,
      'sectors_id': sectorsId,
    };
  }
}