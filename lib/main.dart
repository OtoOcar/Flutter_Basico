import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/controllers/inventory_controller.dart';
import 'src/controllers/auth_controller.dart';

void main() {
  /*
    Se inyectan los controladores en toda la aplicación mediante MultiProvider.
    Esto permite que cualquier widget pueda acceder al estado de la app
      sin necesidad de manejar variables locales o usar setState.
    Se utiliza el patrón ChangeNotifier para implementar un manejo de estado reactivo.
  */

  runApp(
    MultiProvider(
      providers: [
        // Controlador encargado de gestionar el estado del inventario
        ChangeNotifierProvider(
          create: (_) => InventoryController(),
        ),

        // Controlador encargado de validar el inicio de sesión (login)
        ChangeNotifierProvider(
          create: (_) => AuthController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}