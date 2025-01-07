import 'package:course_new/models/invoice.dart';
import 'package:flutter/material.dart';

class InvoiceForm extends StatefulWidget {
  const InvoiceForm({Key? key}) : super(key: key);

  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _medicineListController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  void _saveInvoice() {
    // Создание объекта Invoice
    final invoice = Invoice(
      name: _nameController.text,
      date: _dateController.text,
      medicineList: _medicineListController.text.split(','), // Разделение строки на список
      price: double.tryParse(_priceController.text) ?? 0.0, // Преобразование строки в double
      surname: _surnameController.text,
    );
    Invoice.saveToJson(invoice);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Название инвойса'),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Дата'),
          ),
          TextField(
            controller: _medicineListController,
            decoration: InputDecoration(labelText: 'Список лекарств (через запятую)'),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Цена'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _surnameController,
            decoration: InputDecoration(labelText: 'Фамилия'),
          ),
          ElevatedButton(
            onPressed: _saveInvoice,
            child: const Text('Сохранить'),
          )
        ],
      ),
    );
  }
}

