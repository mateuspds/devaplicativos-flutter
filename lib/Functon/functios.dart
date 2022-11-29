import 'package:flutter/foundation.dart';

class Funcao with ChangeNotifier {
  bool logado = false;

  void usarioLOgado() {
    logado == true;
    notifyListeners();
  }
}
