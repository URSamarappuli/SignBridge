import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:video_player/video_player.dart';

class TextToSignTranslate extends StatefulWidget {
  @override
  _TextToSignTranslateState createState() => _TextToSignTranslateState();
}

class _TextToSignTranslateState extends State<TextToSignTranslate> {
  final TextEditingController _textEditingController = TextEditingController();
  VideoPlayerController? _controller;
  ValueNotifier<Duration> _currentPosition = ValueNotifier(Duration.zero);

  List<String> _videoQueue = [];
  int _currentIndex = 0;

  final Map<String, String> signMap = {
    'hello': 'assets/video/hello.mp4',
    'thank': 'assets/video/thank_you.mp4',
    'you': 'assets/video/thank_you.mp4',
    'good': 'assets/video/good_morning.mp4',
    'morning': 'assets/video/good_morning.mp4',
  };

  @override
  void initState() {
    super.initState();
  }

  void _startTranslation() {
    final input = _textEditingController.text.trim().toLowerCase();
    final words = input.split(RegExp(r'\s+'));

    _videoQueue = words
        .where((word) => signMap.containsKey(word))
        .map((word) => signMap[word]!)
        .toList();

    if (_videoQueue.isNotEmpty) {
      _currentIndex = 0;
      _playCurrentVideo();
    } else {
      _disposeController(); // remove previous video from frame
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No matching sign videos found.')),
      );
      setState(() {}); // refresh UI
    }
  }

  void _playCurrentVideo() {
    _disposeController();

    final videoPath = _videoQueue[_currentIndex];
    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller?.play();
        _controller?.addListener(_onVideoEnded);
        _controller?.addListener(() {
          _currentPosition.value = _controller!.value.position;
        });
      });
  }

  void _onVideoEnded() {
    if (_controller != null &&
        _controller!.value.position >= _controller!.value.duration &&
        !_controller!.value.isPlaying) {
      _controller?.removeListener(_onVideoEnded);
      _currentIndex++;
      if (_currentIndex < _videoQueue.length) {
        _playCurrentVideo();
      }
    }
  }

  void _disposeController() {
    _controller?.removeListener(_onVideoEnded);
    _controller?.dispose();
    _controller = null;
    _currentPosition.value = Duration.zero;
  }

  @override
  void dispose() {
    _disposeController();
    _currentPosition.dispose();
    super.dispose();
  }

  Widget buildButton({required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade900, width: 1.5),
          ),
          child: TextField(
            controller: _textEditingController,
            maxLines: null,
            expands: true,
            style: TextStyle(color: Colors.blue.shade900),
            decoration: InputDecoration(
              hintText: 'Text',
              hintStyle: TextStyle(color: Colors.blue.shade300),
              filled: true,
              fillColor: Colors.blue[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Center(
          child: ElevatedButton.icon(
            onPressed: _startTranslation,
            icon: Icon(Icons.translate),
            label: Text("Translate to Sign"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Text to Sign Translate', style: appbartitlestyle),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildButton(text: 'Text'),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 320,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue.shade900,
                        width: 1.8,
                      ),
                    ),
                    child: _controller != null &&
                            _controller!.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          )
                        : Center(child: Text("Enter text and press Translate")),
                  ),
                ),
                SizedBox(height: 30),
                ValueListenableBuilder<Duration>(
                  valueListenable: _currentPosition,
                  builder: (context, position, child) {
                    final duration =
                        _controller?.value.duration ?? Duration.zero;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${formatDuration(position)}',
                                  style: TextStyle(color: Colors.blue)),
                              Text('${formatDuration(duration)}',
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                        Slider(
                          value: position.inSeconds
                              .toDouble()
                              .clamp(0, duration.inSeconds.toDouble()),
                          min: 0.0,
                          max: duration.inSeconds.toDouble(),
                          activeColor: Colors.blue.shade900,
                          inactiveColor: Colors.blue.shade100,
                          onChanged: (double value) {
                            _controller
                                ?.seekTo(Duration(seconds: value.toInt()));
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 360,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBAD7FF),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: const Color(0xFF53A5E8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller != null) {
                              final position = _controller!.value.position;
                              _controller!
                                  .seekTo(position - Duration(seconds: 10));
                            }
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_previous),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller != null) {
                              _controller!.seekTo(Duration.zero);
                            }
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller != null &&
                                !_controller!.value.isPlaying) {
                              _controller!.play();
                            }
                            setState(() {});
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.pause),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller != null &&
                                _controller!.value.isPlaying) {
                              _controller!.pause();
                            }
                            setState(() {});
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller != null) {
                              _controller!.seekTo(_controller!.value.duration);
                            }
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.forward_10),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller != null) {
                              final position = _controller!.value.position;
                              _controller!
                                  .seekTo(position + Duration(seconds: 10));
                            }
                          },
                          color: const Color(0xFF005EB8),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
