import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_project/controller.dart';
import 'package:mobx_project/principal_controller.dart';
import 'package:provider/provider.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  PrincipalController principalController = PrincipalController();

  _dialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Adicionar item"),
            content: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Digite uma descrição..."),
              onChanged: principalController.setNovoItem,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    principalController.adicionarItem();
                    Navigator.pop(context);
                  },
                  child: Text("Salvar"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final controller2 = Provider.of<Controller>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tarefas2 ${controller2.email}",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
            itemCount: principalController.listItens.length,
            itemBuilder: (_, indice) {
              //item e do tipo ItemController
              var item = principalController.listItens[indice];

              return Observer(
                builder: (_) {
                  return ListTile(
                    title: Text(
                      item.titulo,
                      style: TextStyle(
                        decoration:
                            item.marcado ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: item.marcado,
                      onChanged: item.alterarMarcado,
                    ),
                    onTap: () {
                      item.marcado = !item.marcado;
                    },
                  );
                },
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );
  }
}
