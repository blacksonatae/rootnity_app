class Sectors {
  int? id;
  final String name;

  //.. Buatkan constructor pada sektor untuk menyimpan data
  Sectors({
    this.id,
    required this.name,
  });

  //.. Konversi Json ke Object
  factory Sectors.fromJson(Map<String, dynamic> sector) {
    return Sectors(
      id: sector['id'] ?? 0,
      name: sector['name_sectors'] ?? '',
    );
  }

  //.. Konversi ke Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_sectors': name,
    };
  }
}
