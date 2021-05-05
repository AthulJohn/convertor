import 'package:flutter/material.dart';
import '../value.dart';
import '../Storage/storage.dart';
import 'equationmaker.dart';

class ComplexMaker extends StatefulWidget {
  final String name;
  ComplexMaker(this.name);
  @override
  _ComplexMakerState createState() => _ComplexMakerState();
}

class _ComplexMakerState extends State<ComplexMaker> {
  // List firstthings = [
  //   "a",
  //   1,
  //   2,
  //   3,
  //   "(",
  //   4,
  //   5,
  //   6,
  //   "e",
  //   7,
  //   8,
  //   9,
  //   "π",
  //   "-",
  //   0,
  //   ".",
  //   "√",
  //   "3√",
  //   "4√",
  //   "5√",
  //   "sin",
  //   "cos",
  //   "tan",
  //   "log",
  //   "arcsin",
  //   "arccos",
  //   "arctan",
  //   "ln"
  // ];
  // List secondthings = [
  //   "+",
  //   1,
  //   2,
  //   3,
  //   "-",
  //   4,
  //   5,
  //   6,
  //   "*",
  //   7,
  //   8,
  //   9,
  //   "/",
  //   "^",
  //   0,
  //   ")"
  // ];
  // List thirdthings = ["+", "-", "*", "/", "^", ")"];
  // List numbers = ["",1, 2, 3,"", 4, 5, 6,"", 7, 8, 9,"","", 0,""];
  // int current = 2;
  // List<Widget> columns = [];

  int no = 1;
  List<String> units = [];
  List<String> short = [""];
// List<String> equations = ["0a*"];
//  List<List<double>> constants = [
//     [1]
  // ];
  final snackBar = SnackBar(
      content: Text('Please enter all fields above before making new unit.'));
  final snackBar2 = SnackBar(content: Text('Please make atleast 2 Units'));
  bool isdetailed = false;
  String details = 'Click here for detailed instructions...';
  String clickHere = 'Click here for less instructions...';
  String detailed =
      '''    Make sure to use brackets to indicate priority of operations.
         Here are the operations and operands you can use:
         a : The value given to convert (of the first unit)
         x : The value given to convert (use in Equation 2)
         + , - , * , / , ^ :Addition, Substraction, Multiplication, Division, and Power respectively
         s() : sin function
         c() : cos function
         t() : tan function
         l() : log function
         L() : natural logarithm function
         S() : arcsin function
         C() : arccos function
         T() : arctan function
         e : value of e
         p : value of pi
         √ : Root of [ 3√1000 means cube root of 1000 ]
         ) , ( : brackets used for indicating priority
         0-9 , . : constants
         
         So the equation for converting Farenheit (if the first unit is degree Celcius) would look like (a*1.8)+32 or a*(1.8)+32 or a*1.8+32.\n
         and its Equation 2 would look like (x-32)/1.8''';
  String lessdetailed =
      'Equation 1 of x: Equation to convert the first unit to x. So automatically, Equation 1 of the first unit becomes a. (a is used to denote first unit)\n' +
          'Equation 2 of x: Equation to convert x to a, where a is the first unit.';
  String firstunitdesc = 'Enter the name of the first unit. (Eg: gram)';
  String nextunitdesc = 'Enter the name of the next unit.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Complex Conversion Maker"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: ListView(
                  children: [
                    // Text(isdetailed ? detailed : lessdetailed,
                    //     style: TextStyle(fontSize: 18)),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       isdetailed = !isdetailed;
                    //     });
                    //   },
                    //   child: Text(
                    //     isdetailed ? clickHere : details,
                    //     style: TextStyle(
                    //         color: Colors.blue,
                    //         decoration: TextDecoration.underline),
                    //   ),
                    // ),
                    if (no == 1)
                      Text(firstunitdesc, style: TextStyle(fontSize: 18)),
                    // Row(
                    //   children: [
                    //     Expanded(
                    // child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          decoration: InputDecoration(
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
                    // ),
                    //     Expanded(
                    //         child: Padding(
                    //       padding: const EdgeInsets.all(13.0),
                    //       child: Text("a"),
                    //     )),
                    //   ],
                    // ),
                    for (int i = 0; i < no - 1; i++)
                      Column(
                        children: [
                          if (no - 2 == i)
                            Text(nextunitdesc, style: TextStyle(fontSize: 18)),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child:
                          Padding(
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
                                  while (units.length < i + 2) units.add('');
                                  units[i + 1] = val;
                                });
                              },
                            ),
                          ),
                          //     ),
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: TextField(
                          //           decoration: InputDecoration(
                          //               hintText: 'Equation 1',
                          //               contentPadding: EdgeInsets.symmetric(
                          //                   vertical: 0, horizontal: 5),
                          //               focusedBorder: OutlineInputBorder(),
                          //               border: OutlineInputBorder()),
                          //           onChanged: (val) {
                          //             setState(() {
                          //               while (factors.length < i + 2)
                          //                 factors.add(['', '']);
                          //               factors[i + 1][0] = val;
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Expanded(child: Container()),
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: TextField(
                          //           decoration: InputDecoration(
                          //               hintText: 'Equation 2',
                          //               contentPadding: EdgeInsets.symmetric(
                          //                   vertical: 0, horizontal: 5),
                          //               focusedBorder: OutlineInputBorder(),
                          //               border: OutlineInputBorder()),
                          //           onChanged: (val) {
                          //             setState(() {
                          //               while (factors.length < i + 2)
                          //                 factors.add(['', '']);
                          //               factors[i + 1][1] = val;
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: w(38.0, context)),
                      child: Builder(builder: (BuildContext context) {
                        return TextButton(
                            // shape: RoundedRectangleBorder(
                            //     side: BorderSide(width: 1, color: Colors.black),
                            //     borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "+ Add Unit",
                            ),
                            onPressed: () {
                              setState(() {
                                if (units.length == no)
                                  no++;
                                else
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                              });
                            });
                      }),
                    )
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
                              else if (units.length != no) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Equationer(
                                            no: no,
                                            units: units,
                                            name: widget.name)));
                              }
                            },
                            child: Text(
                              "Continue",
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

class FactorInputer extends StatefulWidget {
  final int no;
  final String name;
  final List<String> units;
  FactorInputer({this.name, this.no, this.units});
  @override
  _FactorInputerState createState() => _FactorInputerState();
}

class _FactorInputerState extends State<FactorInputer> {
  List<List<String>> factors = [
    ["a", "x"]
  ];
  List<List<String>> equationsc = [
    ["0a*", "0a*"]
  ];
  List<List<List<double>>> constantsc = [
    [
      [1],
      [1]
    ]
  ];

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  int getl(List lst, {int sub = 0}) {
    if (lst == null)
      return 0;
    else if (lst.length - sub < 0)
      return 0;
    else
      return lst.length - sub;
  }

  void localadd() {
    Map<String, Map<String, dynamic>> convs = Map();
    for (int i = 0; i < widget.no; i++) {
      Map<String, dynamic> temp = Map();
      // temp['Short'] = short[i];
      temp['equations'] = [equationsc[i][1]] +
          [for (int j = 0; j < widget.no; j++) equationsc[j][0]];
      temp['factors'] = [constantsc[i][1]] +
          [for (int j = 0; j < widget.no; j++) constantsc[j][0]];
      convs[widget.units[i]] = temp;
    }
    newToMade(widget.name, convs);
  }

  void topicadd() {
    topics['Your Conversions'][widget.name] = Conversion(2, [
      for (int i = 0; i < widget.no; i++)
        Method(
            widget.units[i],
            "",
            [equationsc[i][1]] +
                [for (int j = 0; j < widget.no; j++) equationsc[j][0]],
            [constantsc[i][1]] +
                [for (int j = 0; j < widget.no; j++) constantsc[j][0]])
    ]);
    for (int i = 0; i < widget.no; i++) {
      debugPrint(equationsc[i][1] +
          [for (int j = 0; j < widget.no; j++) equationsc[j][0]].toString());

      debugPrint(constantsc[i][1].toString() +
          [for (int j = 0; j < widget.no; j++) constantsc[j][0]].toString());
    }
  }

  int findnum(int j, int i, int q) {
    int k;
    double no = 0;
    double isdec = 1;
    for (k = j;
        k < factors[i][q].length &&
            ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '.']
                .contains(factors[i][q][k]);
        k++) {
      if (factors[i][q][k] == '.' && isdec == 1) {
        isdec = 0.1;
      } else if (isdec == 1)
        no = no * 10 + double.parse(factors[i][q][k]);
      else if (factors[i][q][k] != '.') {
        no += isdec * double.parse(factors[i][q][k]);
        isdec = isdec / 10;
      } else {}
    }
    constantsc[i][q].add(no);
    if (k == factors[i][q].length) k++;
    return k;
  }

  bool convertequations() {
    for (int i = 1; i < widget.no; i++) {
      debugPrint("Success:$i");
      equationsc.add(['', '']);
      constantsc.add([[], []]);
      // double no = 0;
      // double isnum = -1;
      for (int w = 0; w < 2; w++) {
        String stack = '';

        for (int j = 0; j < factors[i][w].length; j++) {
          debugPrint("Successj:$j");
          var k = factors[i][w][j];
          if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].contains(k)) {
            debugPrint("Successin:$j");
            j = findnum(j, i, w) - 1;
            debugPrint("Successout:$j");
            equationsc[i][w] += (constantsc[i][w].length - 1).toString();
          }
          //  {
          //   if (isnum == 0)
          //     no = 10 * no + int.parse(k);
          //   else if (isnum == -1) {
          //     no = double.parse(k);
          //     isnum = 0;
          //   } else {
          //     no = no + isnum * double.parse(k);
          //     isnum = isnum / 10;
          //   }
          // } else if (k == '.' && isnum == 0) {
          //   isnum = 0.1;
          // } else if (isnum != -1) {
          //   isnum = -1;

          //   no = 0;}

          else if (k == 'e' || k == 'p')
            equationsc[i][w] += k;
          else if (['(', 's', 'S', 'c', 'C', 't', 'T', 'l', 'L'].contains(k)) {
            stack = stack + factors[i][w][j];
          } else if (k == '^' || k == '√') {
            for (int q = getl(stack.split("")) - 1; q >= 0; q--) {
              if (stack[q] == '^' || stack[q] == '√') {
                equationsc[i][w] += stack[q];
                stack = stack.substring(0, getl(stack.split(""), sub: 1));
              } else
                break;
            }
            stack += k;

            // while (['*', '/'].contains(stack[stack.length - 1])) {
            //   equations[i] += stack[stack.length - 1];
            //   stack = stack.substring(0, stack.length - 2) + k;
            // }
          } else if (['*', '/'].contains(k)) {
            for (int q = getl(stack.split("")) - 1; q >= 0; q--) {
              if (stack[q] == '*' ||
                  stack[q] == '/' ||
                  stack[q] == '^' ||
                  stack[q] == '√') {
                equationsc[i][w] += stack[q];
                stack = stack.substring(0, getl(stack.split(""), sub: 1));
              } else
                break;
            }
            stack += k;

            // while (['*', '/'].contains(stack[stack.length - 1])) {
            //   equations[i] += stack[stack.length - 1];
            //   stack = stack.substring(0, stack.length - 2) + k;
            // }
          } else if (['-', '+'].contains(k)) {
            for (int q = getl(stack.split("")) - 1; q >= 0; q--) {
              if (stack[q] == '*' ||
                  stack[q] == '/' ||
                  stack[q] == '-' ||
                  stack[q] == '+' ||
                  stack[q] == '^' ||
                  stack[q] == '√') {
                equationsc[i][w] += stack[q];
                if (q != 0)
                  stack = stack.substring(0, getl(stack.split(""), sub: 1));
              } else
                break;
            }
            stack += k;

            // while (['*', '/', '+', '-'].contains(stack[stack.length - 1])) {
            //   equations[i] += stack[stack.length - 1];
            //   stack = stack.substring(0, stack.length - 2) + k;
            // }
          } else if (k == 'a' || k == 'x')
            equationsc[i][w] += k;
          else if (k == ')') {
            //print("${stack[stack.length - 1]}...........");
            for (int q = getl(stack.split("")) - 1; q >= 0; q--) {
              if (stack[q] == '(') break;
              // if (stack[q] == '*' || stack[q] == '/'||stack[q] == '-' || stack[q] == '+') {
              // print("stackkkk::-:" + stack[q] + stack.length.toString());
              equationsc[i][w] += stack[q];
              // print(getl(stack.split(""), sub: 1));
              stack = stack.substring(0, getl(stack.split(""), sub: 1));
            }
            stack = stack.substring(0, getl(stack.split(""), sub: 1));
            if (stack.length > 0) if (['s', 'S', 'c', 'C', 't', 'T', 'l', 'L']
                .contains(stack[getl(stack.split(""), sub: 1)])) {
              equationsc[i][w] += stack[stack.length - 1];
              stack = stack.substring(0, getl(stack.split(""), sub: 1));
            }
          } else {
            debugPrint("Is it wrong...");
            return false;
          }
        }
        for (int q = getl(stack.split(""), sub: 1); q >= 0; q--) {
          if (stack[q] != '(') equationsc[i][w] += stack[q];
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Complex Conversion Maker"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: ListView(
                  children: [
                    for (int i = 1; i < widget.no; i++)
                      Column(
                        children: [
                          Text(
                              "Enter Equation to convert ${widget.units[i]} into ${widget.units[0]}. Eg: 2.5*a+36",
                              style: TextStyle(fontSize: 18)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText:
                                      "Enter Equation to convert ${widget.units[i]} into ${widget.units[0]}",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  focusedBorder: OutlineInputBorder(),
                                  border: OutlineInputBorder()),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                          Text(
                              "Enter Equation to convert ${widget.units[i]} into ${widget.units[0]}. Eg: 2.5*a+36",
                              style: TextStyle(fontSize: 18)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText:
                                      "Enter Equation to convert z ${widget.units[0]} into ${widget.units[i]}",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  focusedBorder: OutlineInputBorder(),
                                  border: OutlineInputBorder()),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
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
                              try {
                                convertequations();
                                topicadd();
                                localadd();
                              } catch (e) {
                                debugPrint(e);
                              }
                              Navigator.pop(context);
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

// Column(
//         children: [
//           Expanded(
//               child: ),
//           Expanded(
//               child: GridView.count(
//                 crossAxisCount: 4,
//                 children: [
//                   if (current == 1)
//                     for (int i = 0; i < 28; i++)
//                       Center(
//                           child: Text(
//                         "${firstthings[i]}",
//                         style: TextStyle(fontSize: 25),
//                       ))
//                   else if (current == 2)
//                     for (int i = 0; i < 16; i++)
//                       Center(
//                           child: Text(
//                         "${secondthings[i]}",
//                         style: TextStyle(fontSize: 25),
//                       ))
//                   else if(current==3)
//                     for (int i = 0; i < 16; i++)
//                       Center(
//                           child: Text(
//                         "${thirdthings[i]}",
//                         style: TextStyle(fontSize: 25),
//                       ))
//                   else
//                     for (int i = 0; i < 6; i++)
//                       Center(
//                           child: Text(
//                         "${numbers[i]}",
//                         style: TextStyle(fontSize: 25),
//                       ))
//                 ],
//               ),
//               flex: 3),
//           Text("'a' indicates the value to be converted")
//         ],
//       ),
