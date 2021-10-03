import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import 'package:gerencia_estado_nativa/shared/widgets/imc_gauge.dart';

class Template extends StatefulWidget {
  const Template({Key? key}) : super(key: key);

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //*componetizamos o Gauge !! olhe como estruturamos ele !!
              ImcGauge(
                imc: 0,
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
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {},
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
    );
  }
}
