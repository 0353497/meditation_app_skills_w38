import 'package:flutter/material.dart';
import 'package:meditation_app/pages/sleep/sleep_play_music_page.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';
import 'package:meditation_app/pages/views/sleep_music_view.dart';
import 'package:meditation_app/providers/audio_filter_provider.dart';
import 'package:meditation_app/components/sleep_icon_buttons_row.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
import 'package:provider/provider.dart';

class NormalSleepView extends StatelessWidget {
  const NormalSleepView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/sleep/welcome_sleep_background.png"), fit: BoxFit.contain, repeat: ImageRepeat.repeatY)
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
                    Text("Sleep Stories",
                      style: TextStyle(
                        color: Color(0xffE6E7F2),
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                      ),
                    ),
                    Text("Soothing bedtime stories to help you fall into a deep and natural sleep",
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffE6E7F2),
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              SleepIconButtonsRow(),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage("assets/images/sleep/image.png",), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.grey.shade300, BlendMode.multiply))
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("The Ocean Moon",
                        style: TextStyle(
                          color: Color(0xffFFE7BF),
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
          
                      Text("Non-stop 8-hour mixes of our \n most popular sleep audio",
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffFFE7BF),
                          fontSize: 16
                        ),
                      ),
          
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color(0xffEBEAEC)),
                          foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E))
                        ),
                        onPressed: (){
                          context.read<TabBarProvider>().changeCurrentSleepView(2);
                        },
                        child: Text("START"),
                      )
                    ],
                  ),
                ),
              ),
              Consumer<AudioFilterProvider>(
                builder: (context, filterProvider, child) {
                  final filteredAudios = filterProvider.getFilteredAudios()
                      .where((audio) => audio.id.startsWith('sleep_'))
                      .toList();
                      
                  return SizedBox(
                    height: 600,
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: filteredAudios.map((audio) => RecommendCard(
                        audio: audio,
                        showFavorite: true,
                        titleColor: Color(0xffE6E7F2),
                        subtitleColor: Color(0xffE6E7F2),
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