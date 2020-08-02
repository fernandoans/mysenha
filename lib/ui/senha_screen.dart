import 'package:flutter/material.dart';
import 'package:mysenha/model/senha.dart';
import 'package:mysenha/database/dbhelper.dart';

class SenhaScreen extends StatefulWidget {
  final Senha senha;
  SenhaScreen(this.senha);

  @override
  State<StatefulWidget> createState() => new _SenhaScreenState();
}

class _SenhaScreenState extends State<SenhaScreen> {
  DBHelper db = new DBHelper();

  TextEditingController _siteController;
  TextEditingController _usuarioController;
  TextEditingController _dicaController;

  @override
  void initState() {
    super.initState();
    _siteController = new TextEditingController(text: widget.senha.site);
    _usuarioController = new TextEditingController(text: widget.senha.usuario);
    _dicaController = new TextEditingController(text: widget.senha.dica);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Senha')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _siteController,
              decoration: InputDecoration(labelText: 'Site'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _usuarioController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _dicaController,
              decoration: InputDecoration(labelText: 'Dica'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.senha.id != null) ? Text('Modificar') : Text('Adicionar'),
              onPressed: () {
                if (widget.senha.id != null) {
                  db.updateSenha(Senha.fromMap({
                    'id': widget.senha.id,
                    'site': _siteController.text,
                    'usuario': _usuarioController.text,
                    'dica': _dicaController.text
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db.saveSenha(Senha(_siteController.text, _usuarioController.text, _dicaController.text)).then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}