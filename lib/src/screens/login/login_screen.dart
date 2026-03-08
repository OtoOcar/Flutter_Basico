import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo superior
              const Icon(Icons.inventory_2, size: 100),

              const SizedBox(height: 20),

              // Título
              const Text(
                'Inicio de Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // Campo usuario
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // Campo contraseña
              TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              // Mensaje informativo
              const Text(
                'Si olvidó su contraseña, por favor contacte a su supervisor.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              //Botón ingresar
              Center(
                child: SizedBox(
                  width: 125,
                  child: ElevatedButton(
                    onPressed: () => context.go('/inventory'),
                    child: const Text('Ingresar'),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              //Botón Acerca de
              TextButton.icon(
                onPressed: () {
                  context.push('/about');
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('Acerca de la aplicación'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
