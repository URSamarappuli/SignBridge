import 'package:flutter/material.dart';
import 'package:fyp_project/constants/style.dart';
import 'package:video_player/video_player.dart';

class TextToSignTranslate extends StatefulWidget {
  @override
  _TextToSignTranslateState createState() => _TextToSignTranslateState();
}

class _TextToSignTranslateState extends State<TextToSignTranslate> {
  final TextEditingController _textEditingController = TextEditingController();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  // To track the current video position
  ValueNotifier<Duration> _currentPosition = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/video/hand_video.mp4',
    )..initialize().then((_) {
        // Listen to the video player's position
        _controller.addListener(() {
          _currentPosition.value = _controller.value.position;
        });
        setState(() {});
      });
  }

  // Dispose the controller when the widget is disposed
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _currentPosition.dispose();
  }

  // Build button function for the 'Text' button
  Widget buildButton({required String text}) {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Text to Sign Translate',
          style: appbartitlestyle,
        ),
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
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue.shade900,
                        width: 1.8,
                      ),
                    ),
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ),
                SizedBox(height: 30),

                // Video Progress Bar (Slider)
                ValueListenableBuilder<Duration>(
                  valueListenable: _currentPosition,
                  builder: (context, position, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${formatDuration(position)}',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                '${formatDuration(_controller.value.duration)}',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        Slider(
                          value: position.inSeconds.toDouble(),
                          min: 0.0,
                          max: _controller.value.duration.inSeconds.toDouble(),
                          activeColor: Colors.blue.shade900,
                          inactiveColor: Colors.blue.shade100,
                          onChanged: (double value) {
                            final newPosition =
                                Duration(seconds: value.toInt());
                            _controller.seekTo(newPosition);
                          },
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 20),

                // Bottom control buttons (play/pause/skip)
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
                            final position = _controller.value.position;
                            final newPosition =
                                position - Duration(seconds: 10);
                            _controller.seekTo(newPosition);
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_previous),
                          iconSize: 38,
                          onPressed: () {
                            _controller.seekTo(Duration.zero);
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                            setState(() {});
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.pause),
                          iconSize: 38,
                          onPressed: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            }
                            setState(() {});
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next),
                          iconSize: 38,
                          onPressed: () {
                            _controller.seekTo(_controller.value.duration);
                          },
                          color: const Color(0xFF005EB8),
                        ),
                        IconButton(
                          icon: Icon(Icons.forward_10),
                          iconSize: 38,
                          onPressed: () {
                            final position = _controller.value.position;
                            final newPosition =
                                position + Duration(seconds: 10);
                            _controller.seekTo(newPosition);
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

  // Helper function to format the duration
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
