import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultScreen extends StatelessWidget {
  final File imageFile;
  final Map<String, dynamic> result;

  const ResultScreen({super.key, required this.imageFile, required this.result});

  @override
  Widget build(BuildContext context) {
    final String label = result['label'];
    final double confidence = result['confidence'];
    final double severity = result['severity'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(imageFile),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 10.0,
                        percent: confidence,
                        center: Text("${(confidence * 100).toStringAsFixed(1)}%"),
                        progressColor: Colors.green,
                        footer: const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text("Confidence"),
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 10.0,
                        percent: severity / 100,
                        center: Text("${severity.toStringAsFixed(1)}%"),
                        progressColor: Colors.red,
                        footer: const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text("Severity"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.medical_services, color: Colors.blue),
                              SizedBox(width: 8),
                              Text(
                                "Treatment Recommendation",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          // Placeholder logic for recommendations
                          if (label.contains("Healthy"))
                            const Text(
                                "No treatment needed. Keep maintaining good practices!")
                          else
                            const Text(
                                "1. Remove infected leaves immediately.\n2. Apply copper-based fungicide.\n3. Ensure better air circulation."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
