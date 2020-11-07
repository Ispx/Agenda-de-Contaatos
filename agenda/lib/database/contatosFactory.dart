import 'package:agenda/database/database.dart';
import 'package:agenda/models/contato.dart';
import 'package:sqflite/sqflite.dart';

class ContatoFactory {
  Database _database;
  final String _tableContatos = "contato";

  Future<int> salvar(Contato contato) async {
    _database = await createDatabase();
    return _database.insert(_tableContatos, contato.getMap());
  }

  Future<int> edita(int id, Contato newContato) async {
    _database = await createDatabase();
    return _database.update(_tableContatos, newContato.getMap(),
        where: "id = ?", whereArgs: [id]);
  }

  Future<List<Contato>> filtrar(String text) async {
    text = text + "%";
    _database = await createDatabase();
    List<Map<String, dynamic>> listMap = await _database
        .query(_tableContatos, where: "nome LIKE ?", whereArgs: [text]);
    List<Contato> contatos = new List();
    for (Map mapContato in listMap) {
      contatos.add(Contato(mapContato['nome'], mapContato['telefone']));
    }
    return contatos;
  }

  Future<List<Contato>> ler() async {
    _database = await createDatabase();
    List<Contato> listaDeContatos = new List();
    List<Map<String, dynamic>> mapContatos =
        await _database.query(_tableContatos);

    for (Map<String, dynamic> map in mapContatos) {
      Contato contato = new Contato(
        map['nome'],
        map['telefone'],
      );
      contato.setId(map['id']);
      listaDeContatos.add(contato);
    }
    return listaDeContatos;
  }

  Future<int> deletar(int id) async {
    _database = await createDatabase();

    return _database.delete(_tableContatos, where: "id = ?", whereArgs: [id]);
  }
}
