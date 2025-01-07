import 'package:course_new/models/customer.dart';
import 'package:flutter/material.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _innController = TextEditingController();

  void _saveCustomer() {
    // Здесь можно добавить логику сохранения данных
    final customer = Customer(
      name: _nameController.text,
      address: _addressController.text,
      phoneNumber: _phoneNumberController.text,
      inn: _innController.text,
    );
    Customer.saveToJson(customer);
   
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Имя клиента'),
          ),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Адрес клиента'),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Номер телефона'),
          ),
          TextField(
            controller: _innController,
            decoration: InputDecoration(labelText: 'ИНН'),
          ),
          ElevatedButton(
            onPressed: _saveCustomer,
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
