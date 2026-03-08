import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Inventario Bodega Segunda',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Aplicación desarrollada en Flutter para registrar inventarios mediante códigos QR.',
            ),

            SizedBox(height: 15),

            Text('Versión: 1.0'),

            SizedBox(height: 10),

            Text('Autor: Óscar López'),

            SizedBox(height: 10),

            Text('Proyecto académico - 2026'),
          ],
        ),
      ),
    );
  }
}