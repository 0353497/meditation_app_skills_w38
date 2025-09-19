import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meditation_app/models/audio.dart';
import 'package:meditation_app/providers/audio_data_provider.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/pages/sleep/sleep_play_music_page.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';

class SleepHighlightPage extends StatefulWidget {
  const SleepHighlightPage({super.key, required this.audio});
  final Audio audio;
  @override
  State<SleepHighlightPage> createState() => _SleepHighlightPageState();
}

class _SleepHighlightPageState extends State<SleepHighlightPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioDataProvider>(
      builder: (context, audioProvider, child) {
        final audio = audioProvider.getAudioById(widget.audio.id) ?? widget.audio;
        
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          backgroundColor: Color(0xff03174C),
          floatingActionButton: IconButton(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E)),
              backgroundColor: WidgetStatePropertyAll(Color(0xffE6E7F2))
            ),
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
          body: Stack(
            children: [
              TopRightStackButtons(),
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(audio.img!, fit: BoxFit.cover, width: MediaQuery.of(context).size.width,),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          Text(audio.title, 
                            style: TextStyle(
                              color: Color(0xffE6E7F2),
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                            ),
                          ),
                          Text.rich(
                            TextSpan(text: "${audio.textBeforeDot}  ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 11
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey
                                ),
                              )
                              ),
                              TextSpan(
                                text: " ${audio.textAfterDot}",
                                style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500
                                )
                              )
                            ]
                            ),
                          ),
                          Text("Ease the mind into a restful night's sleep with these deep, amblent tones.",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Icon(Icons.favorite, color: Colors.white,),
                                    Text("24.234 Favorites",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                      ),
                                    )
                                  ],
                                ),
                                 Row(
                                  spacing: 10,
                                  children: [
                                    Icon(Icons.headphones, color: Colors.white,),
                                    Text("34.234 Listening",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xff98A1BD),
                          ),
                        const Text("Related", 
                            style: TextStyle(
                              color: Color(0xffE6E7F2),
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RecommendCard(title: "Moon Clouds", color: Color(0xff3F414E), image: "assets/images/sleep/good_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                              RecommendCard(title: "Sweet Sleep", color: Color(0xff3F414E), image: "assets/images/sleep/sweet_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                            ],
                          ),
                          OwnTextButton(
                            text: "play",
                            callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SleepPlayMusicPage(title: audio.title, label: audio.textAfterDot!,))) ,
                            backgroundColor: Color(0XFF8E97FD),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 60,
                right: 20,
                child: Row(
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          audio.isFavorite ? Colors.red : Color(0xffE6E7F2)
                        ),
                        backgroundColor: WidgetStatePropertyAll(Color(0xff3F414E).withAlpha(100))
                      ),
                      onPressed: () => audioProvider.toggleFavorite(audio.id),
                      icon: Icon(
                        audio.isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          audio.isDownloaded ? Colors.green : Color(0xffE6E7F2)
                        ),
                        backgroundColor: WidgetStatePropertyAll(Color(0xff3F414E).withAlpha(100))
                      ),
                      onPressed: () => audioProvider.toggleDownload(audio.id),
                      icon: Icon(
                        audio.isDownloaded ? Icons.download_done : Icons.download,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}