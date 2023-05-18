// import 'package:path/path.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// class DatabaseHelper {
//   static final _databaseName = 'mall.db';
//   static final _databaseVersion = 1;

//   static Database? _database;

//   DatabaseHelper._internal();

//   static final DatabaseHelper _instance = DatabaseHelper._internal();

//   factory DatabaseHelper() => _instance;

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final String databasePath = await getDatabasesPath();
//     final String path = join(databasePath, _databaseName);

//     return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('sql');
//   }

//   Future<void> close() async {
//     final Database db = await database;
//     db.close();
//   }
// }
