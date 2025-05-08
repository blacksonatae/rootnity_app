class Device {
  //.. Variabel
  final int id;
  final int sectorsId;
  final String nameDevice;

  //.. Constructor pada Device untuk menyimpan data device
  Device({
    required this.id,
    required this.sectorsId,
    required this.nameDevice,
  });

  //.. Convert JSON to Object
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      sectorsId: json['sectors_id'],
      nameDevice: json['name_device'],
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sectors_id': sectorsId,
      'name_device': nameDevice,
    };
  }
}
