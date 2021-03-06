import 'package:flutter/material.dart';
import 'package:testflutter/constants/consts.dart';
import 'package:testflutter/constructors/nav.dart';
import 'package:testflutter/pages/links.dart';

import '../constructors/appbar.dart';

DateTime? _lastQuitTime;

class more extends StatelessWidget {
  const more({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> morePaths = <String>[
      "/themesettings", // DOESNT EXIST DONT ACCESS 0TH INDEX!!
      "/notifications",
      "/resources",
      "/feedback",
      "/faq"
    ];
    return WillPopScope(
      onWillPop: () async {
        if (_lastQuitTime == null ||
            DateTime.now().difference(_lastQuitTime!).inSeconds > 4) {
          _lastQuitTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Press back Button again to exit')));
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: Nav(),
        appBar: mainAppBar("More", false),
        body: ListView(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "General Settings",
                style: subTitle,
              ),
            ),
            Card(
              // margin: const EdgeInsets.only(top: 4),
              child: ListTile(
                leading: Icon(Icons.circle_notifications),
                trailing: arrowRight,
                title: Text(
                  "Notifications",
                  style: settingTiles,
                ),
                onTap: () {
                  Navigator.pushNamed(context, morePaths[1]);
                },
              ),
            ),
            Container(
              height: 70,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16),
              child: Text(
                "Your Voice",
                style: subTitle,
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.book_rounded),
                trailing: arrowRight,
                onTap: () {
                  // Navigator.pushNamed(context, morePaths[2]);
                  launchURL(libraryResources);
                },
                title: Text(
                  "Resources",
                  style: settingTiles,
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, morePaths[3]);
                },
                leading: Icon(Icons.record_voice_over_outlined),
                title: Text(
                  "Feedback",
                  style: settingTiles,
                ),
                trailing: arrowRight,
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, morePaths[4]);
                },
                leading: Icon(Icons.help),
                title: Text(
                  "FAQ",
                  style: settingTiles,
                ),
                trailing: arrowRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
