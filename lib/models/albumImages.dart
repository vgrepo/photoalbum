class AlbumImages {
  int _id;
  int _albumsId;
  String _imgNzv;
  String _imgPath;
  String _imgTtl;
  String _imgDsc;
  String _imgDne;
  int _imgNo;
  String _imgIdentifier;
  int _imgWidth;
  int _imgHeight;

  AlbumImages(
      this._albumsId,
      this._imgNzv,
      this._imgPath,
      this._imgTtl,
      this._imgDne,
      this._imgDsc,
      this._imgNo,
      this._imgIdentifier,
      this._imgWidth,
      this._imgHeight);

  AlbumImages.withId(
      this._id,
      this._albumsId,
      this._imgNzv,
      this._imgPath,
      this._imgTtl,
      this._imgDne,
      this._imgDsc,
      this._imgNo,
      this._imgIdentifier,
      this._imgWidth,
      this._imgHeight);

  int get id => _id;
  int get albumsId => _albumsId;
  String get imgNzv => _imgNzv;
  String get imgPath => _imgPath;
  String get imgTtl => _imgTtl;
  String get imgDsc => _imgDsc;
  String get imgDne => _imgDne;
  int get imgNo => _imgNo;
  String get imgIdentifier => _imgIdentifier;
  int get imgWidth => _imgWidth;
  int get imgHeight => _imgHeight;

  set albumsId(int newAlbumsId) {
    this._albumsId = newAlbumsId;
  }

  set imgNzv(String newNzv) {
    if (newNzv.length <= 255) {
      this._imgNzv = newNzv;
    }
  }

  set imgPath(String newPath) {
    if (newPath.length <= 255) {
      this._imgPath = newPath;
    }
  }

  set imgTtl(String newTitle) {
    if (newTitle.length <= 255) {
      this._imgTtl = newTitle;
    }
  }

  set imgDsc(String newDsc) {
    if (newDsc.length <= 255) {
      this._imgDsc = newDsc;
    }
  }

  set imgDne(String newIcon) {
    if (newIcon.length <= 255) {
      this._imgDne = newIcon;
    }
  }

  set imgNo(int newimgNo) {
    this._imgNo = newimgNo;
  }

  set imgIdentifier(String newimgIdentifier) {
    if (newimgIdentifier.length <= 255) {
      this._imgIdentifier = newimgIdentifier;
    }
  }

  set imgWidth(int newimgWidth) {
    this._imgWidth = newimgWidth;
  }

  set imgHeight(int newimgHeight) {
    this._imgHeight = newimgHeight;
  }

  // Convert a Images object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['albumsId'] = _albumsId;
    map['imgNzv'] = _imgNzv;
    map['imgPath'] = _imgPath;
    map['imgDsc'] = _imgDsc;
    map['imgTtl'] = _imgTtl;
    map['imgDne'] = _imgDne;
    map['imgNo'] = _imgNo;
    map['imgIdentifier'] = _imgIdentifier;
    map['imgWidth'] = _imgWidth;
    map['imgHeight'] = _imgHeight;
    return map;
  }

  // Extract a Images object from a Map object
  AlbumImages.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._albumsId = map['albumsId'];
    this._imgNzv = map['imgNzv'];
    this._imgPath = map['imgPath'];
    this._imgTtl = map['imgTtl'];
    this._imgDsc = map['imgDsc'];
    this._imgDne = map['imgDne'];
    this._imgNo = map['imgNo'];
    this._imgIdentifier = map['imgIdentifier'];
    this._imgWidth = map['imgWidth'];
    this._imgHeight = map['imgHeight'];
  }
}
