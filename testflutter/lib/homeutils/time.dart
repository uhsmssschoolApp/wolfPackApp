import 'package:intl/intl.dart';

List<String> dates = List.filled(5, "", growable: false);

/*

Displaying period:
findTime --> findPeriod --> period number --> display

0: before school 
1: p1
2: p2
3: lunch
4: p3
5: p4
6: afterschool

*/

int findTime(DateTime now) {
  // converts the time to mintues unit which can be used as
  String date = (DateFormat('Hm').format(now));
  String hoursTemp = "";
  for (int i = 0; i < date.length; i++) {
    if (date[i] == ":") {
      break;
    }
    hoursTemp += date[i];
  }
  int hours = int.parse(hoursTemp) * 60;
  int minutes = int.parse(date.substring(3));
  int time = hours + minutes;
  return time;
}

String greetingMessage(int time) {
  if (time < 720) {
    return "Good Morning!";
  } else if (time < 1080) {
    return "Good Afternoon!";
  } else {
    return "Good Evening!";
  }
}

int findPeriod(int time) {
  //edit this to change the intervals
  // current period
  if (time <= 510) {
    return 0;
  } else if (time <= 595) {
    return 1;
  } else if (time <= 670) {
    return 2;
  } else if (time <= 720) {
    return 3;
  } else if (time <= 800) {
    return 4;
  } else if (time <= 875) {
    return 5;
  } else {
    return 6;
  }
}

String periodNumber(int numPeriod) {
  //edit this to change what each interval displays
  if (numPeriod == 0) {
    return "Before School";
  } else if (numPeriod == 1) {
    return "Period 1";
  } else if (numPeriod == 2) {
    return "Period 3";
  } else if (numPeriod == 3) {
    return "Lunch";
  } else if (numPeriod == 4) {
    return "Period 2";
  } else if (numPeriod == 5) {
    return "Period 4";
  } else {
    return "After School";
  }
}

String timeStamps(int numPeriod) {
  if (numPeriod == 0) {
    return "12:00AM - 8:30AM";
  } else if (numPeriod == 1) {
    return "8:30AM - 9:55AM";
  } else if (numPeriod == 2) {
    return "9:55AM - 11:10AM";
  } else if (numPeriod == 3) {
    return "11:10AM - 12:00PM";
  } else if (numPeriod == 4) {
    return "12:00PM - 1:20PM";
  } else if (numPeriod == 5) {
    return "1:20PM - 2:35PM";
  } else {
    return "2:35PM - 12:00AM";
  }
}

double periodProgress(int time, int curPeriod, double width) {
  //function to fill up the bar
  int period_1 = 85;
  int period = 75;
  int period_4 = 80;
  int lunch = 50;
  if (curPeriod == 0) {
    return 0;
  } else if (curPeriod == 1) {
    int diff = period_1 - (595 - time);
    double divided = ((diff / period) * width);
    return divided;
  } else if (curPeriod == 2) {
    int diff = period - (670 - time);
    double divided = ((diff / period) * width);
    return divided;
  } else if (curPeriod == 3) {
    int diff = lunch - (720 - time);
    double divided = ((diff / lunch) * width);
    return divided;
  } else if (curPeriod == 4) {
    int diff = period_4 - (800 - time);
    print(diff);
    double divided = ((diff / period) * width);
    return divided;
  } else if (curPeriod == 5) {
    int diff = period - (875 - time);
    double divided = ((diff / period) * width);
    return divided;
  } else {
    return width;
  }
}

String goBack(int day, DateTime now) {
  DateTime before = DateTime.now().subtract(Duration(days: day));
  String aDate = DateFormat('EE MMM dd').format(before);
  return aDate;
}

// temporary function
void initDates(DateTime now) {
  dates[4] = DateFormat('EE MMM dd').format(now);
  for (int i = 0; i < 4; i++) {
    dates[i] = goBack(4 - i, now);
  }
}
