import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class Medicine {
  final String name;
  final String category;
  final String date;
  final String expdate;
  final String registrationNumber;
  final String manufacturer;
  final String packagingType;
  final String supplier;
  final String receipt;

  Medicine({
    required this.name, 
    required this.category, 
    required this.date, 
    required this.expdate,
    required this.registrationNumber, 
    required this.manufacturer, 
    required this.packagingType,
    required this.supplier,
    required this.receipt
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
      supplier: json['supplier'],
      receipt: json['receipt']
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
      'supplier': supplier,
      'receipt': receipt
    };
  }

  static Future<List<Medicine>> parseMedicines(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Medicine.fromJson(json)).toList();
}

static Future<void> saveToJson(Medicine medicine) async {
    // Получаем путь к директории приложения
    
    final filePath = 'assets/medicine.json';

 
    List<Medicine> medicines = [];
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        medicines = jsonData.map((json) => Medicine.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error reading file: $e');
    }

    // Добавляем нового клиента в список
    medicines.add(medicine);

    // Сохраняем обновленный список в файл
    final String jsonString = json.encode(medicines.map((c) => c.toJson()).toList());
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }
}