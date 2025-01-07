import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class Customer {
  final String name;
  final String address;
  final String phoneNumber;
  final String inn;

  Customer({
    required this.name, 
    required this.address, 
    required this.phoneNumber, 
    required this.inn,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      inn: json['inn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'inn': inn,
    };
  }

  static Future<List<Customer>> parseCustomers(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Customer.fromJson(json)).toList();
  }

  static Future<void> saveToJson(Customer customer) async {
    // Получаем путь к директории приложения
    
    final filePath = 'assets/customer.json';

 
    List<Customer> customers = [];
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        customers = jsonData.map((json) => Customer.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error reading file: $e');
    }

    // Добавляем нового клиента в список
    customers.add(customer);

    // Сохраняем обновленный список в файл
    final String jsonString = json.encode(customers.map((c) => c.toJson()).toList());
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }
}

