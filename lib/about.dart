import 'package:convertor/value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[0],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('About'),
        backgroundColor: colors[1],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Whether you like the app, or not, feel free to rate.\nYour feedback helps us to improve this app.'),
                TextButton(
                  style: ButtonStyle(shape:
                      MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                    return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15));
                  }), backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((_) {
                    return colors[1];
                  }), padding:
                      MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                          (_) {
                    return EdgeInsets.symmetric(horizontal: 15, vertical: 5);
                  })),
                  child: Text(
                    'Rate now',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if (await canLaunch(
                        'https://play.google.com/store/apps/')) {
                      await launch('https://play.google.com/store/apps/');
                    } else {
                      throw 'Could not launch "https://play.google.com/store/apps/"';
                    }
                  },
                )
              ],
            )),
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [Text('Credits'), Text('')],
              )),
          Expanded(
              child: Column(
            children: [
              Text(
                'Incase you have any complaints or suggestions about the app, you can mail us right here...',
                textAlign: TextAlign.center,
              ),
              TextButton(
                style: ButtonStyle(shape:
                    MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15));
                }), backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((_) {
                  return colors[1];
                }), padding:
                    MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((_) {
                  return EdgeInsets.symmetric(horizontal: 15, vertical: 5);
                })),
                child: Text(
                  'Mail us',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  if (await canLaunch(
                      'mailto:athulpulickaljohn@gmail.com?subject=Suggestions%20about%20Convertor%20App')) {
                    await launch(
                        'mailto:athulpulickaljohn@gmail.com?subject=Suggestions%20about%20Convertor%20App');
                  } else {
                    throw 'Could not launch "mailto:athulpulickaljohn@gmail.com?subject=Suggestions%20about%20Convertor%20App"';
                  }
                },
              )
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Developed by Athul John'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(FlutterIcons.gmail_mco),
                    onPressed: () async {
                      if (await canLaunch(
                          'mailto:athulpulickaljohn@gmail.com')) {
                        await launch('mailto:athulpulickaljohn@gmail.com');
                      } else {
                        throw 'mailto:athulpulickaljohn@gmail.com"';
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(FlutterIcons.github_box_mco),
                    onPressed: () async {
                      if (await canLaunch('https://github.com/AthulJohn')) {
                        await launch('https://github.com/AthulJohn');
                      } else {
                        throw 'Could not launch "https://github.com/AthulJohn"';
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(FlutterIcons.linkedin_mco),
                    onPressed: () async {
                      if (await canLaunch(
                          'https://www.linkedin.com/in/athuljohnprofile/')) {
                        await launch(
                            'https://www.linkedin.com/in/athuljohnprofile/');
                      } else {
                        throw 'Could not launch "https://www.linkedin.com/in/athuljohnprofile/"';
                      }
                    },
                  )
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
