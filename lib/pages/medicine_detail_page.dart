import 'package:course_new/models/receipt.dart';
import 'package:course_new/models/supplier.dart';
import 'package:flutter/material.dart';
import 'package:course_new/models/medicine.dart';

class MedicineDetailPage extends StatelessWidget {
  final Medicine medicine;

  MedicineDetailPage({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  Future<Supplier?> _fetchSupplier() async {
    return await Supplier.findByValue(medicine.supplier);
  }

  Future<Receipt?> _fetchReceipt() async {
    return await Receipt.findByValue(medicine.receipt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Supplier?>(
          future: _fetchSupplier(),
          builder: (context, supplierSnapshot) {
            if (supplierSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (supplierSnapshot.hasError) {
              return Center(child: Text('Ошибка при загрузке поставщика: ${supplierSnapshot.error}'));
            } else if (!supplierSnapshot.hasData || supplierSnapshot.data == null) {
              return const Center(child: Text('Поставщик не найден.'));
            }

            final supplier = supplierSnapshot.data!;

            // Используем второй FutureBuilder для загрузки данных о получении
            return FutureBuilder<Receipt?>(
              future: _fetchReceipt(),
              builder: (context, receiptSnapshot) {
                if (receiptSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (receiptSnapshot.hasError) {
                  return Center(child: Text('Ошибка при загрузке чека: ${receiptSnapshot.error}'));
                } else if (!receiptSnapshot.hasData || receiptSnapshot.data == null) {
                  return const Center(child: Text('Чек не найден.'));
                }

                final receipt = receiptSnapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: ${medicine.category}'),
                    Text('Date: ${medicine.date}'),
                    Text('Expiration Date: ${medicine.expdate}'),
                    Text('Registration Number: ${medicine.registrationNumber}'),
                    Text('Manufacturer: ${medicine.manufacturer}'),
                    Text('Packaging Type: ${medicine.packagingType}'),
                    Text('Supplier Name: ${supplier.name}'), 
                    Text('Supplier Address: ${supplier.address}'),
                    Text('Supplier Phone: ${supplier.phoneNumber}'),
                    Text('Supplier Bank: ${supplier.bank}'),
                    Text('Supplier Account Number: ${supplier.accountNumber}'), 
                    Text('Supplier INN: ${supplier.inn}'), 
                    Text('Receipt Number: ${receipt.number}'), 
                    Text('Receipt Date: ${receipt.date}'), 
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
