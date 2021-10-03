import 'dart:math';
import 'package:flutter/material.dart';

//* Notificando -> rebuildando

//*ChangeNotifier tem uma controller que extende de ChangeNotifier ! (fazendo esse extends é o suficiente para deixar essa classe controller observavel)
class Controller extends ChangeNotifier {
  var imcChangeNotifier = 0.0;
  //*O problema é, se eu tiver mais de uma variavel aqui, ele fica notificando(rebuildando) todo mundo que ta aqui dentro dessa classe, independente se nao esta sendo usada

  //*O calculo que antes eu fazia direto la dentro da pagina, agora eu faço aqui na controller
  Future<void> calcularImc(
      {required double peso, required double altura}) async {
    //*O changeNotifier nos da os listeneble (nao esqueça que ele é do material.dart)
    //*ele aqui vai ouvir essa variavel
    imcChangeNotifier = 0;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    imcChangeNotifier = peso / pow(altura, 2);
    //*aqui depois de alterar eu modifico os listener
    notifyListeners();
  }
}
