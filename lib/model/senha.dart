class Senha {

  int _id;
  String _site;
  String _usuario;
  String _dica;

  Senha(this._site, this._usuario, this._dica);

  Senha.map(dynamic obj) {
    this._id = obj['id'];
    this._site = obj['site'];
    this._usuario = obj['usuario'];
    this._dica = obj['dica'];
  }

  int get id => _id;
  String get site => _site;
  String get usuario => _usuario;
  String get dica => _dica;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['site'] = _site;
    map['usuario'] = _usuario;
    map['dica'] = _dica;
    return map;
  }

  Senha.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._site = map['site'];
    this._usuario = map['usuario'];
    this._dica = map['dica'];
  }
}