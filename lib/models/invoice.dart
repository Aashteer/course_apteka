import 'dart:convert';
import 'package:flutter/services.dart';

class Medicine {
  final String name;
  final String date;
  final List<String> medicineList;
  final double price;
  final String surname;

  Medicine({
    required this.name, 
    required this.date, 
    required this.medicineList,
    required this.price, 
    required this.surname,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      date: json['date'],
      medicineList: List<String>.from(json['medicineList']),
      price: json['price'].toDouble(),
      surname: json['surname'],
    );
  }

  get category => null;

  get manufacturer => null;

  get expdate => null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'medicineList': medicineList,
      'price': price,
      'surname': surname,
    };
  }

  static Future<List<Medicine>> parseMedicines(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Medicine.fromJson(json)).toList();
  }
}
