import 'dart:convert';
import 'package:flutter/services.dart';

class Invoice {
  final String name;
  final String date;
  final List<String> medicineList;
  final double price;
  final String surname;

  Invoice({
    required this.name,
    required this.date,
    required this.medicineList,
    required this.price,
    required this.surname,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      name: json['name'],
      date: json['date'],
      medicineList: List<String>.from(json['medicineList']),
      price: json['price'].toDouble(),
      surname: json['surname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'medicineList': medicineList,
      'price': price,
      'surname': surname,
    };
  }

  static Future<List<Invoice>> parseInvoices(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Invoice.fromJson(json)).toList();
  }
}
