import 'dart:convert';
import 'package:flutter/services.dart';

class Medicine {
  final String name;
  final String category;
  final String date;
  final String expdate;
  final String registrationNumber;
  final String manufacturer;
  final String packagingType;

  Medicine({
    required this.name, 
    required this.category, 
    required this.date, 
    required this.expdate,
    required this.registrationNumber, 
    required this.manufacturer, 
    required this.packagingType,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      category: json['category'],
      date: json['date'],
      expdate: json['expdate'],
      registrationNumber: json['registrationNumber'],
      manufacturer: json['manufacturer'],
      packagingType: json['packagingType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'date': date,
      'expdate': expdate,
      'registrationNumber': registrationNumber,
      'manufacturer': manufacturer,
      'packagingType': packagingType,
    };
  }

  static Future<List<Medicine>> parseMedicines(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Medicine.fromJson(json)).toList();
}
}