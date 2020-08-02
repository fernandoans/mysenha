import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mysenha/model/senha.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();

  factory DBHelper() => _instance;

  final String tableSenha = 'Senha';
  final String columnId = 'id';
  final String columnSite = 'site';
  final String columnUsuario = 'usuario';
  final String columnDica = 'dica';

  static Database _db;

  DBHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'senha.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE $tableSenha($columnId INTEGER PRIMARY KEY, $columnSite TEXT, $columnUsuario TEXT, $columnDica TEXT)");
  }

  Future<int> saveSenha(Senha senha) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableSenha, senha.toMap());
    return result;
  }

  Future<List> getAllSenhas() async {
    var dbClient = await db;
    var result = await dbClient.query(
      tableSenha, 
      columns: [columnId, columnSite, columnUsuario, columnDica],
      orderBy: columnSite);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableSenha'));
  }

  Future<Senha> getSenha(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableSenha,
        columns: [columnId, columnSite, columnUsuario,columnDica],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Senha.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteSenha(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableSenha, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateSenha(Senha senha) async {
    var dbClient = await db;
    return await dbClient.update(tableSenha, senha.toMap(), where: "$columnId = ?", whereArgs: [senha.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}