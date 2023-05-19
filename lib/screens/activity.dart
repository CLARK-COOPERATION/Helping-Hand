import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

enum SleepRate { lt4, b45, b67, mt7, ns }

enum CalorieRate { j1hm, j2hm, j3lm, j2h1lm, st }

enum ScreenTimeRate { let2, be24, be46, mot6 }

class _ActivityState extends State<Activity> {
  final PageController _controller = PageController(initialPage: 0);
  SleepRate? _sleepRate = SleepRate.lt4;
  CalorieRate? _calorieRate = CalorieRate.j1hm;
  ScreenTimeRate? _screenTimeRate = ScreenTimeRate.let2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _pageHeading('Activity'),
        Expanded(
          child: PageView(
            controller: _controller,
            children: [
              Column(
                children: [
                  const Text(
                    "Routine Updates",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          const Text(
                            "Sleep",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _sleepTile('Less than 4 hours of sleep', SleepRate.lt4),
                          _sleepTile('4 to 6 hours of sleep', SleepRate.b45),
                          _sleepTile('6 to 7 hours of sleep', SleepRate.b67),
                          _sleepTile('More than 7 hours of sleep', SleepRate.mt7),
                          _sleepTile('Did not sleep', SleepRate.ns),
                          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15)),
                          const Text(
                            "Food",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _foodTile('1 Heavy Meal', CalorieRate.j1hm),
                          _foodTile('3 Light Meals', CalorieRate.j3lm),
                          _foodTile('2 Heavy Meals', CalorieRate.j2hm),
                          _foodTile(
                              '2 Heavy and 1 Light Meals', CalorieRate.j2h1lm),
                          _foodTile('Starving', CalorieRate.st),
                          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15)),
                          const Text(
                            "Screen Time",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          _screenTimeTile('Less than 2 hours of screen time', ScreenTimeRate.let2),
                          _screenTimeTile('2 to 4 hours of screen time', ScreenTimeRate.be24),
                          _screenTimeTile('4 to 6 hours of screen time', ScreenTimeRate.be46),
                          _screenTimeTile('More than 6 hours of screen time', ScreenTimeRate.mot6),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                                backgroundColor:
                                Theme.of(context).colorScheme.primary,
                                elevation: 15,
                                shape: const StadiumBorder(), //Colors.tealAccent,
                              ),
                              onPressed: () {
                                updateActivityInBackend(_sleepRate!.toString(),
                                    _calorieRate!.toString(),_screenTimeRate!.toString());
                                setState(() {
                                  _controller.animateToPage(1,
                                      duration: const Duration(milliseconds: 1000),
                                      curve: Curves.easeInOut);
                                });
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(const Duration(seconds: 1),
                                              () {
                                            Navigator.of(context).pop(true);
                                          });
                                      return AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        content: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Lottie.network(
                                                'https://assets10.lottiefiles.com/packages/lf20_obhph3sh.json'),
                                            Lottie.network(
                                                'https://assets10.lottiefiles.com/packages/lf20_wkebwzpz.json'),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: const Text('Submit!!'),
                            ),
                          )
                        ],
                      ))
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Meditation",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                    _meditationBox(
                        'Inhale and count for 5, Exhale and count for 5. Continue this breathing pattern for at least a few minutes'),
                    _meditationBox(
                        'Start by kneading the muscles at the back of your neck and then shoulders. Ake a loose fist and drum swiftly up and down the sides and back of your neck.'),
                    _meditationBox(
                        'Once you’re comfortable with sitting meditation and the body scan, you might want to try walking meditation. There’s no rule against trying walking meditation first, but it’s useful to learn the basics before you try to walk and meditate at the same time.'),
                    _meditationBox('More coming soon Stay tuned!!..'),
                  ],
                ),
              )
            ],
          ),
        )
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

  RadioListTile _sleepTile(String text, SleepRate sleepRateValue) {
    return RadioListTile(
      title: Text(text),
      groupValue: _sleepRate,
      value: sleepRateValue,
      onChanged: (value) {
        setState(() {
          _sleepRate = value;
        });
      },
    );
  }

  RadioListTile _foodTile(String text, CalorieRate calorieRateValue) {
    return RadioListTile(
      title: Text(text),
      groupValue: _calorieRate,
      value: calorieRateValue,
      onChanged: (value) {
        setState(() {
          _calorieRate = value;
        });
      },
    );
  }

  RadioListTile _screenTimeTile(String text, ScreenTimeRate screenTimeRateValue){
    return RadioListTile(
      title: Text(text),
      groupValue: _screenTimeRate,
      value: screenTimeRateValue,
      onChanged: (value) {
        setState(() {
          _screenTimeRate = value;
        });
      },
    );
  }

  SizedBox _meditationBox(String text) {
    return SizedBox(
      width: 350,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  updateActivityInBackend(String sleepRate, String calorieRate, String screenTimeRate) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference sleepReference = FirebaseDatabase.instance
        .ref('userData/$currentUserId/sleepRates')
        .push();
    DatabaseReference calorieReference = FirebaseDatabase.instance
        .ref('userData/$currentUserId/calorieRates')
        .push();
    DatabaseReference screenTimeReference = FirebaseDatabase.instance.ref('userData/$currentUserId/screenTimeRates')
        .push();
    await sleepReference.set(sleepRate);
    await calorieReference.set(calorieRate);
    await screenTimeReference.set(screenTimeRate);
  }
}
