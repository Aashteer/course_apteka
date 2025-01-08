import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class Supplier {
  final String name;
  final String address;
  final String phoneNumber;
  final String bank;
  final String accountNumber;
  final String inn;

  Supplier({
    required this.name, 
    required this.address, 
    required this.phoneNumber, 
    required this.bank,
    required this.accountNumber, 
    required this.inn,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      bank: json['bank'],
      accountNumber: json['accountNumber'],
      inn: json['inn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'bank': bank,
      'accountNumber': accountNumber,
      'inn': inn,
    };
  }

  static Future<List<Supplier>> parseSuppliers(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Supplier.fromJson(json)).toList();
  }

  static Future<void> saveToJson(Supplier supplier) async {
    // Получаем путь к директории приложения
    
    final filePath = 'assets/supplier.json';

 
    List<Supplier> suppliers = [];
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        suppliers = jsonData.map((json) => Supplier.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error reading file: $e');
    }

    // Добавляем нового клиента в список
    suppliers.add(supplier);

    // Сохраняем обновленный список в файл
    final String jsonString = json.encode(suppliers.map((c) => c.toJson()).toList());
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }

  static Future<Supplier> findByValue(String name) async {
    List<Supplier> suppliers = await parseSuppliers("assets/supplier.json");
    return suppliers.firstWhere(
      (supplier) => supplier.name == name,
      
    );
  }
}
