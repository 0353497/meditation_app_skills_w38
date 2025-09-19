import 'package:flutter/material.dart';
import 'package:meditation_app/providers/audio_service.dart';
import 'package:provider/provider.dart';

class SleepPlayMusicPage extends StatefulWidget {
  const SleepPlayMusicPage({super.key, required this.title, required this.label});
  final String title;
  final String label;

  @override
  State<SleepPlayMusicPage> createState() => _SleepPlayMusicPageState();
}

class _SleepPlayMusicPageState extends State<SleepPlayMusicPage> {
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
        floatingActionButton: IconButton(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E)),
            backgroundColor: WidgetStatePropertyAll(Color(0xffE6E7F2))
          ),
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        backgroundColor: Color(0xff03174C),
        body: Stack(
          children: [
            Image.asset("assets/images/sleep/play_background.png"),

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
                            color: Color(0xffE6E7F2),
                            fontWeight: FontWeight.bold,
                            fontSize: 32
                          ),
                        ),
                        Text(widget.label,
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
                                      child: Image.asset("assets/images/icons/backword_15.png", width: 44,)
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(68, 210, 215, 246),
                                        shape: BoxShape.circle
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          audioState.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded, 
                                          color: Colors.white, 
                                          size: 100
                                        ),
                                        onPressed: _togglePlayPause,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _seekForward,
                                      child: Image.asset("assets/images/icons/forward_15.png", width: 44,)
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
                                        activeColor: Color(0xffE6E7F2),
                                        inactiveColor: Color(0xff47557E),
                                        thumbColor: Color(0xff8E97FD),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(_formatDuration(_sliderValue != null 
                                              ? Duration(milliseconds: (_sliderValue! * audioState.duration.inMilliseconds).round())
                                              : audioState.position), 
                                            style: TextStyle(
                                              color: Color(0xff98A1BD),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20
                                            ),
                                          ),
                                          Text(_formatDuration(audioState.duration), 
                                            style: TextStyle(
                                              color: Color(0xff98A1BD),
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

class TopRightStackButtons extends StatefulWidget {
  const TopRightStackButtons({
    super.key,
  });

  @override
  State<TopRightStackButtons> createState() => _TopRightStackButtonsState();
}

class _TopRightStackButtonsState extends State<TopRightStackButtons> {
  bool isFavorite = false;
  bool isDownloaded = false;
  bool isDownloading = false;

  _startDownload() async{
    setState(() {
      isDownloading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isDownloaded = true;
      isDownloading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        IconButton(
          iconSize: 30,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black45),
            foregroundColor: WidgetStatePropertyAll(Color(0xffE6E7F2))
          ),
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
        },
        icon: Icon(isFavorite? Icons.favorite : Icons.favorite_outline),
        ),
         IconButton(
          iconSize: 30,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black45),
            foregroundColor: WidgetStatePropertyAll(Color(0xffE6E7F2))
          ),
          onPressed: () {
            if (isDownloaded) {
              setState(() {
                isDownloaded = false;
              });
            } else {
              _startDownload();
            }
        },
        icon:
        isDownloading ? SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(color: Color(0xffE6E7F2),)
          ) :
        Icon(isDownloaded ? Icons.file_download_done_rounded : Icons.file_download),
        ),
      ],
    );
  }
}