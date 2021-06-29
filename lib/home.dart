import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_project/controller.dart';
import 'package:mobx_project/principal.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int contador = 0;
  //
  // incremetar() {
  //   setState(() {
  //     contador++;
  //   });
  // }

  Controller controller = Controller();
  Controller controller2;
  ReactionDisposer reactionDisposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller2 = Provider.of<Controller>(context);

    // autorun e sempre chamado e notificatido de todos os observeris
    autorun((_) {
      print('didChangeDependencies');
      print(controller.formularioValidado);
    });

    //nao e chamado a primeira vez e so de um especifico observer, no caso 'formularioValidado'
    reactionDisposer = reaction((_) => controller.formularioValidado, (valor) {
      print('reaction formularioValidado');
      print(valor);
    });

    //nao e chamado a primeira vez e so de um especifico observer, no caso 'formularioValidado'
    reactionDisposer = reaction((_) => controller.usuarioLogado, (valor) {
      print('reaction usuarioLogado');
      print(valor);
      if (valor) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Principal()));
      }
    });
  }

  @override
  void dispose() {
    //reactionDisposer.reaction.dispose();
    reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: EdgeInsets.all(16),
                child: Observer(
                  builder: (_) {
                    return RaisedButton(
                      onPressed: controller.formularioValidado
                          ? () {
                              controller.logar();
                            }
                          : null,
                      child: controller.carregando
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text('Logar'),
                    );
                  },
                )),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: controller.setEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(labelText: 'Senha'),
                onChanged: controller.setSenha,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Observer(
                builder: (_) {
                  return Text(
                    controller.formularioValidado
                        ? 'Validado'
                        : "Campos nao validados: ${controller.emailSenha}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  );
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: Observer(
                  builder: (_) {
                    return RaisedButton(
                      onPressed: controller.formularioValidado
                          ? () {
                              controller.incrementar();
                            }
                          : null,
                      child: Text('Logar'),
                    );
                  },
                )),
            Container(
              padding: EdgeInsets.all(16),
              child: Observer(
                builder: (_) {
                  return Text(
                    "${controller.contador}",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                onPressed: () {
                  controller.incrementar();
                },
                child: Text('Incrementar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
