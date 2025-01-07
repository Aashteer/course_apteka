import 'package:course_new/forms/customerForm.dart';
import 'package:course_new/forms/invoiceForm.dart';
import 'package:course_new/forms/medicineForm.dart';
import 'package:course_new/models/customer.dart';
import 'package:course_new/models/invoice.dart';
import 'package:course_new/models/medicine.dart';
import 'package:course_new/models/receipt.dart';
import 'package:course_new/models/supplier.dart';
import 'package:course_new/pages/ShowApplicationsPage.dart';
import 'package:course_new/pages/SupplierDetailPage.dart';
import 'package:course_new/pages/application_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Supplier>> futureSuppliers;
  late Future<List<Receipt>> futureReceipts;
  late Future<List<Medicine>> futureMedicines;
  late Future<List<Invoice>> futureInvoices;
  late Future<List<Customer>> futureCustomers;
  int _selectedIndex = 0; // Индекс выбранной страницы

  @override
  void initState() {
    super.initState();
    futureSuppliers = Supplier.parseSuppliers("assets/supplier.json");
    futureReceipts = Receipt.parseReceipts("assets/receipt.json");
    futureMedicines = Medicine.parseMedicines("assets/medicine.json");
    futureInvoices = Invoice.parseInvoices("assets/invoice.json");
    futureCustomers = Customer.parseCustomers("assets/customer.json");
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем выбранный индекс
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Основной экран с поставщиками и чеками
          FutureBuilder<List<Supplier>>(
            future: futureSuppliers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No suppliers found.'));
              }

              final suppliers = snapshot.data!;

              return FutureBuilder<List<Receipt>>(
                future: futureReceipts,
                builder: (context, receiptSnapshot) {
                  if (receiptSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (receiptSnapshot.hasError) {
                    return Center(child: Text('Error: ${receiptSnapshot.error}'));
                  } else if (!receiptSnapshot.hasData || receiptSnapshot.data!.isEmpty) {
                    return const Center(child: Text('No receipts found.'));
                  }

                  final receipts = receiptSnapshot.data!;

                  return ListView.builder(
                    itemCount: suppliers.length,
                    itemBuilder: (context, index) {
                      final supplier = suppliers[index];

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(supplier.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address: ${supplier.address}'),
                              Text('Phone: ${supplier.phoneNumber}'),
                              Text('Bank: ${supplier.bank}'),
                              Text('Account Number: ${supplier.accountNumber}'),
                              Text('INN: ${supplier.inn}'),
                            ],
                          ),
                          onTap: () {
                            // Переход на страницу деталей поставщика
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupplierDetailPage(
                                  supplier: supplier,
                                  receipts: receipts,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          // Форма для ввода клиента
          const CustomerForm(),
          // Форма для ввода лекарства
          const MedicineForm(),
          // Форма для ввода инвойса
          const InvoiceForm(),
          // Страница заявок
          const ShowApplicationsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Основная страница',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Форма клиента',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Форма лекарства',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Инвойсы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Заявки',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

