import 'package:flutter/material.dart';
import 'package:mysenha/model/senha.dart';
import 'package:mysenha/database/dbhelper.dart';
import 'package:mysenha/ui/senha_screen.dart';

class ListViewSenha extends StatefulWidget {
  @override
  _ListViewSenhaState createState() => new _ListViewSenhaState();
}

class _ListViewSenhaState extends State<ListViewSenha> {
  List<Senha> items = new List();
  var db = new DBHelper();

  @override
  void initState() {
    super.initState();

    db.getAllSenhas().then((senhas) {
      setState(() {
        senhas.forEach((senha) {
          items.add(Senha.fromMap(senha));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Senhas'),
          centerTitle: true,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Text(
                      '${items[position].site}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    subtitle: Text(
                      '${items[position].usuario}\n${items[position].dica}',
                      style: new TextStyle(
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(2.0)),
                        CircleAvatar(
                          backgroundColor: Colors.green[900],
                          radius: 18.0,
                          child: Text(
                            '${items[position].id}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _navigateToSenha(context, items[position]),
                  ),
                  IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => _deleteSenha(context, items[position], position)),
                ],
              );
            }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewSenha(context),
        ),
    );
  }

  void _deleteSenha(BuildContext context, Senha senha, int position) async {
    db.deleteSenha(senha.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToSenha(BuildContext context, Senha senha) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SenhaScreen(senha)),
    );
    if (result == 'update') {
      db.getAllSenhas().then((senhas) {
        setState(() {
          items.clear();
          senhas.forEach((senha) {
            items.add(Senha.fromMap(senha));
          });
        });
      });
    }
  }

  void _createNewSenha(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SenhaScreen(Senha('', '', ''))),
    );
    if (result == 'save') {
      db.getAllSenhas().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Senha.fromMap(note));
          });
        });
      });
    }
  }
}
