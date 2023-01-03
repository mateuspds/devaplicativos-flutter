import 'package:flutter/foundation.dart';

class Usuario with ChangeNotifier {
  String? _idUsuario;
  bool logado = false;

  void usarioLOgado() {
    logado == true;
    notifyListeners();
  }

  String? get idUsuario => _idUsuario;

  set updateIdUsuario(String novoValor) {
    _idUsuario = novoValor;
    print("IDUSUARIO:$_idUsuario");
    notifyListeners();
  }
}
