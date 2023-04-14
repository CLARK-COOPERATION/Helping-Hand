import 'package:flutter/material.dart';

class BaymaxMessage extends StatefulWidget {
  final List messages;
  const BaymaxMessage({Key? key,required this.messages}) : super(key: key);

  @override
  State<BaymaxMessage> createState() => _BaymaxMessageState();
}

class _BaymaxMessageState extends State<BaymaxMessage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index){
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft:const Radius.circular(20,),
                          topRight:const Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSecondary),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 2 / 3),
                    child: Text(widget.messages[index]['message'].text.text[0])),
              ],
            ),
          );
        },
        separatorBuilder: (_ , i)=> const Padding(padding: EdgeInsets.only(top:10)), itemCount: widget.messages.length);
  }
}
