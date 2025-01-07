import 'package:flutter/material.dart';

class SupplierForm extends StatelessWidget {
  const SupplierForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Название поставщика'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Адрес'),
          ),
          // Добавьте другие поля по необходимости
          ElevatedButton(
            onPressed: () {
              // Логика сохранения данных
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
