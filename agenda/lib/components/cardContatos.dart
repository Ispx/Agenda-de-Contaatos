import 'package:agenda/database/contatosFactory.dart';
import 'package:agenda/models/contato.dart';
import 'package:agenda/screen/contatoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget cardContatos(Contato contato, BuildContext context) {
  return Card(
    color: Colors.white,
    child: ListTile(
      leading: Material(child: InkWell(onTap: () {}, child: CircleAvatar())),
      title: Text(contato.getNome()),
      subtitle: Text(contato.getTelefone()),
      trailing: Material(
          child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.call,
                color: Colors.green[400],
              ))),
      onTap: () {},
      onLongPress: () {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Desejá realmente exluir:'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")),
                FlatButton(
                    onPressed: () {
                      ContatoFactory()
                          .deletar(contato.getId())
                          .whenComplete(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContatoScreen()),
                            (route) => false);
                      });
                    },
                    child: Text("Confirmar")),
              ],
            );
          },
        );
      },
    ),
  );
}
