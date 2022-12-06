import 'package:flutter/foundation.dart';

class Usuario with ChangeNotifier {
  bool logado = false;

  void usarioLOgado() {
    logado == true;
    notifyListeners();
  }
}
