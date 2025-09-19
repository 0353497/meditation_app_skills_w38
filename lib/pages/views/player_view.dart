import 'package:flutter/material.dart';
import 'package:meditation_app/pages/sleep/sleep_play_music_page.dart';
import 'package:meditation_app/providers/audio_filter_provider.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';
import 'package:meditation_app/components/sleep_icon_buttons_row.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/meditate/play_meditate_bg.png"), fit: BoxFit.contain)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Music",
                      style: TextStyle(
                        color: Color(0xff3F414E),
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                      ),
                    ),
                    Text("A wide Gallery of calming music.",
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff3F414E),
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              SleepIconButtonsRow(highlightLabelColor: Color(0xff3F414E), backgroundColor: Color.fromARGB(255, 243, 225, 192),),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage("assets/images/sleep/image.png",), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Color.fromARGB(255, 247, 178, 50), BlendMode.lighten))
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("The Good Rest",
                        style: TextStyle(
                          color: Color(0xffF9F0E3),
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
          
                      Text("Non-stop 8-hour mixes of our \n most popular sleep audio",
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffF9F0E3),
                          fontSize: 16
                        ),
                      ),
          
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color(0xffEBEAEC)),
                          foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E))
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SleepPlayMusicPage(title: "The Ocean Moon", label: "Non-stop 8-hour mixes of our \n most popular sleep audio",)));
                        },
                        child: Text("START"),
                      )
                    ],
                  ),
                ),
              ),
              Consumer<AudioFilterProvider>(
                builder: (context, filterProvider, child) {
                  final meditateAudios = filterProvider.getFilteredAudios();
                  
                  return SizedBox(
                    height: 1000,
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: meditateAudios.map((audio) => RecommendCard(
                        audio: audio,
                        showFavorite: true,
                        titleColor: Color(0xff3F414E),
                        subtitleColor: Color(0xff3F414E),
                        color: audio.id == 'meditate_002' 
                            ? Color(0xffF9F0E3) 
                            : Color(0xff3F414E),
                      )).toList(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}