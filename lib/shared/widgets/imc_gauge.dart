import 'package:flutter/material.dart';
import 'package:gerencia_estado_nativa/shared/widgets/image_gauce_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGauge extends StatelessWidget {
  final double imc;

  const ImcGauge({Key? key, required this.imc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          //*Aqui definimos o primeiro tamanho e fim dele como colocamos ali no ImcGaugeRange !!!
          //*Ou seja ele inicia em 12.5 e temrina em 47.9
          minimum: 12.5,
          maximum: 47.9,
          //*Aqui no ranges a gente criou um widget para poder criar todos os campos do grafico !!
          ranges: [
            ImcGaugeRange(
                color: Colors.blue, start: 12.5, end: 18.5, label: 'Magreza'),
            ImcGaugeRange(
                color: Colors.green, start: 18.5, end: 24.5, label: 'Normal'),
            ImcGaugeRange(
                color: Colors.yellow,
                start: 24.5,
                end: 29.9,
                label: 'Sobrepeso'),
            ImcGaugeRange(
                color: Colors.orange,
                start: 29.9,
                end: 39.9,
                label: 'Obessidade'),
            ImcGaugeRange(
                color: Colors.red,
                start: 39.9,
                end: 47.9,
                label: 'Obessidade grave'),
          ],
          //*Aqui sera adicionado o ponteiro !!! precisamos criar uma variavel para que ele seja funcional (ou incialize ele com 0)
          pointers: [
            NeedlePointer(
              value: imc,
              enableAnimation: true,
            )
          ],
        )
      ],
    );
  }
}
