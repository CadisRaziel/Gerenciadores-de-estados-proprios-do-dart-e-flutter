import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGaugeRange extends GaugeRange {
  ImcGaugeRange(
      {required Color color,
      required double start,
      required double end,
      required String label})
      : super(
            startValue: start,
            endValue: end,
            color: color,
            label: label,
            //*Sempre deixe aqui factor
            sizeUnit: GaugeSizeUnit.factor,
            labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: 12),
            //*Aqui define aonde o label vai ficar dentro de cada cor !! (desse modo ele ficara no centro !)
            //*Define tambem o tamanho dos campos do grafico !!
            startWidth: 0.35,
            endWidth: 0.35);
}
