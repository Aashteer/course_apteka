import 'package:flutter/material.dart';
import 'package:course_new/models/supplier.dart';
import 'package:course_new/models/receipt.dart'; 

class SupplierDetailPage extends StatelessWidget {
  final Supplier supplier;
  final List<Receipt> receipts;

  const SupplierDetailPage({
    Key? key,
    required this.supplier,
    required this.receipts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supplier.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${supplier.address}'),
            Text('Phone: ${supplier.phoneNumber}'),
            Text('Bank: ${supplier.bank}'),
            Text('Account Number: ${supplier.accountNumber}'),
            Text('INN: ${supplier.inn}'),
            // Здесь можно добавить дополнительные данные о поставщике и рецептах
          ],
        ),
      ),
    );
  }
}

