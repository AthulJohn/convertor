import 'package:flutter/material.dart';

import '../value.dart';

class ConversionCard extends StatefulWidget {
  final Cards i;
  final Function setIt;
  ConversionCard(this.i, this.setIt);
  @override
  _ConversionCardState createState() => _ConversionCardState();
}

class _ConversionCardState extends State<ConversionCard> {
  @override
  initState() {
    super.initState();
    text = TextEditingController(text: '${edits[widget.i.index][0]}');
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  TextEditingController text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.all(8),
      // decoration: BoxDecoration(borderRadius:BorderRadius.circular(20)),
      child: Card(
        color: colors[1],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.i.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.grey.withOpacity(0.9),
                          onPressed: () {
                            cards.removeAt(cards.indexOf(widget.i));

                            widget.setIt();
                          }),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  // Expanded(
                  //   flex: 9,
                  // child:
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: colors[1],
                      child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLength: 20,
                          keyboardType: TextInputType.number,
                          controller: text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 14),
                            counterText: "",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5),
                                borderRadius: BorderRadius.circular(20)),
                            focusColor: colors[1],
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black87, width: 1),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onChanged: (val) {
                            setState(() {
                              if (isNumeric(val) && text.text.isNotEmpty) {
                                edits[widget.i.index][0] = double.parse(val);
                              }
                            });
                          }),
                    ),
                  ),
                  // ),
                  // Expanded(
                  //   child: SizedBox(),
                  // ),
                  // Expanded(
                  //     flex: 2,
                  //     child: Text(
                  //       topics[i.type][i.name]
                  //           .methods[dropint[i.index]]
                  //           .char,
                  //       style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold),
                  //     )),
                  // Expanded(
                  //   child: SizedBox(),
                  // ),

                  //   ],
                  // ),
                  Expanded(
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              // flex: 9,
                              child: Container(
                                color: colors[2],
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors[1],
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30)),
                                    // border: Border.all(width: 1)
                                  ),
                                  child: Center(
                                    child: DropdownButton(
                                      icon: Icon(Icons.keyboard_arrow_up),
                                      underline: Container(),
                                      value: dropint[widget.i.index],
                                      onChanged: (val) {
                                        setState(() {
                                          //dropval[i.index] =conversions[i.no].methods[val].name;
                                          dropint[widget.i.index] = val;
                                        });
                                      },
                                      items: [
                                        for (int j = 0;
                                            j <
                                                topics[widget.i.type]
                                                        [widget.i.name]
                                                    .methods
                                                    .length;
                                            j++)
                                          DropdownMenuItem(
                                              value: j,
                                              child: Text(
                                                '${topics[widget.i.type][widget.i.name].methods[j].name}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              // flex: 9,
                              child: Container(
                                color: colors[1],
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors[2],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30)),
                                    // border: Border.all(width: 1)
                                  ),
                                  child: Center(
                                    child: DropdownButton(
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      underline: Container(),
                                      value: dropint2[widget.i.index],
                                      onChanged: (val) {
                                        setState(() {
                                          //dropval2[i.index] =conversions[i.no].methods[val].name;
                                          dropint2[widget.i.index] = val;
                                        });
                                      },
                                      items: [
                                        for (int j = 0;
                                            j <
                                                topics[widget.i.type]
                                                        [widget.i.name]
                                                    .methods
                                                    .length;
                                            j++)
                                          DropdownMenuItem(
                                              value: j,
                                              child: Text(
                                                '${topics[widget.i.type][widget.i.name].methods[j].name}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Center(
                            child: IconButton(
                          icon: Icon(
                            Icons.swap_vert_circle_outlined,
                            size: 30,
                          ),
                          onPressed: () {
                            int temp = dropint[widget.i.index];
                            dropint[widget.i.index] = dropint2[widget.i.index];
                            dropint2[widget.i.index] = temp;
                            setState(() {});
                          },
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: colors[2],
                      child: Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              text.text.isNotEmpty
                                  ? "${topics[widget.i.type][widget.i.name].methods[dropint[widget.i.index]].getvalue(edits[widget.i.index][0], dropint2[widget.i.index], dropint[widget.i.index], widget.i.type == 'Your Conversions')}"
                                  : '',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
