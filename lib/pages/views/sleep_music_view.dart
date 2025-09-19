import 'package:flutter/material.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                      RecommendCard(title: "Night Island", color: Color(0xff3F414E), image: "assets/images/sleep/moon_clouds.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Sweet Sleep", color: Color(0xff3F414E), image: "assets/images/sleep/sweet_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Good Night", color: Color(0xff3F414E), image: "assets/images/sleep/good_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Night Island", color: Color(0xff3F414E), image: "assets/images/sleep/cloud_pink_moon.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Night Island", color: Color(0xff3F414E), image: "assets/images/sleep/moon_clouds.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Sweet Sleep", color: Color(0xff3F414E), image: "assets/images/sleep/sweet_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Good Night", color: Color(0xff3F414E), image: "assets/images/sleep/good_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Night Island", color: Color(0xff3F414E), image: "assets/images/sleep/moon_clouds.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Night Island", color: Color(0xff3F414E), image: "assets/images/sleep/moon_clouds.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Sweet Sleep", color: Color(0xff3F414E), image: "assets/images/sleep/sweet_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Good Night", color: Color(0xff3F414E), image: "assets/images/sleep/good_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                      RecommendCard(title: "Night Island", color: Color(0xff3F414E), image: "assets/images/sleep/moon_clouds.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}