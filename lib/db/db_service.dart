import 'dart:io';
import 'dart:typed_data';
import 'package:engineering_db/model/word_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DbService {
  static final String _tbName = "engineers";
  static late Database _database;
  static Future<void> init() async {
    try {
      Directory docDirectory = await getApplicationDocumentsDirectory();
      File dbFile = File("${docDirectory.path}/engineering.db");
      if (!dbFile.existsSync()) {
        ByteData assetFile = await rootBundle.load("assets/engineering.db");
        ByteBuffer buffer = assetFile.buffer;
        await dbFile.writeAsBytes(
          buffer.asUint8List(assetFile.offsetInBytes, assetFile.lengthInBytes),
        );
      }
      _database = await openDatabase(dbFile.path);
    } catch (_) {
      //
    }
  }

  static Future<List<WordModel>> searchWord(String keyword) async {
    List<Map<String, dynamic>> queryList = await _database
        .rawQuery('SELECT * FROM $_tbName WHERE eng LIKE "$keyword%" ');
    return queryList.map((e) {
      return WordModel.fromMap(e);
    }).toList();
  }

  static Future<void> updateFavourite(int fav, int id) async {
    await _database
        .execute('UPDATE $_tbName SET favourite = $fav where id = $id');
  }

  static Future<List<WordModel>> initialWordList() async {
    List<Map<String, dynamic>> queryList =
        await _database.rawQuery('SELECT * FROM $_tbName LIMIT 20');
    return queryList.map((e) {
      return WordModel.fromMap(e);
    }).toList();
  }

  static Future<List<WordModel>> getFavWords() async {
    List<Map<String, dynamic>> queryList =
        await _database.rawQuery('SELECT * FROM $_tbName WHERE favourite = 1');
    return queryList.map((e) {
      return WordModel.fromMap(e);
    }).toList();
  }
}
