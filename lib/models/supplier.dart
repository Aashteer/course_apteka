import 'dart:convert';
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
}
