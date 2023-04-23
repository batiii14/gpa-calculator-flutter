import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class AverageInfo extends StatelessWidget {
  const AverageInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final average = ModalRoute.of(context)?.settings.arguments as double?;

    String message = '';
    if (average != null) {
      if (average < 1.0) {
        message = 'Terrible!';
      } else if (average >= 1.0 && average < 2.0) {
        message = 'Not good';
      } else if (average >= 2.0 && average < 2.5) {
        message = 'You are doing okay';
      } else if (average >= 2.5 && average < 3.0) {
        message = 'Nice work!';
      } else if (average >= 3.0 && average <= 4.0) {
        message = 'Awesome';
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('BiCGPA'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 100, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'YOUR CGPA',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      shape: BoxShape.circle,
                    ),
                    child: PhysicalModel(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(100),
                      elevation: 10,
                      child: Center(
                        child: Text(
                          average?.toStringAsFixed(2) ?? '-',
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Overall Performance',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
