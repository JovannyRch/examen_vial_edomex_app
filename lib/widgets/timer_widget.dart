import 'package:flutter/material.dart';
import 'dart:async';

import 'package:guia_examen_de_licencia_de_conducir_edomex/const/colors.dart'; // Importa la clase Timer

class CustomTimer extends StatefulWidget {
  final int initialTimeInSeconds;
  final TextStyle? textStyle;
  final VoidCallback onTimeUp;

  const CustomTimer({
    required this.initialTimeInSeconds,
    this.textStyle,
    required this.onTimeUp,
  });

  @override
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  late int timeRemaining;
  bool isTimerRunning = true;
  Timer? _timer; // Almacena el temporizador

  @override
  void initState() {
    super.initState();
    timeRemaining = widget.initialTimeInSeconds;
    _startTimer();
  }

  // Iniciar el temporizador
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isTimerRunning) {
        if (timeRemaining > 0) {
          if (mounted) {
            // Verifica si el widget está montado
            setState(() => timeRemaining--);
          }
        } else {
          isTimerRunning = false;
          widget.onTimeUp(); // Ejecutar callback cuando el tiempo se agota
          _timer?.cancel(); // Detener el temporizador
        }
      }
    });
  }

  // Detener el temporizador
  void stopTimer() {
    setState(() => isTimerRunning = false);
    _timer?.cancel(); // Detener el temporizador
  }

  // Reiniciar el temporizador
  void resetTimer() {
    setState(() {
      timeRemaining = widget.initialTimeInSeconds;
      isTimerRunning = true;
    });
    _startTimer(); // Reiniciar el temporizador
  }

  // Formatear el tiempo en MM:SS
  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador cuando el widget se desmonta
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.timer,
          color: kMainColor,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          _formatTime(timeRemaining),
          style: widget.textStyle,
        ),
      ],
    );
  }
}
