class Sector {
  //.. Variabel
  final int id;
  final String nameSector;

  //.. Constructor pada sectors untuk menyimpan data sektor
  Sector({
    required this.id,
    required this.nameSector,
  });

  //.. Convert JSON ke Object
  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'],
      nameSector: json['name_sector'],
    );
  }

  //.. Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_sector': nameSector,
    };
  }
}
