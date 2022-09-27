import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuranDB {
  static Database? database;

  static initializeDatabase() async {
    var databasePath = await getDatabasesPath();

    var path = join(databasePath, 'quran.db');
    var exist = await databaseExists(path);
    if (!exist) {
      await copyDB(path);
    }
    database = await openDatabase(path);
  }

  static copyDB(path) async {
    ByteData fileData = await rootBundle.load(join('assets', 'quran.db'));
    List<int> bytes = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }

  static Future<List> retrive_sora() async {
    var db = database!;
    var sora = await db!.query(
      "sora",
      /*columns: ["soraid", "name", "name_english", "place"],
      where: "soraid = ?",
      whereArgs: [3],*/
    );
   return sora;
  }
  static Future<List> retrive_ayat(soraid) async {
    var db = database!;
    var sora = await db!.query(
      'aya',
      //columns: ["soraid", "name", "name_english", "place"],
      where: "soraid = ?",
      whereArgs: [soraid],
    );
    return sora;
  }
}
