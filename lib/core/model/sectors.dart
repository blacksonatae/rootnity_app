class Sectors {
  final int id;
  final String name;

  //.. Constuctor pada sectors untuk menyimpan data sektor
  Sectors({required this.id, required this.name});

  //.. Convert JSON ke Object
  factory Sectors.fromJson(Map<String, dynamic> json) {
    return Sectors(
      id: json['id'] ?? 0,
      name: json['name_sectors'] ?? '',
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_sectors': name,
    };
  }
}
