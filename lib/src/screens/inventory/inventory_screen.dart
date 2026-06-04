import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:io'; // Necesario para exit(0)
import '../../controllers/inventory_controller.dart';

/*
// Pantalla de inventario
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});
*/

// Pantalla de inventario capturando Nombre de Usuario
class InventoryScreen extends StatefulWidget {
  final String usuario;

  const InventoryScreen({super.key, required this.usuario});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // Controladores de texto
  final TextEditingController locationController = TextEditingController();
  final TextEditingController qrController = TextEditingController();

  // Control de foco para el campo QR
  final FocusNode qrFocusNode = FocusNode();

  // Diálogo de confirmación para guardar datos
  void saveData(BuildContext context, InventoryController controller) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmación'),
        content: const Text('¿Desea guardar los datos leídos hasta ahora?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result == true) {
      // Aquí en el futuro puedes exportar a CSV antes de limpiar
      controller.reset();
      qrController.clear();
      locationController.clear();
    }
  }

  // Diálogo de confirmación para limpiar datos
  void confirmReset(InventoryController controller) async {
    final result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmación'),
        content: const Text(
          '¿Desea limpiar los datos? \nSe perderán las lecturas actuales.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Limpiar'),
          ),
        ],
      ),
    );

    // Si el usuario confirma, se limpia el estado
    if (result == true) {
      controller.reset();
      qrController.clear();
      locationController.clear();
    }
  }

  @override
  void dispose() {
    // Liberación de memoria (buena práctica obligatoria)
    locationController.dispose();
    qrController.dispose();
    qrFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Escucha cambios del controlador
    final controller = context.watch<InventoryController>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        // Título con icono y nombre de usuario
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, // centra verticalmente
          children: [
            Row(
              children: const [
                Icon(Icons.inventory_2, size: 20),
                SizedBox(width: 8),
                Text('Inventario Segundas', style: TextStyle(fontSize: 24)),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              'Usuario ${widget.usuario}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),

        // Menú de navegación
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') context.push('/settings');
              if (value == 'theme') context.push('/theme');
              if (value == 'language') context.push('/language');
              if (value == 'profile') context.push('/profile');
              if (value == 'novedades') context.push('/novedades');
              if (value == 'about') context.push('/about');
              if (value == 'logout') context.go('/');
              if (value == 'exit') exit(0);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'settings', child: Text('Configuración')),
              PopupMenuItem(value: 'theme', child: Text('Temas')),
              PopupMenuItem(value: 'language', child: Text('Idioma')),
              PopupMenuItem(value: 'profile', child: Text('Perfil')),
              PopupMenuItem(value: 'novedades', child: Text('Novedades')),
              PopupMenuItem(value: 'about', child: Text('Acerca de')),
              PopupMenuItem(value: 'logout', child: Text('Cerrar sesión')),
              PopupMenuItem(value: 'exit', child: Text('Cerrar App')),
            ],
          ),
        ],
      ),

      //Cuerpo
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Selector de vuelta de inventario
            // Se usa initialValue en lugar de value (según nuevas versiones de Flutter)
            SizedBox(
              width: double.infinity, // Ocupa todo el ancho disponible
              child: DropdownButtonFormField<String>(
                key: ValueKey(
                  controller.selectedRound,
                ), // Fuerza reconstrucción al cambiar
                initialValue: controller
                    .selectedRound, // Valor inicial (reemplaza 'value' deprecado)
                decoration: const InputDecoration(
                  labelText: 'Seleccione vuelta',
                  border: OutlineInputBorder(),
                ),
                items: controller.rounds.map((round) {
                  return DropdownMenuItem(value: round, child: Text(round));
                }).toList(),
                onChanged: (value) {
                  controller.changeRound(value!);
                },
              ),
            ),

            const SizedBox(height: 20),

            // Campo ubicación
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Ubicación',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Campo QR
            TextField(
              controller: qrController,
              focusNode: qrFocusNode,
              decoration: const InputDecoration(
                labelText: 'Lectura QR',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                controller.addQr(value);
                qrController.clear();
                FocusScope.of(context).requestFocus(qrFocusNode);
              },
            ),

            const SizedBox(height: 20),

            // Contador con Card personalizado
            Center(
              child: Card(
                elevation: 4, // Sombra del card
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Cantidad de QR leídos'),
                      const SizedBox(height: 10),
                      Text(
                        '${controller.qrCount}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Historial de QR leídos
            const Text(
              'Historial de lecturas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Lista dinámica
            // Contenedor del historial de lecturas
            SizedBox(
              height: 200, // altura fija para evitar que crezca indefinidamente
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Borde personalizado
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // Esquinas redondeadas
                ),
                child: controller.qrList.isEmpty
                    // Mensaje cuando no hay datos
                    ? const Center(child: Text('No hay lecturas registradas'))
                    // Lista de QR leídos
                    : ListView.builder(
                        itemCount: controller.qrList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true, // hace la lista más compacta
                            leading: const Icon(Icons.qr_code),
                            title: Text(controller.qrList[index]),
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // Botones
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => saveData(context, controller),
                    child: const Text('Guardar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => confirmReset(controller),
                    child: const Text('Limpiar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
