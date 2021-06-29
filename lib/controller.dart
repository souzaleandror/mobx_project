import 'package:mobx/mobx.dart';

part 'controller.g.dart';

// flutter pub run build_runner build
// flutter pub run build_runner watch

//a utilizacao de mixin para gerar de forma automatica

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  ControllerBase() {
    // Executa sempre que um observavel tem seu estado alterado;
    autorun((_) {
      print(contador);
      print(email);
      print(senha);
      print(emailSenha);
      print(formularioValidado);
    });
  }

  @observable
  String email = '';

  @observable
  String senha = '';

  @observable
  bool usuarioLogado = false;

  @observable
  bool carregando = false;

  @action
  void setEmail(valor) => email = valor;

  @action
  void setSenha(valor) => senha = valor;

  @computed
  String get emailSenha => '$email - $email';

  @computed
  bool get formularioValidado => email.length >= 5 && senha.length >= 5;

  @action
  Future<void> logar() async {
    carregando = true;
    await Future.delayed(Duration(seconds: 3));

    carregando = false;
    usuarioLogado = true;
  }

  @observable
  int contador = 0;

  @action
  incrementar() {
    contador++;
  }
}
