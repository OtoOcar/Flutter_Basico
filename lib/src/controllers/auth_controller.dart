import 'package:flutter/material.dart';

// Controlador de autenticación básico
// Encargado de validar datos de entrada del login
class AuthController extends ChangeNotifier {

  // Mensaje de error para mostrar en la UI
  String? errorMessage;

  // Método que valida usuario y contraseña
  bool login(String user, String password) {
    // Limpia error previo
    errorMessage = null;

    // Validación: campos vacíos
    if (user.trim().isEmpty || password.trim().isEmpty) {
      errorMessage = 'Usuario y contraseña son obligatorios';
      notifyListeners();
      return false;
    }

    // Si pasa validación (por ahora siempre válido, no está conectado a ninguna bd aún)
    notifyListeners();
    return true;
  }
}