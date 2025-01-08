import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class Invoice {
  final String name;
  final String date;
  final List<String> medicineList;
  final double price;
  final String surname;
  final String customerID;

  Invoice({
    required this.name,
    required this.date,
    required this.medicineList,
    required this.price,
    required this.surname,
    required this.customerID
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      name: json['name'],
      date: json['date'],
      medicineList: List<String>.from(json['medicineList']),
      price: json['price'].toDouble(),
      surname: json['surname'],
      customerID: json['customerID']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'medicineList': medicineList,
      'price': price,
      'surname': surname,
      'customerID': customerID
    };
  }

  static Future<List<Invoice>> parseInvoices(String path) async {
    final String response = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Invoice.fromJson(json)).toList();
  }

  static Future<void> saveToJson(Invoice invoice) async {
    // Получаем путь к директории приложения
    
    final filePath = 'assets/invoice.json';

 
    List<Invoice> invoices = [];
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        invoices = jsonData.map((json) => Invoice.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error reading file: $e');
    }

    // Добавляем нового клиента в список
    invoices.add(invoice);

    // Сохраняем обновленный список в файл
    final String jsonString = json.encode(invoices.map((c) => c.toJson()).toList());
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }
  static Future<Invoice> findByValue(String ID) async {
    List<Invoice> invoices = await parseInvoices("assets/supplier.json");
    return invoices.firstWhere(
      (invoice) => invoice.customerID == ID,
      
    );
  }
}
