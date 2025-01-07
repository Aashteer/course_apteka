import 'package:flutter/material.dart';
import 'package:course_new/models/medicine.dart';

class MedicineDetailPage extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailPage({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${medicine.category}'),
            Text('Date: ${medicine.date}'),
            Text('Expiration Date: ${medicine.expdate}'),
            Text('Registration Number: ${medicine.registrationNumber}'),
            Text('Manufacturer: ${medicine.manufacturer}'),
            Text('Packaging Type: ${medicine.packagingType}'),
            // Здесь можно добавить дополнительные данные о лекарстве
          ],
        ),
      ),
    );
  }
}
