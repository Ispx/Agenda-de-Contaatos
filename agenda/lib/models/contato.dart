class Contato {
  int _id;
  String _nome;
  String _telefone;
  @override
  Contato(this._nome, this._telefone);

  Map<String, dynamic> getMap() {
    Map<String, dynamic> map = Map();
    map['nome'] = this._nome;
    map['telefone'] = this._telefone;
    return map;
  }

  getId() {
    return this._id;
  }

  setId(int id) {
    this._id = id;
  }

  getNome() {
    return this._nome;
  }

  setNome(String nome) {
    this._nome = nome;
  }

  getTelefone() {
    return this._telefone;
  }

  setTelefone(String telefone) {
    this._telefone = telefone;
  }
}
