import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:io'; // Necesario para cerrar la app con exit(0)
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    // Se obtiene el controlador de autenticación
    final authController = context.watch<AuthController>();

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

              // Muestra mensaje de error si existe
              if (authController.errorMessage != null)
                Text(
                  authController.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
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
                    // Valida usando el controlador
                    onPressed: () {
                      final user = userController.text;
                      final pass = passController.text;

                      final isValid = authController.login(user, pass);

                      // Si pasa validación, navega
                      if (isValid) {
                        // Se envía el usuario como parámetro en la navegación
                        context.go('/inventory', extra: user);
                      }
                    },
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

              const SizedBox(height: 20),

              // Botón para cerrar la aplicación
              TextButton(
                onPressed: () {
                  exit(0); // Finaliza completamente la app
                },
                child: const Text('Cerrar App'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
