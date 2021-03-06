import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:testflutter/constants/consts.dart';
import 'package:testflutter/firestore.dart';
import 'package:testflutter/constructors/alertdialog.dart';
import 'package:url_launcher/url_launcher.dart';

String curClubAnnounce = "";

class ClubAnnouncements extends StatefulWidget {
  const ClubAnnouncements({Key? key}) : super(key: key);

  @override
  _ClubAnnouncementsState createState() => _ClubAnnouncementsState();
}

class _ClubAnnouncementsState extends State<ClubAnnouncements> {
  @override
  Widget build(BuildContext context) {
    curClubAnnounce = masterList[0].clubAnnouncement;
    curClubAnnounce = curClubAnnounce.replaceAll('|n', '\n');
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // padding: const EdgeInsets.only(left: 30),
      height: 250,
      width: screenWidth,
      alignment: Alignment.center,
      child: Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: homeCorners,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 7,
                offset: const Offset(0, 5)),
          ],
        ),
        // the decoration of the red box and text
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: maroon,
                    borderRadius: homeCorners,
                  ),
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Image.asset(
                      "assets/open-mailbox-with-raised-flag_1f4ec.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                ),
                // the two lines of text
                Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 30,
                      width: 200,
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Club Announcements",
                        textScaleFactor: 1.0,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontFamily: "SFBold",
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(top: 6),
                      height: 15,
                      width: 200,
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Club specific news!",
                        textScaleFactor: 1.0,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontFamily: "SF",
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 16, bottom: 12),
                alignment: Alignment.topLeft,
                child: Linkify(
                  text: curClubAnnounce,
                  textScaleFactor: 1.0,
                  maxLines: 7,
                  onOpen: (link) => launch(link.url),
                  style: const TextStyle(fontFamily: "SF"),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.bottomRight,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/clubviewmore");
                    },
                    child: Text(
                      "View More",
                      textScaleFactor: 1.0,
                      style: TextStyle(color: maroon),
                    )),
              ),
            )
            // INSERT TEXT CHILD OR CONTAINER THAT HAS THE TEXT HERE UNDER THIS COMMENT
          ],
        ),
      ),
    );
  }
}
