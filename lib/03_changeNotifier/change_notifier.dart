import 'dart:math';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_estado_nativa/03_changeNotifier/controller.dart';
import 'package:gerencia_estado_nativa/shared/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  final controller = Controller();

  //*Criando globalKey para validar o formulario e implementando o 'Form'
  final formkey = GlobalKey<FormState>();

  //!Nunca se esqueça, sempre encerre os controllers !!!
  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc ChangeNotifier'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //*Assim como o ValueNotifier precisamos colocar o AnimatedBuilder para as alteraçoes serem feitas
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return ImcGauge(
                        imc: controller.imcChangeNotifier,
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso',
                  ),
                  //*utilizando o inputFormarter para por uma mascara
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      //*locale -> Substitui o ponto por virgula
                      locale: 'pt_BR',
                      //*Symbol -> simbolo de dinheiro, para remover coloque ''
                      symbol: '',
                      //*DecimalDigits -> numero de decimais que vai aparecer depois da virgula
                      decimalDigits: 2,
                      //*TurnOffGrouping -> tira o ponto de decimal para numeros muito grandes, exemplo: 1.000 vai ficar 10000
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatório';
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura',
                  ),
                  //*utilizando o inputFormarter para por uma mascara
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      //*locale -> Substitui o ponto por virgula
                      locale: 'pt_BR',
                      //*Symbol -> simbolo de dinheiro, para remover coloque ''
                      symbol: '',
                      //*DecimalDigits -> numero de decimais que vai aparecer depois da virgula
                      decimalDigits: 2,
                      //*TurnOffGrouping -> tira o ponto de decimal para numeros muito grandes, exemplo: 1.000 vai ficar 10000
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigatória';
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    var formValid = formkey.currentState?.validate() ?? false;

                    if (formValid) {
                      //*Formatando as virgulas para ponto
                      var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt_BR', decimalDigits: 2);
                      double pesoValid = formatter.parse(pesoEC.text) as double;
                      double alturaValid =
                          formatter.parse(alturaEC.text) as double;

                      //*Aqui eu chamo a função criada na controller
                      controller.calcularImc(
                          peso: pesoValid, altura: alturaValid);
                    }
                  },
                  child: Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPrimary: Colors.white,
                      primary: Colors.teal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
