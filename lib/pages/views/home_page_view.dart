import 'package:flutter/material.dart';
import 'package:meditation_app/pages/meditate/mediate_music_page.dart';
import 'package:meditation_app/pages/sleep/sleep_highlight_page.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:meditation_app/providers/audio_data_provider.dart';
import 'package:meditation_app/models/audio.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("assets/images/focus_skills_logo_grey_text.png", width: 200,),
            ),
            Text("Good Morning, ${context.watch<UserProvider>().username}",
            style: TextStyle(
              fontSize: 24,
              color: Color(0xff3F414E),
              fontWeight: FontWeight.bold
            ),
            ),
            Text("We wish you a good day",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomePageCardTop(label: "COURSE", title: "Basics", color: Color(0xff8E97FD), image: "assets/images/home/cherry_love.png", buttonBackgroundColor: Color(0xffEBEAEC), buttonForegroundColor: Color(0xff3F414E), textColor: Color(0xffF7E8D0),),
                HomePageCardTop(label: "MUSIC", title: "Relaxation", color: Color(0xffFFDB9D), image: "assets/images/home/listening_women.png", buttonBackgroundColor: Color(0xff3F414E), buttonForegroundColor: Color(0xffEBEAEC), textColor: Color(0xff3F414E),)
              ],
            ),
            Container(
              height: 95,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Color(0xff333242),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage("assets/images/home/daily_thought_background.png"),
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
                        Text("Daily Thought",
                          style: TextStyle(color: Color(0xffEBEAEC), fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text.rich(
                          TextSpan(text: "MEDITATION ",
                          style: TextStyle(
                            color: Color(0xffEBEAEC),
                            fontWeight: FontWeight.w500
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffEBEAEC)
                              ),
                            )
                            ),
                            TextSpan(
                              text: " 3-10 MIN",
                              style: TextStyle(
                              color: Color(0xffEBEAEC),
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
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E))
                      ),
                      onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Daily Thought")));
                      },
                      icon: Icon(Icons.play_arrow)
                      )
                  ],
                ),
              ),
            ),
            Text("Recommended for you",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xff3F414E),
                fontWeight: FontWeight.bold
              ),
            ),
            Consumer<AudioDataProvider>(
              builder: (context, audioProvider, child) {
                final homeAudios = audioProvider.audioList
                    .where((audio) => audio.id.startsWith('home_'))
                    .take(5)
                    .toList();
                
                return SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 20,
                      children: homeAudios.map((audio) => RecommendCard(
                        audio: audio,
                        showFavorite: true,
                        color: audio.id == 'home_001' 
                            ? Color(0xffAFDBC5) 
                            : Color(0xffFEE3B4),
                      )).toList(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class RecommendCard extends StatelessWidget {
  const RecommendCard({
    super.key, 
    this.color,
    this.title,
    this.image,
    this.textBeforeDot = "MEDITATION",
    this.textAfterDot = "3 - 10 MIN",
    this.titleColor = const Color(0xff3F414E),
    this.subtitleColor = const Color(0xffA1A4B2),
    this.dotColor = const Color(0xffA1A4B2),
    this.onTap,
    this.audio,
    this.showFavorite = false,
  });
  final Color? color;
  final String? title;
  final String? image;
  final String textBeforeDot;
  final String textAfterDot;
  final Color titleColor;
  final Color subtitleColor;
  final Color dotColor;
  final VoidCallback? onTap;
  final Audio? audio;
  final bool showFavorite;

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? (audio?.img != null ? Color(0xff3F414E) : Color(0xffAFDBC5));
    final displayTitle = title ?? audio?.title ?? "Unknown";
    final displayImage = image ?? audio?.img ?? "assets/images/home/floating_meditate.png";
    final displayTextBeforeDot = audio?.textBeforeDot ?? textBeforeDot;
    final displayTextAfterDot = audio?.textAfterDot ?? textAfterDot;

    return InkWell(
      onTap: onTap ?? () {
        if (audio != null) {
          if (audio!.category == Category.sleep) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SleepHighlightPage(
              image: displayImage, 
              title: displayTitle, 
              textBeforeDot: displayTextBeforeDot, 
              textAfterDot: displayTextAfterDot
            )));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: displayTitle)));
          }
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SleepHighlightPage(
            image: displayImage, 
            title: displayTitle, 
            textBeforeDot: displayTextBeforeDot, 
            textAfterDot: displayTextAfterDot
          )));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Container(
            width: 162,
            height: 113,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: displayColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(displayImage))
            ),
          ),
          Text(displayTitle,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
           Text.rich(
            TextSpan(text: "$displayTextBeforeDot  ",
            style: TextStyle(
              color: subtitleColor,
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
                  color: dotColor
                ),
              )
              ),
              TextSpan(
                text: " $displayTextAfterDot",
                style: TextStyle(
                color: subtitleColor,
                fontWeight: FontWeight.w500
                )
              )
            ]
            ),
          )
        ],
      ),
    );
  }
}

class HomePageCardTop extends StatelessWidget {
  const HomePageCardTop({
    super.key, required this.color, required this.image, required this.title, required this.label, required this.buttonBackgroundColor, required this.buttonForegroundColor, required this.textColor,
  });
  final Color color;
  final String image;
  final String title;
  final String label;
  final Color buttonBackgroundColor;
  final Color buttonForegroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: title))),
      child: Container(
        height: 240,
        width: MediaQuery.of(context).size.width / 2 - 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(image, width: title == "Basics" ? 100 : 200,)
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                            ),
                          ),
                          Text(label,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("3-10 MIN",
                           style: TextStyle(
                              color: textColor,
                              fontSize: 16
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.white),
                              foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E))
                            ),
                            onPressed: (){}, 
                            child: Text("START")
                            )
                        ],
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}