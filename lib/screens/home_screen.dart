import 'package:flutter/material.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/screens/study_screen.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/screens/test_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen Vial Edomex'), // Título de la app
        centerTitle: true, // Centra el título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Botón para el Modo Estudio
            _homeButton('Guía de Estudio', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudyMode()),
              );
            }),
            const SizedBox(height: 20),
            _homeButton('Examen de prueba', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TestScreen()),
              );
            }),
            const SizedBox(height: 20),
            // Botón para el Examen
            _homeButton('Examen Final', () {}),
            const SizedBox(height: 20),
            _homeButton('Estadísticas', () {})
          ],
        ),
      ),
    );
  }

  Widget _homeButton(String text, void Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
