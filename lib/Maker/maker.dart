import 'package:convertor/Maker/complexMaker.dart';
import 'package:convertor/Storage/storage.dart';
import 'package:flutter/material.dart';
import '../value.dart';

class Selector extends StatefulWidget {
  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  bool selectedsimple = true;
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Make a conversion'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Conversion Name",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Conversion name",
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Conversion Type",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedsimple = true;
                    });
                  },
                  child: Card(
                    color: colors[1],
                    elevation: !selectedsimple ? 9 : 2,
                    child: Row(
                      children: [
                        Radio(
                            activeColor: Colors.black,
                            value: 0,
                            groupValue: selectedsimple ? 0 : 1,
                            onChanged: (val) {}),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Simple Conversion",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                                "Values can be converted by mulitplying or dividing a constant.",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedsimple = false;
                    });
                  },
                  child: Card(
                    color: colors[1],
                    elevation: selectedsimple ? 9 : 2,
                    child: Row(
                      children: [
                        Radio(
                            activeColor: Colors.black,
                            value: 1,
                            groupValue: selectedsimple ? 0 : 1,
                            onChanged: (val) {}),
                        Expanded(
                          child: ListTile(
                            title: Text("Complex Conversion",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            subtitle: Text(
                                "Values can be converted by using an equation.",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 3, child: Container()),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text(
                          "Exit",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            if (selectedsimple)
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SimpleMaker(name)));
                            else
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ComplexMaker(name)));
                          },
                          child: Text(
                            'Create',
                            style: TextStyle(fontSize: 25),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class SimpleMaker extends StatefulWidget {
  final String name;
  SimpleMaker(this.name);
  @override
  _SimpleMakerState createState() => _SimpleMakerState();
}

class _SimpleMakerState extends State<SimpleMaker> {
  int no = 1;
  List<String> units = [];
  List<String> short = [""];
  List<List<double>> factors = [
    [1]
  ];
  final snackBar = SnackBar(
      content: Text('Please enter all fields above before making new unit.'));
  final snackBar2 = SnackBar(content: Text('Please make atleast 2 Units'));
  final String firstHelpText =
      'Please enter the first unit of your conversion. eg: gram';
  final String secHelpText =
      'Please enter the next unit of your conversion. eg: Kilogram\nFor conversion factor, Enter "how much of this unit is equal to the first unit?" Eg: 0.001 (0.001 Kg = 1 g)';

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  void localadd() {
    Map<String, Map<String, dynamic>> convs = Map();
    for (int i = 0; i < no; i++) {
      Map<String, dynamic> temp = Map();
      // temp['Short'] = short[i];
      temp['equations'] = ['D'];
      temp['factors'] = factors;
      convs[units[i]] = temp;
    }
    newToMade(widget.name, convs);
  }

  void topicadd() {
    List<List<double>> convs = List.generate(no, (index) {
      return [1 / factors[index][0]];
    });
    topics['Your Conversions'][widget.name] = Conversion(2, [
      for (int i = 0; i < no; i++) Method(units[i], "", ["D"], convs)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Simple Conversion Maker'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: ListView(
                  children: [
                    if (no == 1)
                      Text(firstHelpText, style: TextStyle(fontSize: 18)),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                                decoration: InputDecoration(
                                    // helperMaxLines: 10,
                                    // helperText:
                                    //     'Please Enter the first unit of your conversion. eg: Gram.',
                                    hintText: 'Unit 1',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 5),
                                    focusedBorder: OutlineInputBorder(),
                                    border: OutlineInputBorder()),
                                onChanged: (val) {
                                  setState(() {
                                    if (units.length == 0)
                                      units.add(val);
                                    else
                                      units[0] = val;
                                  });
                                }),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("1"),
                        )),
                      ],
                    ),
                    for (int i = 0; i < no - 1; i++)
                      Column(
                        children: [
                          if (i == no - 2)
                            Text(secHelpText, style: TextStyle(fontSize: 18)),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Unit ${i + 2}',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 5),
                                        focusedBorder: OutlineInputBorder(),
                                        border: OutlineInputBorder()),
                                    onChanged: (val) {
                                      setState(() {
                                        while (units.length < i + 2)
                                          units.add('');
                                        units[i + 1] = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Conversion Factor',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 5),
                                        focusedBorder: OutlineInputBorder(),
                                        border: OutlineInputBorder()),
                                    onChanged: (val) {
                                      setState(() {
                                        if (isNumeric(val)) {
                                          while (factors.length < i + 2)
                                            factors.add([0]);
                                          factors[i + 1][0] = double.parse(val);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: w(38.0, context)),
                        child: Builder(builder: (BuildContext context) {
                          return TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.resolveWith<
                                        RoundedRectangleBorder>(
                                    (_) => RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              child: Text("+ Add Unit"),
                              onPressed: () {
                                setState(() {
                                  if (factors.length == no &&
                                      units.length == no)
                                    no++;
                                  else
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                });
                              });
                        }))
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 22),
                          )),
                    ),
                    Expanded(
                      child: Builder(builder: (BuildContext context) {
                        return TextButton(
                            onPressed: () {
                              if (no < 2)
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar2);
                              else {
                                topicadd();
                                localadd();
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Create",
                              style: TextStyle(fontSize: 22),
                            ));
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Maker extends StatefulWidget {
  @override
  _MakerState createState() => _MakerState();
}

class _MakerState extends State<Maker> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [Text(""), GridView.count(crossAxisCount: 4)],
    ));
  }
}
