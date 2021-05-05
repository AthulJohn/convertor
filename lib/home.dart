import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'Storage/storage.dart';
import 'value.dart';

class Home extends StatefulWidget {
  final PageController cont;
  Home(this.cont);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void deletefromtopics(String i) {
    setState(() {
      topics['Your Conversions'].remove(i);
    });
  }

  void deletecards(String i) {
    setState(() {
      cards.removeWhere((element) => element.name == i);
    });
  }

  List<Map<String, String>> searched = [];
  bool searching = false;

  Map<String, Icon> icons = {
    'Length': Icon(FlutterIcons.ruler_ent),
    'Weight': Icon(FlutterIcons.balance_scale_faw),
    'Volume': Icon(FlutterIcons.test_tube_mco),
    'Area': Icon(FlutterIcons.area_chart_faw),
    'Temperature': Icon(FlutterIcons.thermometer_faw),
    'Time': Icon(FlutterIcons.ios_time_ion),
    'Angle': Icon(FlutterIcons.time_slot_ent),
    'Data': Icon(FlutterIcons.database_ent),
    'Speed': Icon(FlutterIcons.speedometer_medium_mco),
    'Gold': Icon(FlutterIcons.podium_gold_mco),
    'Land': Icon(FlutterIcons.landscape_mdi),
    'Energy': Icon(FlutterIcons.energy_sli),
    'Force': Icon(FlutterIcons.repo_force_push_oct),
    'Currency': Icon(FlutterIcons.currency_usd_mco),
    'Density': Icon(FlutterIcons.cup_water_mco),
    'Cookery': Icon(FlutterIcons.bowl_ent),
    'Pressure': Icon(FlutterIcons.speedometer_slow_mco)
  };

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8),
            height: 40,
            child: TextField(
              onChanged: (val) {
                searched = [];
                if (val.isNotEmpty)
                  searching = true;
                else {
                  setState(() {
                    searching = false;
                  });
                  return;
                }
                for (var i in topics.keys) {
                  for (String j in topics[i].keys) {
                    if (j.toLowerCase().startsWith(val.toLowerCase()))
                      searched.add({'Selection': i, 'Conversion': j});
                    print(j + ' ' + val + '${j.startsWith(val)}');
                  }
                }
                print(searched.length);
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          if (!searching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                select,
                style: TextStyle(fontSize: 25),
              ),
            ),
          Column(
            children: <Widget>[
              if (searching)
                for (int j = 0; j < searched.length; j++)
                  Container(
                    height: 75,
                    child: Card(
                        color: colors[1],
                        elevation: 3,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                  onTap: () {
                                    dropint.add(0);
                                    dropint2.add(1);
                                    ind1.add(0);
                                    ind2.add(1);
                                    edits.add([1]);
                                    cards.insert(
                                        0,
                                        Cards(
                                            searched[j]['Selection'],
                                            searched[j]['Conversion'],
                                            cards.length));

                                    widget.cont.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInToLinear);
                                  },
                                  //child: Card(
                                  //margin: EdgeInsets.all(0),
                                  child: Center(
                                    child: Text(
                                      searched[j]['Selection'] +
                                          ' / ' +
                                          searched[j]['Conversion'],
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  )
                                  // ),
                                  ),
                            ),
                            if (select == "Your Conversions")
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () {
                                      deletecards(searched[j]['Conversion']);
                                      deletefromtopics(
                                          searched[j]['Conversion']);
                                      deletefromlocal(
                                          searched[j]['Conversion']);
                                    },
                                    child: Icon(Icons.delete)),
                              )
                            else
                              Expanded(
                                  flex: 1,
                                  child: icons[searched[j]['Conversion']])
                          ],
                        )),
                  )
              else
                for (var i in topics[select].keys)
                  Container(
                    height: 75,
                    child: Card(
                        color: colors[1],
                        elevation: 3,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                  onTap: () {
                                    dropint.add(0);
                                    dropint2.add(1);
                                    ind1.add(0);
                                    ind2.add(1);
                                    edits.add([1]);
                                    cards.insert(
                                        0, Cards(select, i, cards.length));

                                    widget.cont.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInToLinear);
                                  },
                                  //child: Card(
                                  //margin: EdgeInsets.all(0),
                                  child: Center(
                                    child: Text(
                                      i,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  )
                                  // ),
                                  ),
                            ),
                            if (select == "Your Conversions")
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () {
                                      deletecards(i);
                                      deletefromtopics(i);
                                      deletefromlocal(i);
                                    },
                                    child: Icon(Icons.delete)),
                              )
                            else
                              Expanded(flex: 1, child: icons[i])
                          ],
                        )),
                  ),
            ],
          )
        ],
      ),
      Positioned(
        child: Column(
          children: <Widget>[Container()],
        ),
      )
    ]);
  }
}
