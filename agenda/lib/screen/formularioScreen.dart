import 'package:agenda/database/contatosFactory.dart';
import 'package:agenda/models/contato.dart';
import 'package:agenda/screen/contatoScreen.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  Contato _contato;
  TextEditingController _nomeController;
  TextEditingController _numeroController;
  FormularioScreen(Contato contato) {
    if (contato != null) {
      _contato = contato;
      _nomeController =
          new TextEditingController(text: contato.getNome().toString());
      _numeroController =
          TextEditingController(text: contato.getTelefone().toString());
      return;
    }
    _nomeController = new TextEditingController();
    _numeroController = new TextEditingController();
  }

  FormularioState createState() => FormularioState();
}

class FormularioState extends State<FormularioScreen> {
  Widget build(BuildContext contextForm) {
    ContatoFactory().filtrar("I%").then((value) {
      value.forEach((contato) {
        String nome = contato.getNome();
        print("Filtro: $nome");
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[900],
        title: Text("Adicionar contato",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            _nomeForm('Nome', TextInputType.text),
            _numeroForm('Número', TextInputType.number),
            _buttonForm('Salvar', contextForm)
          ],
        ),
      ),
    );
  }

  _nomeForm(String text, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 35,
        keyboardType: inputType,
        controller: widget._nomeController,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.person),
          labelText: text,
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
        ),
      ),
    );
  }

  _numeroForm(String text, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 11,
        keyboardType: inputType,
        controller: widget._numeroController,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.phone_android),
            labelText: text,
            labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
            hintText: 'XX  XXXX - XXXX',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[400])),
      ),
    );
  }

  _editaContato(Contato contato, BuildContext contextForm) {
    Contato contatoEdit =
        Contato(widget._nomeController.text, widget._numeroController.text);
    ContatoFactory().edita(contato.getId(), contatoEdit).catchError((error) {
      _alertaDadosInvalidos(contextForm, error.toString());
    }).then((id) {
      if (id > 0) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ContatoScreen()),
            (route) => false);
      }
    });
  }

  _alertaDadosInvalidos(BuildContext contextForm, String title) {
    showDialog(
      context: contextForm,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text("Preencha todos os campos corretamente."),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('Voltar'))
          ],
        );
      },
    );
  }

  _criaContato(String nome, String numero, BuildContext contextForm) async {
    await ContatoFactory().salvar(Contato(nome, numero)).catchError((error) {
      _alertaDadosInvalidos(contextForm, error.toString());
    }).then((id) {
      if (id > 0) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ContatoScreen()),
            (route) => false);
      }
    });
  }

  _buttonForm(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {
          if (widget._contato != null) {
            _editaContato(widget._contato, context);
            return;
          }
          _criaContato(widget._nomeController.text,
              widget._numeroController.text, context);
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2),
        ),
        color: Colors.green[900],
        padding: EdgeInsets.only(left: 120, right: 120, bottom: 15, top: 15),
      ),
    );
  }
}
