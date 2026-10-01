import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaiTap6Screen(),
    );
  }
}

class BaiTap6Screen extends StatefulWidget {
  const BaiTap6Screen({super.key});

  @override
  State<BaiTap6Screen> createState() => _BaiTap6ScreenState();
}

class _BaiTap6ScreenState extends State<BaiTap6Screen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  bool _isShowList = false;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  int _currentIndex = 0;

  final List<Map<String, String>> _songs = [
    {'title': 'Bài Hát Số 1', 'artist': 'Ca Sĩ A', 'path': 'sample1.mp3'},
    {'title': 'Bài Hát Số 2', 'artist': 'Ca Sĩ B', 'path': 'sample2.mp3'},
    {'title': 'Bài Hát Số 3', 'artist': 'Ca Sĩ C', 'path': 'sample3.mp3'},
  ];

  @override
  void initState() {
    super.initState();

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          _duration = newDuration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          _position = newPosition;
        });
      }
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

  Future<void> _playSong() async {
    await _audioPlayer.play(
      AssetSource('audios/${_songs[_currentIndex]['path']}'),
    );
  }

  Future<void> _pauseSong() async {
    await _audioPlayer.pause();
  }

  void _nextSong() {
    setState(() {
      if (_currentIndex < _songs.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
    _playSong();
  }

  void _prevSong() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = _songs.length - 1;
      }
    });
    _playSong();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = _songs[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng Dụng Nghe Nhạc'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isShowList ? Icons.play_circle : Icons.list),
            onPressed: () {
              setState(() {
                _isShowList = !_isShowList;
              });
            },
          ),
        ],
      ),
      body: _isShowList
          ? ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                final song = _songs[index];
                final isSelected = index == _currentIndex;
                return ListTile(
                  leading: Icon(
                    isSelected ? Icons.music_note : Icons.audiotrack,
                    color: isSelected ? Colors.deepPurple : Colors.grey,
                  ),
                  title: Text(
                    song['title']!,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? Colors.deepPurple : Colors.black,
                    ),
                  ),
                  subtitle: Text(song['artist']!),
                  trailing: isSelected && _isPlaying
                      ? const Icon(Icons.equalizer, color: Colors.deepPurple)
                      : null,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _isShowList = false;
                    });
                    _playSong();
                  },
                );
              },
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ảnh đĩa nhạc hoặc Icon đại diện
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.music_note,
                      size: 100,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Tên bài hát & Ca sĩ
                  Text(
                    currentSong['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentSong['artist']!,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  // Thanh trượt thời gian (Slider)
                  Slider(
                    min: 0,
                    max: _duration.inSeconds.toDouble() > 0
                        ? _duration.inSeconds.toDouble()
                        : 1.0,
                    value: _position.inSeconds.toDouble().clamp(
                      0.0,
                      _duration.inSeconds.toDouble() > 0
                          ? _duration.inSeconds.toDouble()
                          : 1.0,
                    ),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(position);
                    },
                  ),
                  // Hiển thị thời gian chạy
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(_position)),
                        Text(_formatDuration(_duration)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Các nút điều khiển nhạc
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 48,
                        color: Colors.deepPurple,
                        icon: const Icon(Icons.skip_previous),
                        onPressed: _prevSong,
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        iconSize: 64,
                        color: Colors.deepPurple,
                        icon: Icon(
                          _isPlaying ? Icons.pause_circle : Icons.play_circle,
                        ),
                        onPressed: () {
                          if (_isPlaying) {
                            _pauseSong();
                          } else {
                            _playSong();
                          }
                        },
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        iconSize: 48,
                        color: Colors.deepPurple,
                        icon: const Icon(Icons.skip_next),
                        onPressed: _nextSong,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
