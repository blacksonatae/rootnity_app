class Sectors {
  int? id;
  final String name;

  //.. Buatkan constructor pada sectors untuk menyimpan data
  Sectors({
    this.id,
    required this.name,
  });

  //.. Convert Json ke Object
  factory Sectors.fromJson(Map<String, dynamic> json) {
    return Sectors(
      id: json['id'],
      name: json['name_sectors'] ?? '',
    );
  }

  //.. Convert Object to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_sectors': name,
    };
  }
}