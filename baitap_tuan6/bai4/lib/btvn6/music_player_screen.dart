import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  int _currentIndex = 0;

  final List<Map<String, String>> _songs = [
    {'title': 'Lạc Trôi', 'artist': 'Sơn Tùng M-TP', 'file': 'sample1.mp3'},
    {'title': 'Chìm Sâu', 'artist': 'RPT MCK', 'file': 'sample2.mp3'},
    {'title': 'Ngủ Một Mình', 'artist': 'HIEUTHUHAI', 'file': 'sample3.mp3'},
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() => _isPlaying = state == PlayerState.playing);
      }
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) setState(() => _duration = newDuration);
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) setState(() => _position = newPosition);
    });


    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSong(int index) async {
    setState(() => _currentIndex = index);
    await _audioPlayer.play(AssetSource('audios/${_songs[index]['file']}'));
  }

  void _pauseSong() async {
    await _audioPlayer.pause();
  }

  void _nextSong() {
    int nextIndex = (_currentIndex + 1) % _songs.length;
    _playSong(nextIndex);
  }

  void _prevSong() {
    int prevIndex = _currentIndex > 0 ? _currentIndex - 1 : _songs.length - 1;
    _playSong(prevIndex);
  }

  // Hàm fomat thời gian cho đẹp (phút:giây)
  String _formatDuration(Duration d) {
    String minutes = d.inMinutes.toString().padLeft(2, '0');
    String seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A148C), Color(0xFF121212)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'NOW PLAYING',
                style: TextStyle(color: Colors.white70, letterSpacing: 2),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.music_note, size: 80, color: Colors.pink),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _songs[_currentIndex]['title']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _songs[_currentIndex]['artist']!,
                style: const TextStyle(color: Colors.white54, fontSize: 16),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(_formatDuration(_position), style: const TextStyle(color: Colors.white)),
                    Expanded(
                      child: Slider(
                        activeColor: Colors.pinkAccent,
                        inactiveColor: Colors.white24,
                        min: 0,
                        max: _duration.inSeconds.toDouble(),
                        value: _position.inSeconds.toDouble().clamp(0, _duration.inSeconds.toDouble()),
                        onChanged: (value) {
                          final position = Duration(seconds: value.toInt());
                          _audioPlayer.seek(position);
                        },
                      ),
                    ),
                    Text(_formatDuration(_duration), style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
                    onPressed: _prevSong,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pinkAccent,
                    ),
                    child: IconButton(
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 40),
                      onPressed: () {
                        if (_isPlaying) {
                          _pauseSong();
                        } else {
                          _playSong(_currentIndex);
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
                    onPressed: _nextSong,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white24),

              Expanded(
                child: ListView.builder(
                  itemCount: _songs.length,
                  itemBuilder: (context, index) {
                    bool isPlayingThis = (_currentIndex == index);
                    return ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                      title: Text(
                        _songs[index]['title']!,
                        style: TextStyle(
                          color: isPlayingThis ? Colors.pinkAccent : Colors.white,
                          fontWeight: isPlayingThis ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        _songs[index]['artist']!,
                        style: const TextStyle(color: Colors.white54),
                      ),
                      trailing: const Icon(Icons.more_vert, color: Colors.white54),
                      onTap: () => _playSong(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}