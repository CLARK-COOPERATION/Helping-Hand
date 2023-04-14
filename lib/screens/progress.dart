import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/screens/activity.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key}) : super(key: key);

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  int lt4 = 0, b45 = 0, b67 = 0, mt7 = 0, sleepSum = 0;
  int st = 0, j1hm = 0, j2hm = 0, j3lm = 0, j2h1lm = 0, calorieSum = 0;
  int lt3 = 0, b35 = 0, b57 = 0, mmt7 = 0, moodSum = 0;

  Future getSleepData() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var sleepData = await FirebaseDatabase.instance
        .ref('userData/$currentUserId/sleepRates')
        .get();
    return sleepData.value;
  }

  Future getCalorieData() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var calorieData = await FirebaseDatabase.instance
        .ref('userData/$currentUserId/calorieRates')
        .get();
    return calorieData.value;
  }

  Future getMoodData() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var moodData = await FirebaseDatabase.instance
        .ref('userData/$currentUserId/moodRates')
        .get();
    return moodData.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _pageHeading('Progress'),
        Expanded(
          child: ListView(
            children: [
              _subheading('Sleep'),
              FutureBuilder(
                  future: getSleepData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic> sleepValues = snapshot.data;
                      List<dynamic> values = sleepValues.values.toList();
                      for (String i in values) {
                        if ((i == SleepRate.ns.toString()) ||
                            (i == SleepRate.lt4.toString())) {
                          lt4++;
                        } else if (i == SleepRate.b45.toString()) {
                          b45++;
                        } else if (i == SleepRate.b67.toString()) {
                          b67++;
                        } else if (i == SleepRate.mt7.toString()) {
                          mmt7++;
                        }
                        sleepSum++;
                      }
                      return Column(
                        children: [
                          _linearPercentIndicator('0-3 Hrs', lt4 / sleepSum,
                              '${lt4 * 100 ~/ sleepSum}%'),
                          _linearPercentIndicator('3-5 Hrs', b45 / sleepSum,
                              '${b45 * 100 ~/ sleepSum}%'),
                          _linearPercentIndicator('5-7 Hrs', b67 / sleepSum,
                              '${b67 * 100 ~/ sleepSum}%'),
                          _linearPercentIndicator('7-9 Hrs', mmt7 / sleepSum,
                              '${mmt7 * 100 ~/ sleepSum}%'),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("try again later"),
                      );
                    }
                  }),
              _subheading('Food'),
              FutureBuilder(
                  future: getCalorieData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic> calorieValues = snapshot.data;
                      List<dynamic> values = calorieValues.values.toList();
                      for (String i in values) {
                        if (i == CalorieRate.st.toString()) {
                          st++;
                        } else if (i == CalorieRate.j1hm.toString()) {
                          j1hm++;
                        } else if (i == CalorieRate.j2hm.toString()) {
                          j2hm++;
                        } else if (i == CalorieRate.j3lm.toString()) {
                          j3lm++;
                        } else if (i == CalorieRate.j2h1lm.toString()) {
                          j2h1lm++;
                        }
                        calorieSum++;
                      }
                      return Column(
                        children: [
                          _linearPercentIndicator(' Starve ', st / calorieSum,
                              '${st * 100 ~/ calorieSum}%'),
                          _linearPercentIndicator('400 Cal', j1hm / calorieSum,
                              '${j1hm * 100 ~/ calorieSum}%'),
                          _linearPercentIndicator('600 Cal', j2hm / calorieSum,
                              '${j2hm * 100 ~/ calorieSum}%'),
                          _linearPercentIndicator('800 Cal', j3lm / calorieSum,
                              '${j3lm * 100 ~/ calorieSum}%'),
                          _linearPercentIndicator(
                              '900 Cal',
                              j2h1lm / calorieSum,
                              '${j2h1lm * 100 ~/ calorieSum}%'),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("try again later"),
                      );
                    }
                  }),
              _subheading('Mood'),
              FutureBuilder(
                  future: getMoodData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic> moodValues = snapshot.data;
                      List<dynamic> values = moodValues.values.toList();
                      for (int i in values) {
                        if (i < 3) {
                          lt3++;
                        } else if (i > 2 && i < 5) {
                          b35++;
                        } else if (i > 4 && i < 9) {
                          b57++;
                        } else if (i > 8) {
                          mt7++;
                        }
                        moodSum++;
                      }
                      return Column(
                        children: [
                          _linearPercentIndicator('    😞    ', lt3 / moodSum,
                              '${lt3 * 100 ~/ moodSum}%'),
                          _linearPercentIndicator('    😔    ', b35 / moodSum,
                              '${b35 * 100 ~/ moodSum}%'),
                          _linearPercentIndicator('    🙂    ', b57 / moodSum,
                              '${b57 * 100 ~/ moodSum}%'),
                          _linearPercentIndicator('    😀    ', mt7 / moodSum,
                              '${mt7 * 100 ~/ moodSum}%'),
                          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 100)),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("try again later"),
                      );
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Container _pageHeading(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding _subheading(String subHeadingText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        subHeadingText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding _linearPercentIndicator(
      String leadingText, double percentProgress, String trailingText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 0, 20),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Text(
              leadingText,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 250.0,
              percent: percentProgress,
              progressColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              trailingText,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
