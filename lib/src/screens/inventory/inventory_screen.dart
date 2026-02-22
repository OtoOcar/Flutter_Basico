import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String selectedRound = 'Vuelta 1';
  int qrCount = 0;

  final TextEditingController locationController = TextEditingController();
  final TextEditingController qrController = TextEditingController();
  final FocusNode qrFocusNode = FocusNode();
  final List<String> rounds = ['Vuelta 1', 'Vuelta 2', 'Vuelta 3', 'Reconteo'];

  // Contador de entradas
  void addQr() {
    if (qrController.text.trim().isNotEmpty) {
      setState(() {
        qrCount++;
      });
      qrController.clear();

      //vuelve a enfocar automáticamente
      FocusScope.of(context).requestFocus(qrFocusNode);
    }
  }

  // Acción del botón "Limpiar" (y confirmar guardado)
  void refreshScreen() {
    setState(() {
      qrCount = 0;
      selectedRound = 'Vuelta 1';
    });
    qrController.clear();
    locationController.clear();
  }

  // Confirmación de guardado
  void saveData() async {
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
      refreshScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título
        title: const Text('Inventario Segundas'),

        // Menú desplegable con navegación
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') context.push('/settings');
              if (value == 'theme') context.push('/theme');
              if (value == 'language') context.push('/language');
              if (value == 'profile') context.push('/profile');
              if (value == 'logout') context.go('/');
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'settings', child: Text('Configuración')),
              PopupMenuItem(value: 'theme', child: Text('Temas')),
              PopupMenuItem(value: 'language', child: Text('Idioma')),
              PopupMenuItem(value: 'profile', child: Text('Perfil')),
              PopupMenuItem(value: 'logout', child: Text('Cerrar sesión')),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Selección de vuelta
            DropdownButtonFormField<String>(
              value: selectedRound,
              decoration: const InputDecoration(
                labelText: 'Seleccione vuelta',
                border: OutlineInputBorder(),
              ),
              items: rounds.map((round) {
                return DropdownMenuItem(value: round, child: Text(round));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRound = value!;
                });
              },
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

            // Campo lectura QR
            TextField(
              controller: qrController,
              focusNode: qrFocusNode,
              decoration: const InputDecoration(
                labelText: 'Lectura QR',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => addQr(),
            ),

            const SizedBox(height: 20),

            // Contador dinámico
            Center(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Cantidad de QR leídos',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$qrCount',
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

            // Botones guardar y limpiar
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: saveData,
                    child: const Text('Guardar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: refreshScreen,
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
