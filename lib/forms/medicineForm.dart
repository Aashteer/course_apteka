import 'package:course_new/models/medicine.dart';
import 'package:flutter/material.dart';

class MedicineForm extends StatefulWidget {
  const MedicineForm({Key? key}) : super(key: key);

  @override
  _MedicineFormState createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _packagingTypeController = TextEditingController();
  final TextEditingController _supplierController = TextEditingController();
  final TextEditingController _receiptController = TextEditingController();

  void _saveMedicine() {
    // Создание объекта Medicine
    final medicine = Medicine(
      name: _nameController.text,
      category: _categoryController.text,
      date: _dateController.text,
      expdate: _expDateController.text,
      registrationNumber: _registrationNumberController.text,
      manufacturer: _manufacturerController.text,
      packagingType: _packagingTypeController.text,
      supplier: _supplierController.text,
      receipt: _receiptController.text
    );
    Medicine.saveToJson(medicine);
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Название лекарства'),
          ),
          TextField(
            controller: _categoryController,
            decoration: InputDecoration(labelText: 'Категория'),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Дата производства'),
          ),
          TextField(
            controller: _expDateController,
            decoration: InputDecoration(labelText: 'Срок годности'),
          ),
          TextField(
            controller: _registrationNumberController,
            decoration: InputDecoration(labelText: 'Регистрационный номер'),
          ),
          TextField(
            controller: _manufacturerController,
            decoration: InputDecoration(labelText: 'Производитель'),
          ),
          TextField(
            controller: _packagingTypeController,
            decoration: InputDecoration(labelText: 'Тип упаковки'),
          ),
          TextField(
            controller: _supplierController,
            decoration: InputDecoration(labelText: 'Поставщик'),
          ),
          TextField(
            controller: _receiptController,
            decoration: InputDecoration(labelText: 'Приходная накладная'),
          ),
          ElevatedButton(
            onPressed: _saveMedicine,
            child: const Text('Сохранить'),
          )
        ],
      ),
    );
  }
}
