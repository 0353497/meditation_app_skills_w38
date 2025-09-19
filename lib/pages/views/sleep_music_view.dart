import 'package:flutter/material.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
import 'package:meditation_app/providers/audio_data_provider.dart';
import 'package:meditation_app/models/audio.dart';
import 'package:provider/provider.dart';

class SleepMusicView extends StatelessWidget {
  const SleepMusicView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Color(0xff03174C),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 60,
                children: [
                  IconButton.outlined(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xffE6E7F2)),
                      foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E))
                    ),
                  onPressed: (){
                    context.read<TabBarProvider>().changeCurrentSleepView(1);
                  },
                  icon: Icon(Icons.arrow_back),
                  ),
                  Text("Sleep Music",
                    style: TextStyle(
                      color: Color(0xffE6E7F2),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    width: 1,
                    height: 1,
                  )
                ],
              ),
              SizedBox(height: 20,),
              Consumer<AudioDataProvider>(
                builder: (context, audioProvider, child) {
                  final sleepAudios = audioProvider.getAudiosByCategory(Category.sleep);
                  
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: sleepAudios.map((audio) => RecommendCard(
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