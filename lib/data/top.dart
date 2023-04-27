import 'package:meubolso/data/1.dart';

List<money> geter_top() {
  money top_comida = money();
  top_comida.time = 'jan 30,2023';
  top_comida.image = 'comida.png';
  top_comida.buy = true;
  top_comida.fee = '- R\$ 100';
  top_comida.name = 'Comida';

  money top_transfer = money();
  top_transfer.time = 'hoje';
  top_transfer.image = 'transferencia.png';
  top_transfer.buy = true;
  top_transfer.fee = '- R\$ 60';
  top_transfer.name = 'Transferência';

  return [top_comida, top_transfer];
}