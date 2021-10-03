import 'dart:math';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_estado_nativa/shared/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

//TODO ValueNotifier -> funciona por reatividade, toda vez que um valor for alterado, ela manda rebuildar um widget especifico
//* adicionando o ValueListenableBuilder em um widget que queremos que fique atualizando
//* nos evitamos que a pagina toda se rebuild e com isso apenas o item dentro do ValueListenableBuilder ira rebuildar

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  //*Criando globalKey para validar o formulario e implementando o 'Form'
  final formkey = GlobalKey<FormState>();
  var imcDouble = ValueNotifier(0.0);

  Future<void> calcularImc(
      {required double peso, required double altura}) async {
    //! Repare que no value notifier eu nao utilizo mais setState
    imcDouble.value = 0;
    await Future.delayed(Duration(seconds: 1));

    imcDouble.value = peso / pow(altura, 2);
  }

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
        title: const Text('Imc ValueNotifier'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //*valueListenable -> é o que ele vai ficar escutando para fazer a alteração
                //*Tipei <double> pois o valor que ele fica escutando é um double !!
                ValueListenableBuilder<double>(
                    valueListenable: imcDouble,
                    builder: (context, imcValue, child) {
                      return ImcGauge(
                        imc: imcValue,
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

                      calcularImc(peso: pesoValid, altura: alturaValid);
                    }
                  },
                  child: Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPrimary: Colors.white,
                      primary: Colors.purple),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
