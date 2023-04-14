import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ViewJournal extends StatefulWidget {
  const ViewJournal({Key? key}) : super(key: key);

  @override
  State<ViewJournal> createState() => _ViewJournalState();
}

class _ViewJournalState extends State<ViewJournal> {
  Future getJournalData() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var journalData = await FirebaseDatabase.instance
        .ref('userData/$currentUserId/journal')
        .get();
    return journalData.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Text(
            "Journal",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
          ),
        ),
        Expanded(
            child: FutureBuilder(
              future: getJournalData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  Map<dynamic, dynamic> sleepValues = snapshot.data;
                  List<dynamic> values = sleepValues.values.toList();
                  final key=encrypt.Key.fromLength(32);
                  final iv=encrypt.IV.fromLength(16);
                  final encrypter=encrypt.Encrypter(encrypt.AES(key));
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ListView.builder(
                        itemCount: values.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 15,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.9,
                                      child: Text(
                                        encrypter.decrypt64(values[index],iv: iv),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  );
                } else {
                  return const Center(
                    child: Text("try again later"),
                  );
                }
              },
            )),
      ],
    );
  }
}
