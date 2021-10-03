import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_estado_nativa/shared/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class Bloc extends StatefulWidget {
  const Bloc({Key? key}) : super(key: key);

  @override
  _BlocState createState() => _BlocState();
}

class _BlocState extends State<Bloc> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  var imcDouble = 0.0;

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
        title: const Text('Imc SetState'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //*componetizamos o Gauge !! olhe como estruturamos ele !!
                ImcGauge(
                  imc: imcDouble,
                ),
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

                      // calcularImc(peso: pesoValid, altura: alturaValid);
                    }
                  },
                  child: Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPrimary: Colors.white,
                      primary: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
