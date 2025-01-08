import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:course_new/models/customer.dart';
import 'package:course_new/models/invoice.dart'; // Импортируйте модель Invoice

class ShowApplicationsPage extends StatelessWidget {
  const ShowApplicationsPage({Key? key}) : super(key: key);

  Future<List<Invoice>> loadInvoices() async {
    return await Invoice.parseInvoices('assets/invoice.json');
  }

  Future<List<Customer>> loadCustomers() async {
    return await Customer.parseCustomers('assets/customer.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявки'),
      ),
      body: FutureBuilder<List<Invoice>>(
        future: loadInvoices(),
        builder: (context, invoiceSnapshot) {
          if (invoiceSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (invoiceSnapshot.hasError) {
            return Center(child: Text('Ошибка: ${invoiceSnapshot.error}'));
          } else if (!invoiceSnapshot.hasData || invoiceSnapshot.data!.isEmpty) {
            return const Center(child: Text('Нет заявок.'));
          }

          final invoices = invoiceSnapshot.data!;

          return FutureBuilder<List<Customer>>(
            future: loadCustomers(),
            builder: (context, customerSnapshot) {
              if (customerSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (customerSnapshot.hasError) {
                return Center(child: Text('Ошибка: ${customerSnapshot.error}'));
              } else if (!customerSnapshot.hasData || customerSnapshot.data!.isEmpty) {
                return const Center(child: Text('Нет клиентов.'));
              }

              final customers = customerSnapshot.data!;

              return ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  final invoice = invoices[index];
                  final customer = customers.firstWhere((c) => c.ID == invoice.customerID, orElse: () => Customer(name: 'Не найден', address: '', phoneNumber: '', inn: '', ID: ''));

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(customer.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Дата: ${invoice.date}'),
                          Text('Список медикаментов: ${invoice.medicineList.join(', ')}'),
                          Text('Цена: ${invoice.price}'),
                          Text('ID клиента: ${customer.ID}'),
                          Text('Адрес клиента: ${customer.address}'),
                          Text('Телефон клиента: ${customer.phoneNumber}'),
                          Text('ИНН клиента: ${customer.inn}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

