import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('plant_disease.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE scans ( 
  _id $idType, 
  imagePath $textType,
  diseaseName $textType,
  confidence $realType,
  severity $realType,
  timestamp $textType
  )
''');
  }

  Future<int> create(ScanResult scan) async {
    final db = await instance.database;
    return await db.insert('scans', scan.toMap());
  }

  Future<List<ScanResult>> readAllScans() async {
    final db = await instance.database;
    final orderBy = 'timestamp DESC';
    final result = await db.query('scans', orderBy: orderBy);

    return result.map((json) => ScanResult.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

class ScanResult {
  final int? id;
  final String imagePath;
  final String diseaseName;
  final double confidence;
  final double severity;
  final DateTime timestamp;

  ScanResult({
    this.id,
    required this.imagePath,
    required this.diseaseName,
    required this.confidence,
    required this.severity,
    required this.timestamp,
  });

  Map<String, Object?> toMap() => {
        '_id': id,
        'imagePath': imagePath,
        'diseaseName': diseaseName,
        'confidence': confidence,
        'severity': severity,
        'timestamp': timestamp.toIso8601String(),
      };

  static ScanResult fromJson(Map<String, Object?> json) => ScanResult(
        id: json['_id'] as int?,
        imagePath: json['imagePath'] as String,
        diseaseName: json['diseaseName'] as String,
        confidence: json['confidence'] as double,
        severity: json['severity'] as double,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}
