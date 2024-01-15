import 'dart:io';

import 'package:cubitvideourokrss/src/widgets/image_news_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path =documentsDirectory.path +"/"+"TestDB.db";

    // join([documentsDirectory.path,"TestDB.db"] as String);

    return await openDatabase(path,version: 1,
        onOpen: (db){},
        onCreate: (Database? db, int version) async { await db?.execute("CREATE TABLE Customer ("
    // "id INTEGER PRIMARY KEY,"
    "Id TEXT,"
    "Card TEXT,"
    "Sum DOUBLE"
    ")");
    });
  }

  newCustomerRaw(Customer customer) async {
    final db = await database;
    var res = await db?.rawInsert("INSERT Into Customer (id,cart,sum) Values (${customer.Id},${customer.Card},${customer.Sum})");
  }

  newCustomer(Customer newCustomer) async {
    final db = await database;
    var res = await db?.insert("Customer", newCustomer.toMap());
    return res;
  }

  // newClient(Client newClient) async {
  //   final db = await database;
  //   //get the biggest id in the table
  //   var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
  //   int id = table.first["id"];
  //   //insert to the table using the new id
  //   var raw = await db.rawInsert(
  //       "INSERT Into Client (id,first_name,last_name,blocked)"
  //           " VALUES (?,?,?,?)",
  //       [id, newClient.firstName, newClient.lastName, newClient.blocked]);
  //   return raw;
  // }

  getCustomer(int Id) async {
    final db = await database;
    var res = await db?.query("Customer",where: "id = ?", whereArgs: [Id]);
    return res!.isNotEmpty ? Customer.fromMap(res.first) : null;

  }

  getAllCustomer() async {
    final db = await database;
    var res = await db?.query("Customer");
    List<Customer> list =res!.isNotEmpty ? res.map((c) => Customer.fromMap(c)).toList() : [];
    return list;
  }

  getBlockedClients() async {
    final db = await database;
    var res = await db?.rawQuery("SELECT * FROM Customer WHERE blocked=1");
    Iterable<Customer>? list =  res!.isNotEmpty ? res.toList().map((c) => Customer.fromMap(c)) : null;
    return list;
  }

  getFindCustomer(var Id) async {
    final db = await database;
    var res = await db?.query("Customer",where: "Id = ?", whereArgs: [Id]);
    return res!.isNotEmpty || res.length!=0;
  }

  updateCustomer(Customer newCustomer) async {
    final db = await database;
    var res = await db?.update("Customer", newCustomer.toMap(),
        where: "id = ?", whereArgs: [newCustomer.Id]);
    return res;
  }

  deleteCustomer(int id) async {
    final db = await database;
    db?.delete("Customer", where: "id = ?", whereArgs: [id]);
  }
  deleteAll() async {
    final db = await database;
    db?.rawDelete("Delete from Customer");
  }
  // String join([String separator = ""]) {
  //   Iterator<E> iterator =this.iterator;
  //   if (!iterator.moveNext()) return "";
  //   StringBuffer buffer = new StringBuffer();
  //   if (separator == null || separator == "") {
  //     do {
  //       buffer.write("${iterator.current}");
  //     } while (iterator.moveNext());
  //   } else {
  //     buffer.write("${iterator.current}");
  //     while (iterator.moveNext()) {
  //       buffer.write(separator);
  //       buffer.write("${iterator.current}");
  //     }
  //   }
  //   return buffer.toString();
  // }

}

