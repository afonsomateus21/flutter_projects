class Message {
  String _userId;
  String _message;
  String _imageUrl;
  String _kindOfMessage; // define the kind of message, text or image

  Message();

  String get userId => this._userId;

  String get message => this._message;

  String get imageUrl => this._imageUrl;

  String get kindOfMessage => this._kindOfMessage;

  set userId(String userId) {
    this._userId = userId;
  }

  set message(String message) {
    this._message = message;
  }

  set imageUrl(String imageUrl) {
    this._imageUrl = imageUrl;
  }

  set kindOfMessage(String kindOfMessage) {
    this._kindOfMessage = kindOfMessage;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "userId": this._userId,
      "message": this._message,
      "imageUrl": this._imageUrl,
      "kindOfMessage": this._kindOfMessage
    };

    return map;
  }
}