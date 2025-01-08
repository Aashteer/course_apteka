import 'dart:convert';
import 'dart:io';
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

  static Future<void> saveToJson(Receipt receipt) async {
    // Получаем путь к директории приложения
    
    final filePath = 'assets/receipt.json';

 
    List<Receipt> receipts = [];
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final String contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        receipts = jsonData.map((json) => Receipt.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error reading file: $e');
    }

    // Добавляем нового клиента в список
    receipts.add(receipt);

    // Сохраняем обновленный список в файл
    final String jsonString = json.encode(receipts.map((c) => c.toJson()).toList());
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }

  static Future<Receipt> findByValue(String number) async {
    List<Receipt> receipts = await parseReceipts("assets/receipt.json");
    return receipts.firstWhere(
      (receipt) => receipt.number == number,
      
    );
  }
}
