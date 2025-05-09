class Sector {
  //.. Variabel
  final int id;
  final String name;

  //.. Constructor pada sectors untuk menyimpan data sektor
  Sector({
    required this.id,
    required this.name,
  });

  //.. Convert JSON ke Object
  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      id: json['id'],
      name: json['name_sectors'],
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
