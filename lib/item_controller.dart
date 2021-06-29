import 'package:mobx/mobx.dart';

part 'item_controller.g.dart';

// flutter pub run build_runner build
// flutter pub run build_runner watch

//a utilizacao de mixin para gerar de forma automatica

class ItemController = ItemControllerBase with _$ItemController;

abstract class ItemControllerBase with Store {
  ItemControllerBase(this.titulo);

  final String titulo;

  @observable
  bool marcado = false;

  void alterarMarcado(bool valor) => marcado = valor;
}
