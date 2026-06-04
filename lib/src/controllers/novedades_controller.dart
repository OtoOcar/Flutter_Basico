import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Modelo de una novedad registrada
class Novedad {
  final File imagen;
  final String nota;
  final DateTime fecha;

  Novedad({required this.imagen, required this.nota, required this.fecha});
}

class NovedadesController extends ChangeNotifier {
  final List<Novedad> _novedades = [];
  final ImagePicker _picker = ImagePicker();

  List<Novedad> get novedades => _novedades;
  int get count => _novedades.length;

  // Tomar foto con la cámara y retornar el archivo
  Future<File?> tomarFoto() async {
    try {
      final XFile? foto = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (foto != null) return File(foto.path);
    } catch (e) {
      debugPrint('Error cámara: $e');
    }
    return null;
  }

  // Seleccionar imagen de la galería y retornar el archivo
  Future<File?> seleccionarDeGaleria() async {
    try {
      final XFile? foto = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (foto != null) return File(foto.path);
    } catch (e) {
      debugPrint('Error galería: $e');
    }
    return null;
  }

  // Agregar novedad a la lista
  void agregarNovedad(File imagen, String nota) {
    _novedades.insert(
      0,
      Novedad(
        imagen: imagen,
        nota: nota.trim().isEmpty ? 'Sin descripción' : nota.trim(),
        fecha: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  // Eliminar novedad por índice
  void eliminarNovedad(int index) {
    _novedades.removeAt(index);
    notifyListeners();
  }
}
