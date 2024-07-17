import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayerModel extends ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentSongIndex;
  String? _currentSongTitle;
  String? _currentSongImageUrl;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  PlayerState _playerState = PlayerState.stopped;

  MusicPlayerModel() {
    _audioPlayer.onDurationChanged.listen((d) {
      _duration = d;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((p) {
      _position = p;
      notifyListeners();
    });
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _playerState = state;
      notifyListeners();
    });
  }

  List<Map<String, String>> get songs => [
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  1',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://i.ytimg.com/vi/PzhKp-IWGcI/maxresdefault.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  2',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/theme_01.mp3',
          'imageUrl': 'https://i.ytimg.com/vi/f4iQy2WQXz8/maxresdefault.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  3',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://lh3.googleusercontent.com/qadqZPEOKXGQkRhNGSj72LL3MHw2e4Nr02jihOX6Tm4p-Xclr8i4mk4M2gplAVY30C5qxlIWUUneOMQ'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  4',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://i.pinimg.com/736x/45/a1/d4/45a1d413c2c1d5ec368eea61cd629fc8.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  5',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://rubberb.com/blog/wp-content/uploads/2023/10/Eminem-Watch-Collection-Early-Music-Career.jpeg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  6',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://cdn.europosters.eu/image/1300/posters/eminem-black-cap-i205.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  7',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://gsmintro.net/user/images/wallpaper_images/2011/04/13/www.mobilesmspk.net_eminem-recovery_1725.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  8',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://i.pinimg.com/736x/45/a1/d4/45a1d413c2c1d5ec368eea61cd629fc8.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  9',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://cdn.europosters.eu/image/1300/posters/eminem-black-cap-i205.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  4',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://rubberb.com/blog/wp-content/uploads/2023/10/Eminem-Watch-Collection-Early-Music-Career.jpeg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  2',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://i.ytimg.com/vi/PzhKp-IWGcI/maxresdefault.jpg'
        },
        {
          'title': 'Eminem - Cocaine Ft. Jazmine Sullivan Lyrics  1',
          'url': 'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
          'imageUrl': 'https://rubberb.com/blog/wp-content/uploads/2023/10/Eminem-Watch-Collection-Early-Music-Career.jpeg'
        },

      ];

  String? get currentSongTitle => _currentSongTitle;
  String? get currentSongImageUrl => _currentSongImageUrl;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isPlaying => _playerState == PlayerState.playing;
  late Source audioUrl;

  void play(int index) async {
    _currentSongIndex = index;
    _currentSongTitle = songs[index]['title']!;
    _currentSongImageUrl = songs[index]['imageUrl']!;
    audioUrl=UrlSource(songs[index]['url']!);
    await _audioPlayer.play(audioUrl);
    notifyListeners();
  }

  void togglePlayPause() {
    if (_playerState == PlayerState.playing) {
      pause();
    } else {
      playCurrent();
    }
  }

  void playCurrent() {
    if (_currentSongIndex != null) {
      play(_currentSongIndex!);
    }
  }

  void pause() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  void stop() async {
    await _audioPlayer.stop();
    _currentSongIndex = null;
    _currentSongTitle = null;
    _currentSongImageUrl = null;
    _position = Duration.zero;
    _duration = Duration.zero;
    notifyListeners();
  }

  void playNext() {
    if (_currentSongIndex != null && _currentSongIndex! < songs.length - 1) {
      play(_currentSongIndex! + 1);
    }
  }

  void playPrevious() {
    if (_currentSongIndex != null && _currentSongIndex! > 0) {
      play(_currentSongIndex! - 1);
    }
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }
}
