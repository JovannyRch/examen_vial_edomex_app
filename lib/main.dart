import 'package:flutter/material.dart';
import 'package:guia_examen_de_licencia_de_conducir_edomex/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Examen Víal Edomex',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
