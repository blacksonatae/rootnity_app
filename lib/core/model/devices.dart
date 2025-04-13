class Devices {
  final int id;
  final int sectors_id;
  final String name_device;

  //.. Constuctor pada sectors untuk menyimpan data sektor
  Devices({
    required this.id,
    required this.sectors_id,
    required this.name_device,
  });

  //.. Convert JSON ke Object
  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      id: json['id'],
      sectors_id: json['sectors_id'],
      name_device: json['name_device'],
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sector_id': sectors_id,
      'name_device': name_device,
    };
  }
}
