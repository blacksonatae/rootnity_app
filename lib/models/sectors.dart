import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Sectors {
  final int id;
  final String name;

  //.. Buatkan Constructor untuk menyimpan data lokal
  Sectors({required this.id, required this.name});

  //.. Convert JSON ke Object
  factory Sectors.fromJson(Map<String, dynamic> json) {
    return Sectors(
      id: json['id'] ?? 0,
      name: json['name_sectors'] ?? '',
    );
  }

  //.. Convert Object to Json
  Map<String, dynamic> toJson() {
    return {'id': id, 'name_sectors': name};
  }
}
