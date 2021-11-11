import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about.dart';
import 'value.dart';
import './Maker/maker.dart';
import './Storage/storage.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'convert.dart';

void main() {
  runApp(MyApp());
}

List<Method> fromJson(Map<String, dynamic> json) {
  List<Method> tobereturned = [];
  Method mn = Method(json['base'], json['base'], ["D"], []);
  mn.consts.add([1]);
  for (String s in json['rates'].keys) {
    mn.consts.add([1 / json['rates'][s]]);
  }
  tobereturned.add(mn);
  for (String s in json['rates'].keys) {
    Method m = Method(s, s, ["D"], []);

    m.consts = mn.consts;
    // for (String st in json['rates'].keys)
    //   m.consts.add([json['rates'][s] / json['rates'][st]]);
    tobereturned.add(m);
  }
  Map<String, Map<String, dynamic>> convs = Map();
  Map<String, dynamic> temp = Map();
  temp['equations'] = ['D'];
  temp['factors'] = mn.consts;
  convs[json['base']] = temp;
  for (String name in json['rates'].keys) convs[name] = temp;
  putCurrency('Currency', convs);
  return tobereturned;
}

void fetchAlbum() async {
  try {
    http.Response response =
        await http.get('https://api.exchangeratesapi.io/latest');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      topics['Daily Life']!['Currency'] =
          Conversion(2, fromJson(jsonDecode(response.body)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      getCurrency();
    }
  } catch (e) {
    getCurrency();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      //showSemanticsDebugger: true,
      title: 'Unit Converter',
      theme: ThemeData(
        scaffoldBackgroundColor: colors[0],
        fontFamily: 'primary',
        primaryColor: Color(0xFFFBE5C8),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {
        'select': (context) => Selector(),
        'about': (context) => About(),
        'complex': (context) => Maker(),
      },
    );
  }
}

PageController cont = PageController();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, Widget> icons = {
    'Basics': Icon(Icons.workspaces_filled),
    'Daily Life': Icon(Icons.kitchen_rounded),
    'Basic Physics': Icon(Icons.speed),
    'Your Conversions': Icon(Icons.person),
  };
  @override
  void initState() {
    super.initState();
    fetchAlbum();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Body(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.add),
        // ),
        drawer: Drawer(
          child: Container(
            color: colors[0],
            child: ListView(children: <Widget>[
              Container(
                  height: 150,
                  color: colors[0],
                  child: Center(
                      child: Text(
                    'Convertor',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ))),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: colors[1], borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  title: Text(
                    "New Conversion",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'select');
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '   Categories',
                style: TextStyle(fontSize: 20),
              ),
              for (String i in topics.keys)
                ListTile(
                  leading: icons[i],
                  title: Text(i),
                  onTap: () {
                    setState(() {
                      select = i;
                    });
                    if (cont.page == 1) cont.jumpToPage(0);
                    Navigator.pop(context);
                  },
                ),
              SizedBox(
                height: 20,
              ),
              Text(
                '   About',
                style: TextStyle(fontSize: 20),
              ),
              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Settings'),
              //   onTap: () {
              //     setState(() {
              //       // select = i;
              //     });
              //     // if (cont.page == 1) cont.jumpToPage(0);
              //     Navigator.pop(context);
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About'),
                onTap: () {
                  Navigator.pushNamed(context, 'about');
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    cont = PageController(
      initialPage: 0,
    );
    cont.addListener(() {
      if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cont.addListener(() {});
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      }),
                  Text(
                    " Convertor",
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              Text('\t\t\t\t\t\t\t\t\t\t\t\t\t\tAn easy unit convertor'),
            ],
          ),
        )),
        Expanded(
          flex: 8,
          child: PageView(controller: cont, children: [
            Home(cont),
            Convertor(cont),
          ]),
        ),
      ],
    );
  }
}
