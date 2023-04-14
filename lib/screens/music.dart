import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final player = AudioPlayer();
  List songs = [
    'yoga',
    'yogaZen',
    'underflow',
    'temple',
    'spaceflight',
    'sea',
    'nature',
    'mystical',
    'mantra',
    'lost',
    'healing',
    'garden',
    'forests',
    'discover'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: const Text(
            'Music',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(
          'Relax yourself listening to this album',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        const Text(
          'Just connect your headphones and take a nap',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        songs[index],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        player.play(AssetSource(songs[index] + '.mp3'));
                      },
                      icon: const Icon(Icons.play_arrow_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        player.pause();
                      },
                      icon: const Icon(Icons.pause_outlined),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 75, 0, 0),),
      ],
    );
  }
}
