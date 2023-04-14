import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

import 'baymaxMessage.dart';

class Baymax extends StatefulWidget {
  const Baymax({Key? key}) : super(key: key);

  @override
  State<Baymax> createState() => _BaymaxState();
}

class _BaymaxState extends State<Baymax> {

  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller=TextEditingController();
  List<Map<String, dynamic>> messages=[];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter=instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outline,
      appBar: AppBar(
        title: const Text("Baymax"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: BaymaxMessage(messages: messages)),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8
              ),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Start your talk'
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  sendMessage(String text)async{
    if(text.isEmpty){
      print('Message is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message is empty')),
      );
    }
    else{
      setState(() {
        addMessage(Message(
            text: DialogText(text: [text])
        ),true);
      });
      DetectIntentResponse response= await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if(response.message == null)return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }
  addMessage(Message message,[bool isUserMessage=false]){
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage
    });
  }
}
