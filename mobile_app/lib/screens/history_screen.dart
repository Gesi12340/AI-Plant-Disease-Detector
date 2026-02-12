import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/database_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<ScanResult>> _scansFuture;

  @override
  void initState() {
    super.initState();
    _refreshScans();
  }

  void _refreshScans() {
    setState(() {
      _scansFuture = DatabaseHelper.instance.readAllScans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.diseaseTrends),
      ),
      body: Column(
        children: [
          // Basic Trend Chart
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<ScanResult>>(
              future: _scansFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(AppLocalizations.of(context)!.noDataChart));
                }
                final data = snapshot.data!;
                // Simplified: Plot severity over time (index)
                return LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: data
                            .asMap()
                            .entries
                            .map((e) => FlSpot(
                                e.key.toDouble(), e.value.severity))
                            .toList(),
                        isCurved: true,
                        color: Colors.redAccent,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder<List<ScanResult>>(
              future: _scansFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(AppLocalizations.of(context)!.noHistory));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final scan = snapshot.data![index];
                    return ListTile(
                      leading: Image.file(
                        File(scan.imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (c, o, s) => const Icon(Icons.broken_image),
                      ),
                      title: Text(scan.diseaseName),
                      subtitle: Text(
                          "Sev: ${scan.severity}% • ${scan.timestamp.toString().substring(0, 10)}"),
                      trailing: Icon(
                        Icons.circle,
                        color: scan.diseaseName.contains("Healthy")
                            ? Colors.green
                            : Colors.red,
                        size: 12,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
