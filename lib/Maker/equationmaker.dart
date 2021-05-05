import 'package:convertor/Storage/storage.dart';
import 'package:convertor/value.dart';
import 'package:flutter/material.dart';

class Equationer extends StatefulWidget {
  final int no;
  final List<String> units;
  final String name;
  Equationer({this.name, this.no, this.units});
  @override
  _EquationerState createState() => _EquationerState();
}

enum InputState { starters, number, numberOrOperators, operators }

class _EquationerState extends State<Equationer> {
  PageController pageController = PageController();
  List<List<String>> factors;
  List<List<String>> uifactors;
  InputState inputState = InputState.starters;

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
  void initState() {
    super.initState();
    factors = List<List<String>>.filled(2 * (widget.no), ['', '']);
    factors[0] = ["u", "u"];
    uifactors = List<List<String>>.filled(2 * (widget.no), ['', '']);
    uifactors[0] = ["u", "u"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Equation Maker'),
        ),
        body: PageView(
          controller: pageController,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      "You will be taken to the equation maker page. Use 'u' to denote the measure which is to be converted.\n\n Use Brackets when required. \n\nEg: Equation to convert celcius to farenheit: ( u x 1.8 ) + 32 .",
                      style: TextStyle(fontSize: 19)),
                  TextButton(
                    child: Text('Continue >', style: TextStyle(fontSize: 23)),
                    onPressed: () {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.decelerate);
                    },
                  )
                ],
              ),
            ),
            for (int i = 0; i < (widget.no - 1) * 2; i++)
              Container(
                child: Column(children: [
                  Expanded(
                      child: Center(
                          child: i % 2 == 0
                              ? Text(
                                  'Enter Equation to convert \'u\' ${widget.units[(i + 2) ~/ 2]} to ${widget.units[0]}',
                                  style: TextStyle(fontSize: 20),
                                )
                              : Text(
                                  'Enter Equation to convert \'u\' ${widget.units[0]} to ${widget.units[(i + 2) ~/ 2]}',
                                  style: TextStyle(fontSize: 20),
                                ))),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    uifactors[(i + 2) ~/ 2][(i + 2) % 2],
                                    style: TextStyle(fontSize: 25),
                                  )),
                            )),
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.backspace_outlined),
                            onPressed: () {
                              setState(() {
                                if (uifactors[(i + 2) ~/ 2][(i + 2) % 2]
                                        .length !=
                                    0)
                                  uifactors[(i + 2) ~/ 2][(i + 2) % 2] =
                                      uifactors[(i + 2) ~/ 2][(i + 2) % 2]
                                          .substring(
                                              0,
                                              uifactors[(i + 2) ~/ 2]
                                                          [(i + 2) % 2]
                                                      .length -
                                                  1);
                                while (uifactors[(i + 2) ~/ 2][(i + 2) % 2]
                                            .length !=
                                        0 &&
                                    [
                                      's',
                                      'i',
                                      'n',
                                      'c',
                                      'o',
                                      't',
                                      'a',
                                      'n',
                                      'l',
                                      'o',
                                      'g',
                                      '⁻',
                                      '¹'
                                    ].contains(uifactors[(i + 2) ~/ 2]
                                        [(i + 2) % 2][uifactors[(i + 2) ~/ 2]
                                                [(i + 2) % 2]
                                            .length -
                                        1])) {
                                  uifactors[(i + 2) ~/ 2][(i + 2) % 2] =
                                      uifactors[(i + 2) ~/ 2][(i + 2) % 2]
                                          .substring(
                                              0,
                                              uifactors[(i + 2) ~/ 2]
                                                          [(i + 2) % 2]
                                                      .length -
                                                  1);
                                }
                                if (uifactors[(i + 2) ~/ 2][(i + 2) % 2]
                                        .length !=
                                    0) {
                                  String l = uifactors[(i + 2) ~/ 2]
                                      [(i + 2) % 2][uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2]
                                          .length -
                                      1];
                                  if ([
                                    '0',
                                    '1',
                                    '2',
                                    '3',
                                    '4',
                                    '5',
                                    '6',
                                    '7',
                                    '8',
                                    '9'
                                  ].contains(l))
                                    inputState = InputState.numberOrOperators;
                                  if (['+', '-', 'x', '/', '^', '(']
                                      .contains(l))
                                    inputState = InputState.starters;
                                  if (['u', 'e', ')', 'π'].contains(l))
                                    inputState = InputState.operators;
                                  if (l == '.') inputState = InputState.number;
                                }
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  inputState == InputState.number
                      ? Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    NumberButton(
                                      num: '7',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '7';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '7';
                                        });
                                      },
                                    ),
                                    NumberButton(
                                      num: '8',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '8';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '8';
                                        });
                                      },
                                    ),
                                    NumberButton(
                                      num: '9',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '9';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '9';
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    NumberButton(
                                      num: '4',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '4';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '4';
                                        });
                                      },
                                    ),
                                    NumberButton(
                                      num: '5',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '5';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '5';
                                        });
                                      },
                                    ),
                                    NumberButton(
                                      num: '6',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '6';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '6';
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    NumberButton(
                                      num: '1',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '1';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '1';
                                        });
                                      },
                                    ),
                                    NumberButton(
                                      num: '2',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '2';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '2';
                                        });
                                      },
                                    ),
                                    NumberButton(
                                      num: '3',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '3';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '3';
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                        child: TextButton(
                                      onPressed: () {},
                                      child: Icon(Icons.arrow_left),
                                    )),
                                    NumberButton(
                                      num: '0',
                                      callBack: () {
                                        setState(() {
                                          inputState =
                                              InputState.numberOrOperators;
                                          factors[(i + 2) ~/ 2][(i + 2) % 2] +=
                                              '0';
                                          uifactors[(i + 2) ~/ 2]
                                              [(i + 2) % 2] += '0';
                                        });
                                      },
                                    ),
                                    Expanded(
                                        child: TextButton(
                                      onPressed: () {},
                                      child: Icon(Icons.arrow_right),
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : inputState == InputState.starters
                          ? Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        NumberButton(
                                          num: '7',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '7';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '7';
                                            });
                                          },
                                        ),
                                        NumberButton(
                                          num: '8',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '8';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '8';
                                            });
                                          },
                                        ),
                                        NumberButton(
                                          num: '9',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '9';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '9';
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white30,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 's(';
                                                  uifactors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'sin(';
                                                });
                                              },
                                              child: Text(
                                                'sin(',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        NumberButton(
                                          num: '4',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '4';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '4';
                                            });
                                          },
                                        ),
                                        NumberButton(
                                          num: '5',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '5';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '5';
                                            });
                                          },
                                        ),
                                        NumberButton(
                                          num: '6',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '6';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '6';
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white30,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'c(';
                                                  uifactors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'cos(';
                                                });
                                              },
                                              child: Text(
                                                'cos(',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        NumberButton(
                                          num: '1',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '1';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '1';
                                            });
                                          },
                                        ),
                                        NumberButton(
                                          num: '2',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '2';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '2';
                                            });
                                          },
                                        ),
                                        NumberButton(
                                          num: '3',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '3';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '3';
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white30,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 't(';
                                                  uifactors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'tan(';
                                                });
                                              },
                                              child: Text(
                                                'tan(',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        NumberButton(
                                          num: '0',
                                          callBack: () {
                                            setState(() {
                                              inputState =
                                                  InputState.numberOrOperators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '0';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += '0';
                                            });
                                          },
                                        ),
                                        NumberButton(
                                          num: 'u',
                                          callBack: () {
                                            setState(() {
                                              inputState = InputState.operators;
                                              factors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += 'u';
                                              uifactors[(i + 2) ~/ 2]
                                                  [(i + 2) % 2] += 'u';
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white30,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  uifactors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'sin⁻¹(';
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'S(';
                                                });
                                              },
                                              child: Text(
                                                'sin⁻¹(',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white30,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  uifactors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'cos⁻¹(';
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'C(';
                                                });
                                              },
                                              child: Text(
                                                'cos⁻¹(',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: Colors.white30,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  uifactors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'tan⁻¹(';
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'T(';
                                                });
                                              },
                                              child: Text(
                                                'tan⁻¹(',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.starters;
                                                uifactors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += 'log(';
                                                factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] +=
                                                    'l('; //TODO
                                              });
                                            },
                                            child: Text(
                                              'log(',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.starters;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += 'ln(';
                                              });
                                            },
                                            child: Text(
                                              'ln(',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.starters;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += '9';
                                              });
                                            },
                                            child: Text(
                                              '²√(',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.starters;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += '9';
                                              });
                                            },
                                            child: Text(
                                              '³√(',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.operators;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += 'π';
                                              });
                                            },
                                            child: Text(
                                              'π',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Icon(Icons.arrow_left),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.starters;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += '(';
                                              });
                                            },
                                            child: Text(
                                              '(',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.starters;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += '-';
                                              });
                                            },
                                            child: Text(
                                              '-',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState =
                                                    InputState.operators;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += 'e';
                                              });
                                            },
                                            child: Text(
                                              'e',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                inputState = InputState
                                                    .numberOrOperators;
                                                factors[(i + 2) ~/ 2]
                                                    [(i + 2) % 2] += '9';
                                              });
                                            },
                                            child: Icon(Icons.arrow_right),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : inputState == InputState.numberOrOperators
                              ? Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            NumberButton(
                                              num: '7',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '7';
                                                });
                                              },
                                            ),
                                            NumberButton(
                                              num: '8',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '8';
                                                });
                                              },
                                            ),
                                            NumberButton(
                                              num: '9',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '9';
                                                });
                                              },
                                            ),
                                            OperatorButton(
                                              op: 'x',
                                              callBack: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += 'x';
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            NumberButton(
                                              num: '4',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '4';
                                                });
                                              },
                                            ),
                                            NumberButton(
                                              num: '5',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '5';
                                                });
                                              },
                                            ),
                                            NumberButton(
                                              num: '6',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '6';
                                                });
                                              },
                                            ),
                                            OperatorButton(
                                              op: '/',
                                              callBack: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '/';
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            NumberButton(
                                              num: '1',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '1';
                                                });
                                              },
                                            ),
                                            NumberButton(
                                              num: '2',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '2';
                                                });
                                              },
                                            ),
                                            NumberButton(
                                              num: '3',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '3';
                                                });
                                              },
                                            ),
                                            OperatorButton(
                                              op: '-',
                                              callBack: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '-';
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            NumberButton(
                                              num: '0',
                                              callBack: () {
                                                setState(() {
                                                  inputState = InputState
                                                      .numberOrOperators;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '0';
                                                });
                                              },
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      inputState =
                                                          InputState.number;
                                                      factors[(i + 2) ~/ 2]
                                                          [(i + 2) % 2] += '.';
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.circle,
                                                    size: 9,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            OperatorButton(
                                              op: '^',
                                              callBack: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '^';
                                                });
                                              },
                                            ),
                                            OperatorButton(
                                              op: '+',
                                              callBack: () {
                                                setState(() {
                                                  inputState =
                                                      InputState.starters;
                                                  factors[(i + 2) ~/ 2]
                                                      [(i + 2) % 2] += '+';
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Icon(Icons.arrow_left),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    inputState =
                                                        InputState.operators;
                                                    factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] += ')';
                                                  });
                                                },
                                                child: Text(')',
                                                    style: TextStyle(
                                                        fontSize: 25)),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Icon(Icons.arrow_right),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            OperatorButton(
                                                op: '+',
                                                callBack: () {
                                                  setState(() {
                                                    inputState =
                                                        InputState.starters;
                                                    factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] += '+';
                                                  });
                                                },
                                                size: 35),
                                            OperatorButton(
                                                op: '-',
                                                callBack: () {
                                                  setState(() {
                                                    inputState =
                                                        InputState.starters;
                                                    factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] += '-';
                                                  });
                                                },
                                                size: 35),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            OperatorButton(
                                                op: '/',
                                                callBack: () {
                                                  setState(() {
                                                    inputState =
                                                        InputState.starters;
                                                    factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] += '/';
                                                  });
                                                },
                                                size: 35),
                                            OperatorButton(
                                                op: 'x',
                                                callBack: () {
                                                  setState(() {
                                                    inputState =
                                                        InputState.starters;
                                                    factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] += 'x';
                                                  });
                                                },
                                                size: 35),
                                            OperatorButton(
                                                op: '^',
                                                callBack: () {
                                                  setState(() {
                                                    inputState =
                                                        InputState.starters;
                                                    factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] += '^';
                                                  });
                                                },
                                                size: 35),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Icon(Icons.arrow_left),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    factors[(i + 2) ~/ 2]
                                                        [(i + 2) % 2] += ')';
                                                  });
                                                },
                                                child: Text(')',
                                                    style: TextStyle(
                                                        fontSize: 35)),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Icon(Icons.arrow_right),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                ]),
              ),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      for (int i = 0; i < (widget.no - 1); i++)
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${widget.units[(i + 1)]} to ${widget.units[0]}'),
                                Text('${factors[i + 1][0]}')
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    '${widget.units[0]} to ${widget.units[i + 1]}'),
                                Text('${factors[i + 1][1]}')
                              ],
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                topicadd();
                                localadd();
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
            )
          ],
        ));
  }
}

class NumberButton extends StatelessWidget {
  final String num;
  final Function callBack;
  NumberButton({this.num, this.callBack});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.grey.withOpacity(0.3),
      child: TextButton(
        onPressed: () {
          callBack();
        },
        child: Text(
          num,
          style: TextStyle(fontSize: 25),
        ),
      ),
    ));
  }
}

class OperatorButton extends StatelessWidget {
  final String op;
  final Function callBack;
  final double size;
  OperatorButton({this.op, this.callBack, this.size = 25});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: colors[1].withOpacity(0.3),
      child: TextButton(
        onPressed: () {
          callBack();
        },
        child: Text(
          op,
          style: TextStyle(fontSize: size),
        ),
      ),
    ));
  }
}
