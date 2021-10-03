import 'dart:async';
import 'dart:math';

import 'package:gerencia_estado_nativa/04_bloc_pattern/bloc_estado.dart';

class BlocController {
  //? estrutura de uma streamController, passamos a classe que tem nosso estado pra ela <>
  //*.add(BlocEstado(imc: 0)); -> estamos enviando um evento logo de cara informando que o imc é 0, pra ele ficar zerado
  //?broadcast -> deixa possivel o listener ouvir mais de 1 StreamBuilder
  final _imcStreamController = StreamController<BlocEstado>.broadcast()
    ..add(BlocEstado(imc: 0));

  //*Quem ficará escutando a StreamController
  Stream<BlocEstado> get imcOut => _imcStreamController.stream;

  Future<void> calcularImc(
      {required double peso, required double altura}) async {
    _imcStreamController.add(BlocEstadoLoading());
    await Future.delayed(Duration(seconds: 1));

    final imc = peso / pow(altura, 2);
    _imcStreamController.add(BlocEstado(imc: imc));
  }

  //? nunca se esqueça uma StreamController precisa ter um dispose !!!
  void dispose() {
    _imcStreamController.close();
  }
}
