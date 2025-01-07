import 'package:flutter/material.dart';

class ReceiptForm extends StatelessWidget {
  const ReceiptForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Название рецепта'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Ингредиенты'),
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
