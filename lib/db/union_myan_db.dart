import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/he_activity_model.dart';
import '../models/patient_model.dart';

class UMDb {
  static final UMDb instance = UMDb._init();

  static Database? _database;

  UMDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('union_myan.db');
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
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableHEActivity ( 
  ${HEActivityField.id} $idType, 
  ${HEActivityField.date} $textType,
  ${HEActivityField.address} $textType,
  ${HEActivityField.volunteer} $textType,
  ${HEActivityField.heAttendeesList} $textType,
  ${HEActivityField.male} $integerType,
  ${HEActivityField.female} $integerType
  )
''');

    await db.execute('''
CREATE TABLE $tablePatient ( 
  ${PatientField.id} $idType, 
  ${PatientField.name} $textType,
  ${PatientField.sex} $textType,
  ${PatientField.age} $integerType,
  ${PatientField.referDate} $textType,
  ${PatientField.township} $textType,
  ${PatientField.address} $textType,
  ${PatientField.referFrom} $textType,
  ${PatientField.referTo} $textType,
  ${PatientField.signAndSymptom} $textType
  )
''');
  }

  Future<HEActivity> create(HEActivity heActivity) async {
    final db = await instance.database;

    final id = await db.insert(tableHEActivity, heActivity.toJson());
    return heActivity.copy(id: id);
  }

  Future<Patient> createPatient(Patient patient) async {
    final db = await instance.database;

    final id = await db.insert(tablePatient, patient.toJson());
    return patient.copy(id: id);
  }

  Future<HEActivity> readHEActivity(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableHEActivity,
      columns: HEActivityField.values,
      where: '${HEActivityField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return HEActivity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Patient> readPatient(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePatient,
      columns: PatientField.values,
      where: '${PatientField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Patient.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<HEActivity>> readAllHEActivities() async {
    final db = await instance.database;

    final result = await db.query(tableHEActivity);

    return result.map((json) => HEActivity.fromJson(json)).toList();
  }

  Future<List<Patient>> readAllPatients() async {
    final db = await instance.database;

    final result = await db.query(tablePatient);

    return result.map((json) => Patient.fromJson(json)).toList();
  }

  Future<int> update(HEActivity heActivity) async {
    final db = await instance.database;

    return db.update(
      tableHEActivity,
      heActivity.toJson(),
      where: '${HEActivityField.id} = ?',
      whereArgs: [heActivity.id],
    );
  }

  Future<int> updatePatient(Patient patient) async {
    final db = await instance.database;

    return db.update(
      tablePatient,
      patient.toJson(),
      where: '${PatientField.id} = ?',
      whereArgs: [patient.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableHEActivity,
      where: '${HEActivityField.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePatient(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablePatient,
      where: '${PatientField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
