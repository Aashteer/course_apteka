import 'package:course_new/models/supplier.dart';
import 'package:flutter/material.dart';

class SupplierForm extends StatefulWidget {
  const SupplierForm({Key? key}) : super(key: key);

  @override
  _SupplierFormState createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _innController = TextEditingController();

  void _saveSupplier() {
    // Здесь можно добавить логику сохранения данных
    final supplier = Supplier(
      name: _nameController.text,
      address: _addressController.text,
      phoneNumber: _phoneNumberController.text,
      bank: _bankController.text,
      accountNumber: _accountNumberController.text,
      inn: _innController.text,
    );

    Supplier.saveToJson(supplier);
    
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Поставщик'),
          ),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Адрес поставщика'),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Номер телефона'),
          ),
          TextField(
            controller: _bankController,
            decoration: InputDecoration(labelText: 'Банк'),
          ),
          TextField(
            controller: _accountNumberController,
            decoration: InputDecoration(labelText: 'Номер счёта'),
          ),
          TextField(
            controller: _innController,
            decoration: InputDecoration(labelText: 'ИНН'),
          ),
          ElevatedButton(
            onPressed: _saveSupplier,
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
