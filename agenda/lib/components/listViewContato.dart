import 'package:agenda/components/cardContatos.dart';
import 'package:agenda/models/contato.dart';
import 'package:flutter/material.dart';

ListViewContatos(List<Contato> contatos, BuildContext contatosContext) {
  return Padding(
      padding: const EdgeInsets.all(0.5),
      child: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return cardContatos(contatos[index], contatosContext);
        },
      ));
}
