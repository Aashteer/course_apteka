import 'dart:convert';
import 'package:flutter/services.dart';

class Receipt {
  final String number;
  final String date;
  final List<String> medicineList;

  Receipt({
    required this.number, 
    required this.date, 
    required this.medicineList,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      number: json['number'],
      date: json['date'],
      medicineList: List<String>.from(json['medicineList']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'date': date,
      'medicineList': medicineList,
    };
  }

  static Future<List<Receipt>> parseReceipts(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Receipt.fromJson(json)).toList();
  }
}
