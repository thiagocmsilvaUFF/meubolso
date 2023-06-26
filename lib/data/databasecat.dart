import 'package:hive_flutter/hive_flutter.dart';

class CatDataBase {
  List CatList = ["Casa", "Comida", "Transporte", "Outros"];

  // reference our box
  final _myBox = Hive.box('mybox');

  // load the data from database
  void loadData() {
    CatList = _myBox.get("CATLIST", defaultValue: CatList);
  }

  // update the database
  void updateDataBase() {
    _myBox.put("CATLIST", CatList);
  }

  
}
  