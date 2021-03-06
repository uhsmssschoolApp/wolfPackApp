import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testflutter/constructors/appbar.dart';
import 'package:testflutter/firestore.dart';
import 'package:testflutter/homeutils/announcements.dart';
import 'package:testflutter/homeutils/calendarcard.dart';
import 'package:testflutter/homeutils/covidscreening.dart';
import 'package:testflutter/homeutils/timecard.dart';
import 'package:testflutter/homeutils/title.dart';
import 'package:testflutter/homeutils/weathercard.dart';
import 'package:testflutter/constructors/nav.dart';
import 'package:testflutter/homeutils/time.dart';
import 'package:webview_flutter/webview_flutter.dart';

int minutesTime = 0;
String curDate = "";
double globalWidth = 0.0;
String curTime = "";
DateTime now = DateTime.now();
String announcementDate = "";
String currentAnnounce = "";
int dateIndex = 4;
DateTime? _lastQuitTime;

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// bool test = true;

class _HomeState extends State<home> {

  
  Future<void> getData() async {
    await fillList();
    setState(() {
      // displayCurrentRotation = masterList.first.rotation;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    globalWidth = screenWidth;
    return WillPopScope(
      onWillPop: () async {
        if (_lastQuitTime == null ||
            DateTime.now().difference(_lastQuitTime!).inSeconds > 4) {
          _lastQuitTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            'Press back button again to exit',
            style: TextStyle(fontFamily: "SF"),
          )));
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: Nav(),
        appBar: mainAppBar("Home", false),
        body: RefreshIndicator(
          onRefresh: getData,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                titleRow(context),
                // timecard
                const timeCard(),
                // container for more text
                Container(
                  margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                  width: screenWidth * 0.9,
                  height: 50,
                  child: const Text(
                    "More",
                    style: TextStyle(
                      fontFamily: "SFBold",
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // covid screening form widget
                    const covidScreening(),
                    // announcements widget
                    const AnnouncementsCard(),
                    // weather widget
                    const WeatherCard(),
                    // school calendar
                    const CalendarCard(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // home related functions

  void getDate() {
    now = DateTime.now();
    String date = (DateFormat('EEEE MMMM d').format(now));
    if (mounted) {
      setState(() {
        curDate = date;
        minutesTime = findTime(now);
      });
    }
  }

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    initDates(now);
    curDate = DateFormat('EEEE MMMM d').format(now);
    minutesTime = findTime(now);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      getDate();
    });
    super.initState();
  }
}
