import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import '../../controllers/novedades_controller.dart';

// Pantalla principal — muestra la cuadrícula de novedades
class NovedadesScreen extends StatelessWidget {
  const NovedadesScreen({super.key});

  // Muestra opciones: cámara o galería
  void _mostrarOpciones(BuildContext context, NovedadesController controller) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar foto'),
              onTap: () async {
                Navigator.pop(context);
                // Espera la foto antes de navegar
                final imagen = await controller.tomarFoto();
                if (imagen != null && context.mounted) {
                  // Navega a pantalla de nota pasando la imagen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _PantallaAgregarNota(
                        imagen: imagen,
                        controller: controller,
                      ),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Seleccionar de galería'),
              onTap: () async {
                Navigator.pop(context);
                // Espera la imagen antes de navegar
                final imagen = await controller.seleccionarDeGaleria();
                if (imagen != null && context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _PantallaAgregarNota(
                        imagen: imagen,
                        controller: controller,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Confirmar eliminación de una novedad
  void _confirmarEliminar(
    BuildContext context,
    NovedadesController controller,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar novedad'),
        content: const Text('¿Desea eliminar este registro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              controller.eliminarNovedad(index);
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  // Ver imagen en pantalla completa con zoom y opción de compartir
  void _verImagenCompleta(BuildContext context, Novedad novedad) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: Text(novedad.nota),
            actions: [
              // Botón para compartir la imagen
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Share.shareXFiles([
                    XFile(novedad.imagen.path),
                  ], text: 'Novedad: ${novedad.nota}');
                },
              ),
            ],
          ),
          // InteractiveViewer permite hacer zoom con los dedos
          body: Center(
            child: InteractiveViewer(child: Image.file(novedad.imagen)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NovedadesController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Novedades')),

      // Botón flotante para agregar nueva novedad
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarOpciones(context, controller),
        child: const Icon(Icons.add_a_photo),
      ),

      // Si no hay novedades muestra mensaje, si hay muestra cuadrícula
      body: controller.novedades.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No hay novedades registradas',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Toca el botón + para agregar una',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Mensaje de ayuda visible solo cuando hay novedades
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: Colors.amber.withOpacity(0.15),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Mantén presionada una foto para eliminarla',
                        style: TextStyle(fontSize: 12, color: Colors.amber),
                      ),
                    ],
                  ),
                ),
                // Cuadrícula de novedades
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: controller.novedades.length,
                    itemBuilder: (context, index) {
                      final novedad = controller.novedades[index];
                      return GestureDetector(
                        onTap: () => _verImagenCompleta(context, novedad),
                        onLongPress: () =>
                            _confirmarEliminar(context, controller, index),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(novedad.imagen, fit: BoxFit.cover),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  color: Colors.black54,
                                  child: Text(
                                    novedad.nota,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

// Pantalla dedicada para agregar la nota a la imagen capturada
// Esto evita problemas con diálogos que se pierden al volver de la cámara
class _PantallaAgregarNota extends StatefulWidget {
  final File imagen;
  final NovedadesController controller;

  const _PantallaAgregarNota({required this.imagen, required this.controller});

  @override
  State<_PantallaAgregarNota> createState() => _PantallaAgregarNotaState();
}

class _PantallaAgregarNotaState extends State<_PantallaAgregarNota> {
  final TextEditingController _notaController = TextEditingController();

  @override
  void dispose() {
    _notaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Novedad')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Vista previa de la imagen capturada
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(widget.imagen, height: 280, fit: BoxFit.cover),
            ),

            const SizedBox(height: 20),

            // Campo para describir la novedad
            TextField(
              controller: _notaController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ej: manga rota, mancha de grasa...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              autofocus: true, // Abre el teclado automáticamente
            ),

            const SizedBox(height: 24),

            // Botón guardar
            ElevatedButton.icon(
              onPressed: () {
                // Guarda la novedad en el controlador
                widget.controller.agregarNovedad(
                  widget.imagen,
                  _notaController.text,
                );
                // Regresa a la pantalla de novedades
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Guardar novedad'),
            ),
          ],
        ),
      ),
    );
  }
}
