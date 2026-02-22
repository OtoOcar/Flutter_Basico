import 'package:flutter/material.dart';
import '../../app.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cambiar Tema')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'Seleccione el tema',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                MyApp.themeNotifier.value = ThemeMode.dark;
              },
              child: const Text('Tema Oscuro'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                MyApp.themeNotifier.value = ThemeMode.light;
              },
              child: const Text('Tema Claro'),
            ),
          ],
        ),
      ),
    );
  }
}