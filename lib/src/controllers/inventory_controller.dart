import 'package:flutter/material.dart';

// Controlador de inventario
// Se encarga de manejar el estado de la aplicación
// usando ChangeNotifier para notificar cambios a la UI
class InventoryController extends ChangeNotifier {
  // Lista donde se almacenan los QR leídos
  final List<String> qrList = [];

  // Vuelta seleccionada
  String selectedRound = 'Vuelta 1';

  // Lista de opciones de vueltas
  final List<String> rounds = [
    'Vuelta 1',
    'Vuelta 2',
    'Vuelta 3',
    'Reconteo'
  ];

  // Getter para obtener la cantidad de QR
  int get qrCount => qrList.length;

  // Agrega un QR a la lista
  void addQr(String value) {
    if (value.trim().isNotEmpty) {
      qrList.insert(0, value); // El más reciente primero
      notifyListeners(); // Notifica a la UI
    }
  }

  // Limpia todos los datos
  void reset() {
    qrList.clear();
    selectedRound = 'Vuelta 1';
    notifyListeners();
  }

  // Cambia la vuelta seleccionada
  void changeRound(String value) {
    selectedRound = value;
    notifyListeners();
  }
}