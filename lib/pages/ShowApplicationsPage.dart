import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:course_new/models/customer.dart'; // Импортируйте модель Customer

class ShowApplicationsPage extends StatelessWidget {
  const ShowApplicationsPage({Key? key}) : super(key: key);

  Future<List<Customer>> loadCustomers() async {
    return await Customer.parseCustomers('assets/customer.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявки'),
      ),
      body: FutureBuilder<List<Customer>>(
        future: loadCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет заявок.'));
          }

          final customers = snapshot.data!;

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(customer.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Адрес: ${customer.address}'),
                      Text('Телефон: ${customer.phoneNumber}'),
                      Text('ИНН: ${customer.inn}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
