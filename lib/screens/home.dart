import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int margin = 5;
  final _feelings = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 120, 0, 20),
              child: const Text(
                "How's Your Mood Today?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // const Text(
            //   "Rate your mood",
            //   style: TextStyle(
            //     fontWeight: FontWeight.w500,
            //     fontSize: 18,
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: slider(),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: const Text(
                "Why do you think you are feeling like this",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your feelings!",
                ),
                controller: _feelings,
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  elevation: 15,
                  shape: const StadiumBorder(),
                  //Colors.tealAccent,
                  padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                ),
                onPressed: () {
                  updateMoodAndFeelingsToBackend(margin, _feelings.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          content: Stack(
                            alignment: Alignment.center,
                            children: [
                              Lottie.asset(
                                'assets/done1.json'
                                  //'https://assets10.lottiefiles.com/packages/lf20_obhph3sh.json'
                              ),
                              Lottie.asset(
                                'assets/done2.json'
                                  //'https://assets10.lottiefiles.com/packages/lf20_wkebwzpz.json'
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Text('Submit!!'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column slider() {
    List emoji = ['😞','😞','😞','😔','😔','🙂','🙂','🙂','😀','😀','😀'];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,20),
          child: Text(
            '${emoji[margin]}',
            style: const TextStyle(fontSize: 30),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              flex: 1,
              child: Text('😞',style: TextStyle(fontSize: 25),),
            ),
            Flexible(
              flex: 8,
              child: Slider(
                  value: margin.toDouble(),
                  min: 0,
                  max: 10,
                  divisions: 10,
                  //activeColor: const Color(0xFF03DAC5),
                  //Color(0x64FFDAFF)
                  inactiveColor: Colors.grey,
                  label: '$margin',
                  onChanged: (double newValue) {
                    setState(() {
                      margin = newValue.toInt();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}';
                  }),
            ),
            const Flexible(
              flex: 1,
              child: Text('😃',style: TextStyle(fontSize: 25),),
            ),
          ],
        ),
      ],
    );
  }

  updateMoodAndFeelingsToBackend(int mood, String feeling) async {
    setState(() {
      _feelings.text = "";
      margin = 5;
    });
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference moodReference = FirebaseDatabase.instance
        .ref('userData/$currentUserId/moodRates')
        .push();
    DatabaseReference feelingReference = FirebaseDatabase.instance
        .ref('userData/$currentUserId/feelings')
        .push();

    final key=encrypt.Key.fromLength(32);
    final iv=encrypt.IV.fromLength(16);
    final encrypter=encrypt.Encrypter(encrypt.AES(key));

    final encrypted=encrypter.encrypt(feeling,iv: iv);

    await moodReference.set(mood);
    await feelingReference.set(encrypted.base64);
  }
}
