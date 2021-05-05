import 'package:convertor/value.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('UserConversions.json');
void newToMade(String name, value) {
  List names = [];
  names = storage.getItem('names') ?? [];
  storage.setItem('names', names + [name]);
  storage.setItem(name, value);
}

void putCurrency(String name, value) {
  storage.setItem(name, value);
}

List<String> turnit(List lst) {
  return lst.map((item) {
    return item.toString();
  }).toList();
}

List<List<double>> turndouble(List lst) {
  List<List<double>> tobereturned = [
    for (int i = 0; i < lst.length; i++)
      [for (int j = 0; j < lst[i].length; j++) lst[i][j]]
  ];
  return tobereturned;
}

void getdata() async {
  await storage.ready;
  //storage.clear();
  List names = storage.getItem('names');
  if (names != null) {
    for (String st in names) {
      var convs;
      convs = storage.getItem(st);
      topics['Your Conversions'][st] = Conversion(2, [
        for (String i in convs.keys)
          Method(i, "", turnit(convs[i]['equations']),
              turndouble(convs[i]['factors']))
      ]);
    }
  }
}

void getCurrency() async {
  await storage.ready;
  var convs;
  convs = storage.getItem('Currency') ?? {};
  topics['Daily Life']['Currency'] = Conversion(2, [
    for (String i in convs.keys)
      Method(
          i, "", turnit(convs[i]['equations']), turndouble(convs[i]['factors']))
  ]);
}

void deletefromlocal(String i) {
  List names = [];
  names = storage.getItem('names') ?? [];
  names.removeWhere((element) => element == i);
  storage.setItem('names', names);
  storage.deleteItem(i);
}
