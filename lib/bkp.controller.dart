import 'package:mobx/mobx.dart';

class Controller {
  var _contador = Observable(0);

  Action incrementar;

  Controller() {
    incrementar = Action(_incrementar);
  }

  int get contador => _contador.value;

  set contador(novo) => _contador.value = novo;

  _incrementar() {
    contador++;
  }
}
