import 'package:course_new/forms/receiptForm.dart';
import 'package:course_new/forms/supplierForm.dart';
import 'package:flutter/material.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форма для ввода данных'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Поставщик'), // Переименовываем на 'Поставщик'
            Tab(text: 'Рецепт'),    // Переименовываем на 'Рецепт'
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SupplierForm(), // Используем новый виджет формы для поставщика
          ReceiptForm(),  // Используем новый виджет формы для рецепта
        ],
      ),
    );
  }
}
