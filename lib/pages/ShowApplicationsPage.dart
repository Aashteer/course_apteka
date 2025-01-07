import 'package:flutter/material.dart';

class ShowApplicationsPage extends StatelessWidget {
  const ShowApplicationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявки'),
      ),
      body: Center(
        child: const Text('Здесь будут ваши заявки.'),
      ),
    );
  }
}
