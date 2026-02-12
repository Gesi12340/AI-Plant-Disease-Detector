import 'dart:io';
import 'dart:ui';
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
    final bool isHealthy = label.contains("Healthy");
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Image with gradient overlay
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: isHealthy ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(imageFile, fit: BoxFit.cover),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // Disease Label
                  Positioned(
                    bottom: 60,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isHealthy ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isHealthy ? '✅ Healthy' : '⚠️ Disease Detected',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
              child: Column(
                children: [
                  // Confidence & Severity Cards
                  Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          label: AppLocalizations.of(context)!.confidence,
                          value: confidence,
                          color: const Color(0xFF2E7D32),
                          icon: Icons.verified_rounded,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _MetricCard(
                          label: AppLocalizations.of(context)!.severity,
                          value: severity / 100,
                          color: const Color(0xFFC62828),
                          icon: Icons.warning_amber_rounded,
                          displayValue: "${severity.toStringAsFixed(1)}%",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Treatment Section
                  FutureBuilder<Map<String, String>?>(
                    future: DatabaseHelper.instance.getTreatment(label),
                    builder: (context, snapshot) {
                      final treatment = snapshot.data;
                      return Column(
                        children: [
                          // Organic Treatment
                          _TreatmentCard(
                            title: '🌿 Organic Remedy',
                            content: treatment?['organic'],
                            fallback: isHealthy 
                                ? AppLocalizations.of(context)!.healthyPlantMessage
                                : AppLocalizations.of(context)!.infectedPlantMessage,
                            color: const Color(0xFF2E7D32),
                            isLoading: snapshot.connectionState == ConnectionState.waiting,
                          ),
                          const SizedBox(height: 14),
                          // Chemical Treatment
                          _TreatmentCard(
                            title: '🧪 Chemical Treatment',
                            content: treatment?['chemical'],
                            fallback: isHealthy
                                ? 'No chemical treatment needed.'
                                : 'Apply copper-based fungicide.',
                            color: const Color(0xFF1565C0),
                            isLoading: snapshot.connectionState == ConnectionState.waiting,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Metric Card ---
class _MetricCard extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final IconData icon;
  final String? displayValue;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.displayValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 42.0,
            lineWidth: 8.0,
            percent: value.clamp(0.0, 1.0),
            center: Text(
              displayValue ?? "${(value * 100).toStringAsFixed(1)}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
            ),
            progressColor: color,
            backgroundColor: color.withOpacity(0.15),
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Treatment Card ---
class _TreatmentCard extends StatelessWidget {
  final String title;
  final String? content;
  final String fallback;
  final Color color;
  final bool isLoading;

  const _TreatmentCard({
    required this.title,
    required this.content,
    required this.fallback,
    required this.color,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Divider(color: color.withOpacity(0.2)),
          const SizedBox(height: 8),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Text(
              content ?? fallback,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
        ],
      ),
    );
  }
}
