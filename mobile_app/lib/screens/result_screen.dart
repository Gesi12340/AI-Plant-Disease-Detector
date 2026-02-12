import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../services/database_helper.dart';

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
        title: Text(AppLocalizations.of(context)!.diagnosisResult),
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
                        footer: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(AppLocalizations.of(context)!.confidence),
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 10.0,
                        percent: severity / 100,
                        center: Text("${severity.toStringAsFixed(1)}%"),
                        progressColor: Colors.red,
                        footer: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(AppLocalizations.of(context)!.severity),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FutureBuilder<Map<String, String>?>(
                    future: DatabaseHelper.instance.getTreatment(label),
                    builder: (context, snapshot) {
                      final treatment = snapshot.data;
                      return Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.medical_services, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!.treatmentRecommendation,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              if (snapshot.connectionState == ConnectionState.waiting)
                                const Center(child: CircularProgressIndicator())
                              else if (treatment != null) ...[
                                Text(
                                  "Organic Remedie:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(treatment['organic']!),
                                const SizedBox(height: 12),
                                Text(
                                  "Chemical Treatment:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[700],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(treatment['chemical']!),
                              ] else ...[
                                Text(label.contains("Healthy")
                                    ? AppLocalizations.of(context)!.healthyPlantMessage
                                    : AppLocalizations.of(context)!.infectedPlantMessage),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
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
