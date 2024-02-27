import 'package:ecomerce_app_bloc/model/address_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../model/fav_,model.dart';

class DBHelperAddress {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db; // Return the _db instance.
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'address.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE address (
        id INTEGER PRIMARY KEY,
        address TEXT,
        mobile REAL
        
      )
    ''');
  }

  Future<AddressModel> insert(AddressModel address) async {
    var dbClient = await db;
    await dbClient!.insert('address', address.toJson());
    return address;
  }
  Future<List<AddressModel>> getAddress() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> queryResult = await dbClient!.query('address');
    return queryResult.map((e) => AddressModel.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('address', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAddress(AddressModel address) async {
    var dbClient = await db;
    return await dbClient!.update('address', address.toJson(),
        where: 'id = ?', whereArgs: [address.id]);
  }
}