import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Journal extends StatefulWidget {
  const Journal({Key? key}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final _formKey = GlobalKey<FormState>();

  final _journal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 125, 0, 50),
            child: Text(
              "Journal",
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 50),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  maxLines: 20,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "How was your day",
                  ),
                  controller: _journal,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Don't leave me empty and submit";
                    }
                    return null;
                  },
                ),
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary,
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              elevation: 15,
              shape: const StadiumBorder(),
              //Colors.tealAccent,
              padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gimme a min i will save it')),
                );
                updateJournalInBackend(_journal.text);
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: const Text('Submit!!'),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        ],
      ),
    );
  }

  updateJournalInBackend(String journal) async {
    setState(() {
      _journal.text = "";
    });
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference journalReference = FirebaseDatabase.instance
        .ref('userData/$currentUserId/journal')
        .push();
    await journalReference.set(journal);
  }
}