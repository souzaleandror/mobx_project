import 'package:mobx/mobx.dart';
import 'package:mobx_project/item_controller.dart';

part 'principal_controller.g.dart';

// flutter pub run build_runner build
// flutter pub run build_runner watch

//a utilizacao de mixin para gerar de forma automatica

class PrincipalController = PrincipalControllerBase with _$PrincipalController;

abstract class PrincipalControllerBase with Store {
  ObservableList<ItemController> listItens = ObservableList<ItemController>();

  @observable
  String novoItem = '';

  @action
  void setNovoItem(String novo) => novoItem = novo;

  @action
  void adicionarItem() {
    listItens.add(ItemController(novoItem));
    print(listItens);
  }
}
