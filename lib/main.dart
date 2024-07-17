import 'package:flutter/material.dart';
import 'package:mu_app/model/music_player_model.dart';
import 'package:mu_app/player_screen.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MusicPlayerModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Music App',
        initialRoute: '/',
        routes: {
          '/': (context) => MusicPlayerScreen(),
          '/player': (context) => PlayerScreen(),
        },
      ),
    );
  }
}

class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicPlayer = Provider.of<MusicPlayerModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      
      appBar: AppBar(
        title: const Text('New Musics',style: TextStyle(color: Colors.white),),
         iconTheme: const IconThemeData(
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.topCenter,
            colors: [Color(0x0ff14771),Color(0xFF071A2c)]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: musicPlayer.songs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          musicPlayer.songs[index]['imageUrl']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(musicPlayer.songs[index]['title']!,style: TextStyle(color: Colors.white),),
                      onTap: () {
                        musicPlayer.play(index);
                        Navigator.pushNamed(context, '/player');
                      },
                      
                    ),
                  );
                },
              ),
            ),
            if (musicPlayer.currentSongTitle != null) ...[
              InkWell(
                onTap:(){
                
                      Navigator.pushNamed(context, '/player');
                }  
                     ,
                child: Container(
                  color: Color.fromARGB(131, 4, 35, 4),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              musicPlayer.currentSongTitle!,
                              style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Now Playing',
                              style: TextStyle(color: Color.fromARGB(255, 189, 188, 188)),
                            ),
                          ],
                        ),
                      ),
                       IconButton( 
                        icon: Icon(Icons.skip_previous),
                        color: Colors.white,
                        onPressed: musicPlayer.playPrevious,
                      ),
                      musicPlayer.isPlaying ? 
                      IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: musicPlayer.pause,
                        color: Colors.white,
                      ) : 
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: musicPlayer.togglePlayPause,
                        color: Colors.white,
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.stop),
                      //   onPressed: musicPlayer.stop,
                      //   color: Colors.white,
                      // ),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        onPressed: musicPlayer.playNext,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
