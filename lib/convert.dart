import 'package:convertor/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'value.dart';

class Convertor extends StatefulWidget {
  final PageController cont;
  Convertor(this.cont);
  @override
  _ConvertorState createState() => _ConvertorState();
}

class _ConvertorState extends State<Convertor> {
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
    widget.cont.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInToLinear);
    return true;
  }

  // List<TextEditingController> _text = List.generate(cards.length,
  //     (index) => TextEditingController(text: '${edits[index][0]}'));
  int index;
  //List<int> v1=0,v2=1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ListView(
        reverse: true,
        //controller: ScrollController(initialScrollOffset: -10),
        children: <Widget>[
          Container(
            height: 290,
          ),
          for (Cards i in cards)
            ConversionCard(i, () {
              setState(() {});
            }),
          if (cards.length == 0)
            Center(
              child: Text(
                'No Active Conversions!',
                style: TextStyle(color: Colors.grey, fontSize: 30),
              ),
            )
        ],
      ),
    );
  }
}
