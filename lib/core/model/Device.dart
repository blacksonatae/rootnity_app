class Device {
  //.. Variabel
  final int id;
  final int sectorsId;
  final String nameDevices;

  //.. Constructor pada Device untuk menyimpan data device
  Device({
    required this.id,
    required this.sectorsId,
    required this.nameDevices,
  });

  //.. Convert JSON to Object
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      sectorsId: json['sectors_id'],
      nameDevices: json['name_devices'],
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sector_id': sectorsId,
      'name_devices': nameDevices,
    };
  }
}
