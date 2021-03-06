import 'package:flutter/material.dart';
import 'package:gerencia_estado_nativa/01_setSate/imc_set_state.dart';
import 'package:gerencia_estado_nativa/02_valueNotifier/value_notifier_page.dart';
import 'package:gerencia_estado_nativa/03_changeNotifier/change_notifier.dart';
import 'package:gerencia_estado_nativa/04_bloc_pattern/bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  //*Simples metodo para navegação
  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de estados'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, ImcSetStatePage());
              },
              child: const Text('SetState'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, ValueNotifierPage());
              },
              child: const Text('ValueNofitier'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, ChangeNotifierPage());
              },
              child: const Text('ChangeNotifier'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, Bloc());
              },
              child: const Text('Bloc Patterns (stream'),
            ),
          ],
        ),
      ),
    );
  }
}
