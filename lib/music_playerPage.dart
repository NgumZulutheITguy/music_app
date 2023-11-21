import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
List<String> songList = ["song1.mp3", "song2.mp3", "song3.mp3","music.mp3"];
int currentSongIndex = 0;


  bool isPlaying = false;
  double value = 0;
  final player = AudioPlayer();
  Duration? duration;

  void initPlayer() async {
    await player.setSource(AssetSource("song1.mp3"));
    duration = await player.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
     appBar: AppBar(
        title: Text('Music Player'),
       
          
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            height: 300.0,
            width: 300.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/cover.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //setting the music cover
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "assets/image.png",
                  width: 250.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              
              //Setting the seekbar
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(value / 60).floor()}: ${(value % 60).floor()}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Container(
                    width: 260.0,
                    child: Slider.adaptive(
                      onChangeEnd: (newValue) async {
                        setState(() {
                          value = newValue;
                          if (kDebugMode) {
                            print(newValue);
                          }
                        });
                        await player.seek(Duration(seconds: newValue.toInt()));
                      },
                      min: 0.0,
                      value: value,
                      max: 214.0,
                      onChanged: (value) {},
                      activeColor: Colors.white,
                    ),
                  ),
                ],
              ),
              //setting the player controller
              const SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

   Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(60.0),
    color: Colors.black87,
    border: Border.all(color: Colors.white38),
  ),
  width: 60.0,
  height: 60.0,
  child: InkWell(
    onTap: () async {
      // Increment the current song index to play the next song
      currentSongIndex++;
      if (currentSongIndex >= songList.length) {
        // Reset to the first song if we've reached the end of the list
        currentSongIndex = 0;
      }

      // Set the source of the player to the next song
      await player.setSource(AssetSource(songList[currentSongIndex]));

      
      await player.resume();
      
      // skip to next song
    },
    child: const Center(
      child: Icon(
        Icons.skip_previous,
        color: Colors.white,
      ),
    ),
  ),
),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0.0).copyWith(left: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTapDown: (details) {
                        player.setPlaybackRate(0.5);
                      },
                      onTapUp: (details) {
                        player.setPlaybackRate(1);
                      },
                      child: const Center(
                        child: Icon(
                          Icons.fast_rewind_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                 Container(
  margin: const EdgeInsets.symmetric(horizontal: 5.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(60.0),
    color: Colors.black87,
    border: Border.all(color: Colors.pink),
  ),
  width: 60.0,
  height: 60.0,
  child: InkWell(
    onTap: () async {
      if (isPlaying) {
        // Pause the audio
        await player.pause();
      } else {
        // Play the audio
        await player.resume();
        player.onPositionChanged.listen(
          (Duration d) {
            setState(() {
              value = d.inSeconds.toDouble();
            });
          },
        );
      }

      // Toggle the playback state
      setState(() {
        isPlaying = !isPlaying;
      });
    },
    child: Center(
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow, // Toggle between play and pause icon
        color: Colors.white,
      ),
    ),
  ),
),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0.0).copyWith(right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTapDown: (details) {
                        player.setPlaybackRate(2);
                      },
                      onTapUp: (details) {
                        player.setPlaybackRate(1);
                      },
                      child: const Center(
                        child: Icon(
                          Icons.fast_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

              Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(60.0),
    color: Colors.black87,
    border: Border.all(color: Colors.white38),
  ),
  width: 60.0,
  height: 60.0,
  child: InkWell(
    onTap: () async {
      // Decrement the current song index to play the previous song
      currentSongIndex--;
      if (currentSongIndex < 0) {
        // Wrap around to the last song if we're at the beginning of the list
        currentSongIndex = songList.length - 1;
      }

      // Set the source of the player to the previous song
      await player.setSource(AssetSource(songList[currentSongIndex]));

      
      await player.resume();
      
  
    },
    child: const Center(
      child: Icon(
        Icons.skip_next,
        color: Colors.white,
      ),
    ),
  ),
),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
