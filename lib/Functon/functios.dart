import 'package:flutter/foundation.dart';

class Usuario with ChangeNotifier {
  String? _idUsuario;
  bool logado = false;
  String? _email;

  void usarioLOgado() {
    logado == true;
    notifyListeners();
  }

  String? get idUsuario => _idUsuario;
  String? get email => _email;

  set updateIdUsuario(String novoValor) {
    _idUsuario = novoValor;
    print("IDUSUARIO:$_idUsuario");
    notifyListeners();
  }

  void setarEmail(String novoemail) {
    _email = novoemail;
  }
}
