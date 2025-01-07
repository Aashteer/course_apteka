import 'package:course_new/models/receipt.dart';
import 'package:flutter/material.dart';

class ReceiptForm extends StatefulWidget {
  const ReceiptForm({Key? key}) : super(key: key);

  @override
  _ReceiptFormState createState() => _ReceiptFormState();
}

class _ReceiptFormState extends State<ReceiptForm> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _medicineListController = TextEditingController();

  void _saveReceipt() {
    // Преобразование строки в список
    List<String> medicineList = _medicineListController.text.split(',').map((e) => e.trim()).toList();

    // Создание объекта Receipt
    final receipt = Receipt(
      number: _numberController.text,
      date: _dateController.text,
      medicineList: medicineList, // Теперь это список
    );

    // Вывод данных в консоль
    print(receipt.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _numberController,
            decoration: InputDecoration(labelText: 'Номер чека'),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Дата'),
          ),
          TextField(
            controller: _medicineListController,
            decoration: InputDecoration(labelText: 'Список лекарств (через запятую)'),
          ),
          ElevatedButton(
            onPressed: _saveReceipt,
            child: const Text('Сохранить'),
          )
        ],
      ),
    );
  }
}
