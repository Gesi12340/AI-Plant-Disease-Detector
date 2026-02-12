import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'database_helper.dart';

class SyncService {
  static final SyncService instance = SyncService._init();
  SyncService._init();

  bool _isSyncing = false;
  bool get isSyncing => _isSyncing;

  Future<void> performSync() async {
    if (_isSyncing) return;

    // 1. Check Connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.wifi) {
      print("Sync skipped: Wi-Fi not available");
      return;
    }

    _isSyncing = true;
    try {
      // 2. Fetch Unsynced Scans
      List<ScanResult> unsynced = await DatabaseHelper.instance.getUnsyncedScans();
      if (unsynced.isEmpty) {
        print("Nothing to sync");
        return;
      }

      print("Syncing ${unsynced.length} records...");

      // 3. Mock Upload Loop
      for (var scan in unsynced) {
        bool success = await _mockUpload(scan);
        if (success) {
          await DatabaseHelper.instance.markAsSynced(scan.id!);
        }
      }
      
      print("Sync completed successfully");
    } catch (e) {
      print("Sync failed: $e");
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _mockUpload(ScanResult scan) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real app, you would do something like:
    // final response = await http.post(
    //   Uri.parse('https://your-api.com/v1/sync'),
    //   body: jsonEncode(scan.toMap()),
    // );
    // return response.statusCode == 200;

    print("Mock uploaded scan: ${scan.diseaseName}");
    return true; // Assume success for mock
  }
}
