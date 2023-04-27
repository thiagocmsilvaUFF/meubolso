import 'package:flutter/material.dart';
import 'package:meubolso/widgets/chart.dart';
import 'package:meubolso/data/top.dart';
import '../data/model/add_data.dart';
import '../data/utility.dart';

class Statistics extends StatefulWidget{
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List day = ['Dia', 'Semana', 'Mês'];
  List f = [today(), week(), month()];
  final List<String> weekday = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sábado',
    'Domingo',
  ];
  List<Add_data> a = [];
  int index_color = 0;
  ValueNotifier kj = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: kj,
          builder: (context, dynamic value, child) {
            a = f[value];
          return custom();
        },),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Estatísticas',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        3,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                index_color = index;
                                kj.value = index;
                              });
                            },
                            child: Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: index_color == index ? Color.fromARGB(255, 47, 125, 121):Colors.white12
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  day[index],
                                                  style: TextStyle(
                                                    color: index_color == index ? Colors.white:Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                          ); 
                        },
                      ), 
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Despesas',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward_sharp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Chart(indexx: index_color,),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Despesas durante o período',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.swap_vert,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: ListTile(
                    leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('images/${a[index].name}.png',
                     height: 40),
                  ),
                  title: Text(
                    a[index].name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  subtitle: Text(
                    '${weekday[a[index].datetime.weekday - 1]}  ${a[index].datetime.day}/${a[index].datetime.month}/${a[index].datetime.year}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  trailing: Text(
                    a[index].IN == 'Ganho' ? '+ R\$ ${a[index].amount}':'- R\$ ${a[index].amount}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: a[index].IN == 'Ganho' ? Colors.green:Colors.red,
                    ),
                  ),
                  ),
                );
              },
              childCount: a.length,
            )
          )
        ],
      );
  }
}