import 'package:flutter/material.dart';
import 'package:meubolso/Screens/home.dart';
import 'package:meubolso/data/model/add_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meubolso/widgets/bottomnavigationbar.dart';

import '../data/databasecat.dart';

class Add_Screen extends StatefulWidget {
  const Add_Screen({super.key});

  @override
  State<Add_Screen> createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  final box = Hive.box<Add_data>('data');
  final _myBox = Hive.box('mybox');
  CatDataBase db = CatDataBase();
  DateTime date = new DateTime.now();
  String? selectedItem;
  String? selectedItemi;
  final TextEditingController detail_C = TextEditingController();
  FocusNode dt = FocusNode();
  final TextEditingController amount_C = TextEditingController();
  FocusNode amount_ = FocusNode();
  final List<String> _itemi = [
    'Ganho',
    'Despesa'
  ];
  @override
  void initState() {
      db.loadData();
    super.initState();
    dt.addListener(() {
      setState(() {});
    });
    amount_.addListener(() {
      setState(() {});
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              child: main_container(),
            ),
          ],
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 550,
              width: 340,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  name(),
                  SizedBox(height: 30),
                  detail(),
                  SizedBox(height: 30),
                  amount(),
                  SizedBox(height: 30),
                  type(),
                  SizedBox(height: 30),
                  date_time(),
                  Spacer(),
                  save(),
                  SizedBox(height: 30),
                ],
              ),
            );
  }

  GestureDetector save() {
    return GestureDetector(
                  onTap: () {
                    var add = Add_data(selectedItemi!, amount_C.text, date, detail_C.text, selectedItem!);
                    box.add(add);
                    Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Bottom()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff368983)
                    ),
                    width: 120,
                    height: 50,
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        fontFamily: 'f',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 17
                      ),
                      ),
                  ),
                );
  }

  Container date_time() {
    return Container(
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Color(0xffC5C5C5))
                  ),
                  width: 300,
                  child: TextButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100)
                      );
                      if (newDate == Null) return;
                      setState(() {
                        date = newDate!;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                      'Data: ${date.day} / ${date.month} / ${date.year}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                    ),
                    ),
                    Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xffC5C5C5),
                        )
                      ],
                    )
                  ),
                );
  }

  Padding type() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Color(0xffC5C5C5)
                    )
                  ),
                  child: DropdownButton<String>(
                    value: selectedItemi,
                    items: _itemi.map((e)=>DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              child: Image.asset('images/${e}.png'),
                            ),
                            SizedBox(width: 10),
                            Text(
                              e,
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          ],
                        ),
                      ),
                      value: e,
                      ))
                      .toList(),
                      selectedItemBuilder: (context) => _itemi
                          .map((e) => Row(
                            children: [
                              Container(
                                width: 42,
                                child: Image.asset('images/${e}.png'),
                              ),
                              SizedBox(width: 5),
                              Text(e)
                            ],
                          ))
                          .toList(),
                    hint: Text(
                      'Tipo',
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    underline: Container(),
                    onChanged: ((value) {
                      setState(() {
                        selectedItemi = value!;
                      });
                    }),
                  ),
                ),
              );
  }

  Padding amount() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  focusNode: amount_,
                  controller: amount_C,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    labelText: 'Valor',
                    labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2, color:Color(0xffC5C5C5))
                    ),
                  ),
                ),
              );
  }

  Padding detail() {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    focusNode: dt,
                    controller: detail_C,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'Detalhes',
                      labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 2, color: Color(0xffC5C5C5))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 2, color:Color(0xffC5C5C5))
                      ),
                    ),
                  ),
                );
  }

  Padding name() {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Color(0xffC5C5C5)
                      )
                    ),
                    child: DropdownButton(
                      value: selectedItem,
                      items: db.CatList.map((e)=>DropdownMenuItem(
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                e,
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              )
                            ],
                          ),
                        ),
                        value: e,
                        ))
                        .toList(),
                        selectedItemBuilder: (context) => db.CatList
                            .map((e) => Row(
                              children: [
                                
                                SizedBox(width: 5),
                                Text(e)
                              ],
                            ))
                            .toList(),
                      hint: Text(
                        'Categoria',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: ((value) {
                        setState(() {
                          selectedItem = value!.toString();
                        });
                      }),
                    ),
                  ),
                );
  }

  Column background_container(BuildContext context) {
    return Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  color: Color(0xff368983),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Adicionar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.attach_file_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
  }
}