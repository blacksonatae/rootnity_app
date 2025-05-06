import 'Device.dart';

class Sector {
  //.. Variabel
  final int id;
  final String nameSectors;
  final List<Device>? devices;

  //.. Constructor pada sectors untuk menyimpan data sektor
  Sector({
    required this.id,
    required this.nameSectors,
    this.devices,
  });

  //.. Convert JSON ke Object
  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'],
      nameSectors: json['name_sectors'],
      devices: json['devices'] != null
          ? (json['devices'] as List)
              .map((device) => Device.fromJson(device))
              .toList()
          : null,
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_sectors': nameSectors,
      'devices': devices?.map((device) => device.toJson()).toList(),
    };
  }
}
