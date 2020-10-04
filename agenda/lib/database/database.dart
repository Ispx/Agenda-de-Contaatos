import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = await getDatabasesPath();
  final String nomeDb = "contatos.db";

  return openDatabase(join(path, nomeDb), onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE contato(id INTEGER PRIMARY KEY, nome TEXT, telefone TEXT  )");
  }, version: 1);
}
