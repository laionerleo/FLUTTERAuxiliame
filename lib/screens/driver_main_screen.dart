import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMainScreen extends StatefulWidget {
  const DriverMainScreen({super.key});

  @override
  State<DriverMainScreen> createState() => _DriverMainScreenState();
}

class _DriverMainScreenState extends State<DriverMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Opciones'),
            ),
            ListTile(
              title: const Text('Historial de pedidos'),
              onTap: () {
                // TODO: Implement navigation
              },
            ),
            ListTile(
              title: const Text('Chat IA'),
              onTap: () {
                // TODO: Implement navigation
              },
            ),
            ListTile(
              title: const Text('Finalizar pedido actual'),
              onTap: () {
                // TODO: Implement logic
              },
            ),
            ListTile(
              title: const Text('Perfil / cerrar sesión'),
              onTap: () {
                // TODO: Implement navigation
              },
            ),
          ],
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Placeholder coordinates
          zoom: 15,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement logic to create a new request
        },
        label: const Text('Pedir Auxilio'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
