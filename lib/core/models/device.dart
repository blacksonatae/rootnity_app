class Device {
  //.. Variabel
  final int id;
  final String name;
  /*final String token;
  final bool isOnline;
  final bool isActiveAI;*/
  final int sectorId;

  //.. Constructor pada Device untuk menyimpan data device
  Device({
    required this.id,
    required this.name,
    /*required this.token,
    this.isOnline = false,
    this.isActiveAI = false,*/
    required this.sectorId,
  });

  //.. Convert JSON to Object
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name_devices'],
      /*token: json['token'],
      isOnline: json['is_online'],
      isActiveAI: json['is_active_ai'],*/
      sectorId: json['sectors_id'],
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_devices': name,
      /*'token': token,
      'is_online': isOnline,
      'is_active_ai': isActiveAI,*/
      'sectors_id': sectorId,
    };
  }
}
