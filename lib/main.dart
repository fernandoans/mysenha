import 'package:flutter/material.dart';
import 'package:mysenha/ui/senhaList.dart';

void main() {
  runApp(MaterialApp(
    title: 'Armazenador de Senhas',
    theme:
        ThemeData(primaryColor: Colors.green[600], accentColor: Colors.green),
    debugShowCheckedModeBanner: false,
    home: ListViewSenha(),
  ));
}
