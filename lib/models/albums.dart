class Albums {
  int _id;
  String _ttl;
  String _dne;
  String _dsc;


  Albums(this._ttl, this._dne, this._dsc);

  Albums.withId(this._id, this._ttl, this._dne, this._dsc);

  int get id => _id;

  String get ttl => _ttl;

  String get dne => _dne;

  String get dsc => _dsc;


  set ttl(String newTitle) {
    if (newTitle.length <= 255) {
      this._ttl = newTitle;
    }
  }

  set dsc(String newLink) {
    if (newLink.length <= 255) {
      this._dsc = newLink;
    }
  }

  set dne(String newIcon) {
    if (newIcon.length <= 255) {
      this._dne = newIcon;
    }
  }


  // Convert a Albums object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['ttl'] = _ttl;
    map['dne'] = _dne;
    map['dsc'] = _dsc;
    return map;
  }

  // Extract a Albums object from a Map object
  Albums.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._ttl = map['ttl'];
    this._dne = map['dne'];
    this._dsc = map['dsc'];
  }
}
