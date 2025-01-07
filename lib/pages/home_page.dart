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
  int _selectedIndex = 0; // Индекс выбранной страницы

  @override
  void initState() {
    super.initState();
    futureSuppliers = Supplier.parseSuppliers("assets/supplier.json");
    futureReceipts = Receipt.parseReceipts("assets/receipt.json");
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем выбранный индекс
    });

    // Переход на соответствующую страницу при нажатии на элемент
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ApplicationPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShowApplicationsPage()), // Переход на страницу заявок
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
      ),
      body: FutureBuilder<List<Supplier>>(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Основная страница',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Регистрация',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Заявки', // Новый элемент для заявок
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
