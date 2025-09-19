import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meditation_app/components/sleep_icon_buttons_row.dart';
import 'package:meditation_app/models/mediations.dart';
import 'package:meditation_app/pages/meditate/meditate_highlight_page.dart';
import 'package:meditation_app/providers/audio_filter_provider.dart';
import 'package:provider/provider.dart';

class MeditateView extends StatelessWidget {
  const MeditateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/meditate/play_meditate_bg.png"), fit: BoxFit.contain)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text("Meditate",
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xff3F414E),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("we can learn how to recognize when our minds are doing their normal everyday acrobatics.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                      ),
                    ),
                    
                  ],
                ),
                SleepIconButtonsRow(backgroundColor: Colors.grey, highlightLabelColor: Color(0xff3F414E),),
                const DailyCalm(),
                Consumer<AudioFilterProvider>(
                  builder: (context, filterProvider, child) {
                    int index = 0;
                    final filteredAudios = filterProvider.getFilteredMeditateAudios();
                    return SizedBox(
                      height: 600,
                      child: Wrap(
                        direction: Axis.vertical,
                        spacing: 20,
                        runSpacing: 20,
                        children: filteredAudios.map((audio) {
                          final mediation = Mediations(
                            mainColor: audio.mainColor,
                            image: audio.img ?? "assets/images/meditate/7_days_calm_bg.png",
                            title: audio.title,
                            height: _getHeight(index) 
                          );
                          index++;
                          return MeditationContainer(
                            mediation: mediation,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateHighlitePage(audio: audio)));
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  double _getHeight(int index) {
    if (index == 1) return 220;
    if (index == 2) return 180;
    if (index == 3) return 240;
    return 240;
  }
}

class MeditationContainer extends StatelessWidget {
  const MeditationContainer({
    super.key,
    required this.mediation, required this.onTap,
  });
  final VoidCallback onTap;
  final Mediations mediation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: (MediaQuery.of(context).size.width - 60) / 2, 
            height: mediation.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: AssetImage(mediation.image), fit: BoxFit.cover)
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Container(
              width: (MediaQuery.of(context).size.width - 60) / 2,
              height: 62,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HSLColor.fromColor(mediation.mainColor).withLightness(.8).toColor(),
                    mediation.mainColor,
                    HSLColor.fromColor(mediation.mainColor).withLightness(0.45).toColor(),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    mediation.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DailyCalm extends StatelessWidget {
  const DailyCalm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 95,
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Color(0xffF1DDCF),
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage("assets/images/meditate/daily_calm_bg.png"),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Daily Calm",
                    style: TextStyle(color: Color(0xff5A6175), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text.rich(
                    TextSpan(text: DateFormat("MMM d").format(DateTime.now()),
                    style: TextStyle(
                      color: Color(0xff5A6175),
                      fontWeight: FontWeight.w500
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: SizedBox(
                          width: 20,
                          child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff5A6175)
                          ),
                                                      ),
                        )
                      ),
                      TextSpan(
                        text: " PAUZE PRACTICE",
                        style: TextStyle(
                        color: Color(0xff5A6175),
                        fontWeight: FontWeight.w500
                        )
                      )
                    ]
                    ),
                  )
                ],
              ),
              IconButton.filled(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xff3F414E)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white)
                ),
                onPressed: (){},
                icon: Icon(Icons.play_arrow)
                )
            ],
          ),
        ),
      );
  }
}