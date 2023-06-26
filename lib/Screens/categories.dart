import 'package:flutter/material.dart';
import 'package:meubolso/Screens/home.dart';
import 'package:meubolso/data/model/add_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meubolso/widgets/bottomnavigationbar.dart';

import '../data/databasecat.dart';

class Cat_Screen extends StatefulWidget {
  const Cat_Screen({super.key});

  @override
  State<Cat_Screen> createState() => _Cat_ScreenState();
}

class _Cat_ScreenState extends State<Cat_Screen> {
  List deafultCat = ["Casa", "Comida", "Transporte", "Outros"];
  final _myBox = Hive.box('mybox');
  CatDataBase db = CatDataBase();
  DateTime date = new DateTime.now();
  String? selectedItem;
  String? selectedItemi;
  final TextEditingController detail_C = TextEditingController();
  FocusNode dt = FocusNode();
  final TextEditingController amount_C = TextEditingController();
  FocusNode amount_ = FocusNode();
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
              height: 150,
              width: 340,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  detail(),
                  SizedBox(height: 10),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  resetCat(),
                  save(),
                  ],
                  )
                ],
              ),
            );
  }

  GestureDetector save() {
    return GestureDetector(
                  onTap: () {
                    db.CatList.add(detail_C.text);
                    db.updateDataBase();
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

  GestureDetector resetCat() {
    return GestureDetector(
                  onTap: () {
                    _myBox.clear();
                    Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Bottom()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red
                    ),
                    width: 150,
                    height: 50,
                    child: Text(
                      'Resetar categorias',
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

  Padding detail() {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    focusNode: dt,
                    controller: detail_C,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'Nome da nova categoria',
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
                            'Criar nova categoria',
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