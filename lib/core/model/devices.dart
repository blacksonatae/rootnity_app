class Devices {
  final int id;
  final int sector_id;
  final String token_devices_user;

  //.. Constuctor pada sectors untuk menyimpan data sektor
  Devices({
    required this.id,
    required this.sector_id,
    required this.token_devices_user,
  });

  //.. Convert JSON ke Object
  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      id: json['id'] ?? 0,
      sector_id: json['name_sectors'] ?? '',
      token_devices_user: json['token_devices_user'] ?? '',
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sector_id': sector_id,
      'token_devices_user': token_devices_user,
    };
  }
}
