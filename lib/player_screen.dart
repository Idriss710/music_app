import 'package:flutter/material.dart';
import 'package:mu_app/model/music_player_model.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicPlayer = Provider.of<MusicPlayerModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        
           actions: [
            IconButton(
              onPressed: (){},
              icon: const Icon(Icons.more_horiz))
           ],
      ),
      // AppBar(title: Text('Now Playing')),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.topCenter,
            colors: [Color(0x0ff14771),Color(0xFF071A2c)]
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Padding(
                 padding: const EdgeInsets.only(top: 10,bottom: 60),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (){},
                     icon: Icon(Icons.download_rounded,color: Colors.white,size: 40,)
                     )
                  ],
                               ),
               ),
              musicPlayer.currentSongImageUrl != null
                  ? DecoratedBox(
                     decoration: BoxDecoration(
                     boxShadow: const [
                      BoxShadow(
                      color: Colors.black12 ,
                      offset: Offset(2, 4),
                      blurRadius: 4,
                    ),
                    ] ,
                    borderRadius: BorderRadius.circular(10)
            
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          musicPlayer.currentSongImageUrl!,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                    ),
                  )
                  : Container(),
              SizedBox(height: 20),
              Text(musicPlayer.currentSongTitle ?? 'No song playing',style: const TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
              Slider(
                value: musicPlayer.position.inSeconds.toDouble(),
                max: musicPlayer.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  musicPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  //  IconButton(
                  //   icon: Icon(Icons.stop_rounded, color: Colors.white,size: 40),
                  //   onPressed: musicPlayer.stop,
                  // ),
                  IconButton(
                    icon: Icon(Icons.skip_previous_rounded, color: Colors.white,size: 60,),
                    onPressed: musicPlayer.playPrevious,
                  ),
                  IconButton(
                    icon: Icon(musicPlayer.isPlaying ? Icons.pause : Icons.play_arrow_rounded, color: Colors.white,size: 80,),
                    onPressed: musicPlayer.togglePlayPause,
                  ),
                 
                  IconButton(
                    icon: Icon(Icons.skip_next_rounded, color: Colors.white,size: 60),
                    onPressed: musicPlayer.playNext,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
