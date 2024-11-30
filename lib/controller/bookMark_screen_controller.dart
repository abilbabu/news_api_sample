import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkScreenController with ChangeNotifier {
  static late Database database;
  List<Map<String, dynamic>> NewsStore = [];

  static Future initDb() async {
    database = await openDatabase("cartdb1.Db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, title TEXT, content TEXT, descrbtion TEXT, imageUrl TEXT, publishedAt DATE, url TEXT)');
    });
  }

  // Get all news from the Cart table
  Future getStoreNews() async {
    NewsStore = await database.rawQuery('SELECT * FROM Cart');
    log(NewsStore.toString());
    notifyListeners();
  }

  // Add news item to the database
  Future addNews(Map<String, dynamic> getNews) async {
    bool alreadyInCart = NewsStore.any((element) => getNews["id"] == element["id"]);
    if (alreadyInCart) {
      log("Already in cart");
    } else {
      await database.rawInsert(
        'INSERT INTO Cart(title, content, descrbtion, imageUrl, publishedAt, url) VALUES(?, ?, ?, ?, ?, ?)',
        [
          getNews["title"],
          getNews["content"],
          getNews["descrbtion"],
          getNews["imageUrl"],
          getNews["publishedAt"],
          getNews["url"]
        ]
      );
    }
    notifyListeners();
  }

  // Remove news item from the database
  Future removeProduct(int id) async {
    await database.rawDelete('DELETE FROM Cart WHERE id = ?', [id]);
    getStoreNews(); // Refresh the list of news
  }
}
