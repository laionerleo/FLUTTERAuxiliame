import 'package:auxiliame_app/screens/driver_main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Add logo here
            const Icon(Icons.lock, size: 100),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const DriverMainScreen(),
                ));
              },
              child: const Text('Ingresar'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement registration navigation
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
