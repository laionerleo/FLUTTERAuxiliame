import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class DriverMainScreenOsm extends StatefulWidget {
  const DriverMainScreenOsm({super.key});

  @override
  State<DriverMainScreenOsm> createState() => _DriverMainScreenOsmState();
}

class _DriverMainScreenOsmState extends State<DriverMainScreenOsm> {
  String? _selectedAuxilio;
  final List<String> _tiposAuxilio = [
    'Carga de batería',
    'Sin gasolina',
    'Problema mecánico'
  ];
  MapController? _mapController;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Los permisos de ubicación están denegados permanentemente.'),
        ),
      );
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      _mapController?.move(
        LatLng(position.latitude, position.longitude),
        15,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa (OSM)'),
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
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition != null
                  ? LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude)
                  : const LatLng(0, 0), // Placeholder coordinates
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: _selectedAuxilio,
                  hint: const Text('Seleccione un tipo de auxilio'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAuxilio = newValue;
                    });
                  },
                  items: _tiposAuxilio
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_selectedAuxilio == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Por favor, seleccione un tipo de auxilio.'),
              ),
            );
          } else {
            // Simulate sending data to the backend
            print({
              "tipoAuxilio": _selectedAuxilio,
              "descripcion": "",
              "latitud": _currentPosition?.latitude ?? -17.783,
              "longitud": _currentPosition?.longitude ?? -63.182
            });
          }
        },
        label: const Text('Pedir Auxilio'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
