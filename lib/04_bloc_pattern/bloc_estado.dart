//*Essa classe vai representar nosso estado

class BlocEstado {
  final double imc;
  BlocEstado({
    required this.imc,
  });
}

//*O bloc ele demora um pouco a mais que os outros 3 estados para renderizar a tela, porém com isso podemos trabalhar com um Loader
class BlocEstadoLoading extends BlocEstado {
  BlocEstadoLoading() : super(imc: 0);
}

// class BlocEstadoErro extends BlocEstado {
//   String message;

//   BlocEstadoErro({
//     required this.message,
//   }) : super(imc: 0);
// }
