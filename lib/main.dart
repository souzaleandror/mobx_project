import 'package:flutter/material.dart';
import 'package:mobx_project/controller.dart';
import 'package:mobx_project/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<Controller>(
        create: (_) => Controller(),
      ),
    ],
    child: MaterialApp(
      home: Home(),
    ),
  ));
}
