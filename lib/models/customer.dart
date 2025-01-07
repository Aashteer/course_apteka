import 'dart:convert';
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
}

