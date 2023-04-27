import 'package:meubolso/data/1.dart';

List<money> geter(){
  money transferencia = money();
  transferencia.name = 'transferência';
  transferencia.fee = '650';
  transferencia.time = 'hoje';
  transferencia.image = 'transferencia.png';
  transferencia.buy = false;

  money comida = money();
  comida.name = 'comida';
  comida.fee = '15';
  comida.time = 'hoje';
  comida.image = 'comida.png';
  comida.buy = true;

  money educacao = money();
  educacao.name = 'educação';
  educacao.fee = '100';
  educacao.time = 'jan 30,2023';
  educacao.image = 'educacao.png';
  educacao.buy = true;

  return[transferencia, comida, educacao, transferencia, comida, educacao];
}