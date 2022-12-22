import 'package:flutter/foundation.dart';

class Usuario with ChangeNotifier {
  bool logado = false;
  String token = "";

  void addToken(String idtoken) {
    token = idtoken;
    notifyListeners();
  }

  void usarioLOgado() {
    logado = true;
    notifyListeners();
  }
}
