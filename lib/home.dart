import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      topics['Your Conversions']!.remove(i);
    });
  }

  void deletecards(String i) {
    setState(() {
      cards.removeWhere((element) => element.name == i);
    });
  }

  List<Map<String, String>> searched = [];
  bool searching = false;

  Map<String, FaIcon> icons = {
    'Length': FaIcon(FontAwesomeIcons.ruler),
    'Weight': FaIcon(FontAwesomeIcons.weightHanging),
    'Volume': FaIcon(FontAwesomeIcons.cube),
    'Area': FaIcon(FontAwesomeIcons.rulerCombined),
    'Temperature': FaIcon(FontAwesomeIcons.temperatureHigh),
    'Time': FaIcon(FontAwesomeIcons.clock),
    'Angle': FaIcon(FontAwesomeIcons.greaterThan),
    'Data': FaIcon(FontAwesomeIcons.database),
    'Speed': FaIcon(FontAwesomeIcons.tachometerAlt),
    'Gold': FaIcon(FontAwesomeIcons.coins),
    'Land': FaIcon(FontAwesomeIcons.mountain),
    'Energy': FaIcon(FontAwesomeIcons.plug),
    'Force': FaIcon(FontAwesomeIcons.compressAlt),
    'Currency': FaIcon(FontAwesomeIcons.rupeeSign),
    'Density': FaIcon(FontAwesomeIcons.burn),
    'Cookery': FaIcon(FontAwesomeIcons.blender),
    'Pressure': FaIcon(FontAwesomeIcons.bullseye),
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
                  for (String j in topics[i]!.keys) {
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
                                            searched[j]['Selection'] ?? "",
                                            searched[j]['Conversion'] ?? "",
                                            cards.length));

                                    widget.cont.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInToLinear);
                                  },
                                  //child: Card(
                                  //margin: EdgeInsets.all(0),
                                  child: Center(
                                    child: Text(
                                      searched[j]['Selection'] ??
                                          "" +
                                              ' / ' +
                                              searched[j]['Conversion']!,
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
                                      deletecards(searched[j]['Conversion']!);
                                      deletefromtopics(
                                          searched[j]['Conversion']!);
                                      deletefromlocal(
                                          searched[j]['Conversion']!);
                                    },
                                    child: Icon(Icons.delete)),
                              )
                            else
                              Expanded(
                                  flex: 1,
                                  child: icons[searched[j]['Conversion']]!)
                          ],
                        )),
                  )
              else
                for (var i in topics[select]!.keys)
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
                              Expanded(flex: 1, child: icons[i]!)
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
