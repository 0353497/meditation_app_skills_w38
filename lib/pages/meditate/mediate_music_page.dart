import 'package:flutter/material.dart';
import 'package:meditation_app/pages/sleep/sleep_play_music_page.dart';
import 'package:meditation_app/providers/audio_service.dart';
import 'package:provider/provider.dart';

class MeditateMusicPage extends StatefulWidget {
  const MeditateMusicPage({super.key, required this.title, this.label, this.isFromView = false});
  final String title;
  final String? label;
  final bool isFromView;

  @override
  State<MeditateMusicPage> createState() => _MeditateMusicPageState();
}

class _MeditateMusicPageState extends State<MeditateMusicPage> {
  double? _sliderValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAudio();
    });
  }

  Future<void> _initAudio() async {
    final audioService = AudioService();
    await audioService.loadTrack("assets/sounds/meditation-music.mp3", trackTitle: widget.title);
  }

  void _togglePlayPause() async {
    final audioService = AudioService();
    await audioService.togglePlayPause();
  }

  void _seekBackward() {
    final audioService = AudioService();
    audioService.seekBackward();
  }

  void _seekForward() {
    final audioService = AudioService();
    audioService.seekForward();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AudioService>.value(
      value: AudioService(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: !widget.isFromView ? IconButton(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E)),
            backgroundColor: WidgetStatePropertyAll(Color(0xffE6E7F2))
          ),
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ) : null,
        backgroundColor: Color(0xffFAF7F2),
        body: Stack(
          children: [
            Image.asset("assets/images/meditate/play_meditate_bg.png"),
            Align(
              alignment: Alignment(.8, -.87),
              child: TopRightStackButtons(),
            ),

            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(),
                    Column(
                      spacing: 20,
                      children: [
                        Text(widget.title,
                          style: TextStyle(
                            color: Color(0xff3F414E),
                            fontWeight: FontWeight.bold,
                            fontSize: 32
                          ),
                        ),
                        Text(widget.label ?? "7 DAYS OF CALM",
                          style: TextStyle(
                            color: Color(0xff98A1BD),
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),
                    Consumer<AudioService>(
                      builder: (context, audioService, child) {
                        return StreamBuilder<AudioState>(
                          stream: audioService.audioStateStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            final audioState = snapshot.data!;
                            
                            final currentSliderValue = _sliderValue ?? 
                                (audioState.duration.inMilliseconds > 0 
                                    ? audioState.position.inMilliseconds / audioState.duration.inMilliseconds
                                    : 0.0);

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 40,
                                  children: [
                                    InkWell(
                                      onTap: _seekBackward,
                                      child: Image.asset("assets/images/icons/backword_15.png", width: 44, color: Colors.grey,)
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Color(0xff3F414E).withAlpha(50),
                                        shape: BoxShape.circle
                                      ),
                                      child: IconButton(
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll(Color(0xff3F414E))
                                        ),
                                        icon: Icon(
                                          audioState.isPlaying ? Icons.pause : Icons.play_arrow, 
                                          color: Colors.white, 
                                          size:  60
                                        ),
                                        onPressed: _togglePlayPause,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _seekForward,
                                      child: Image.asset("assets/images/icons/forward_15.png", width: 44, color: Colors.grey,)
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    children: [
                                      Slider(
                                        value: currentSliderValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _sliderValue = value;
                                          });
                                        },
                                        onChangeEnd: (value) {
                                          final newPosition = Duration(
                                            milliseconds: (value * audioState.duration.inMilliseconds).round()
                                          );
                                          audioService.seek(newPosition);
                                          setState(() {
                                            _sliderValue = null;
                                          });
                                        },
                                        activeColor: Color(0xff3F414E),
                                        inactiveColor: Color.fromARGB(143, 71, 85, 126),
                                        thumbColor: Color(0xff3F414E),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(_formatDuration(_sliderValue != null 
                                              ? Duration(milliseconds: (_sliderValue! * audioState.duration.inMilliseconds).round())
                                              : audioState.position), 
                                            style: TextStyle(
                                              color: Color(0xff3F414E),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20
                                            ),
                                          ),
                                          Text(_formatDuration(audioState.duration), 
                                            style: TextStyle(
                                              color: Color(0xff3F414E),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
